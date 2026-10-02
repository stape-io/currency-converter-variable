const encodeUriComponent = require('encodeUriComponent');
const getAllEventData = require('getAllEventData');
const getRequestHeader = require('getRequestHeader');
const getTimestampMillis = require('getTimestampMillis');
const getType = require('getType');
const JSON = require('JSON');
const makeNumber = require('makeNumber');
const makeString = require('makeString');
const Math = require('Math');
const Promise = require('Promise');
const sendHttpRequest = require('sendHttpRequest');
const templateDataStorage = require('templateDataStorage');
const toBase64 = require('toBase64');

/*==============================================================================
==============================================================================*/

const API_URL = 'https://xecdapi.xe.com/v1/convert_from';
const REQUEST_TIMEOUT = 3000;
const DEFAULT_FROM_CURRENCY = 'USD';
const DEFAULT_CACHE_TTL_MINUTES = 60;

const eventData = getAllEventData();

if (shouldExitEarly(data, eventData)) return undefined;

const fromCurrency = resolveFromCurrency(data, eventData);
const toCurrency = normalizeCurrency(data.toCurrency);
const amount = resolveAmount(data, eventData);

if (!toCurrency) return undefined;

return getRateResponse(fromCurrency, toCurrency).then((response) =>
  formatOutput(response, toCurrency, amount)
);

/*==============================================================================
  Vendor related functions
==============================================================================*/

function getRateResponse(fromCurrency, toCurrency) {
  const margin = resolveMargin();
  const cacheKey = buildCacheKey(fromCurrency, toCurrency, margin);

  const cachedResponse = readCache(cacheKey);
  if (cachedResponse) return Promise.create((resolve) => resolve(cachedResponse));

  return sendHttpRequest(buildRequestUrl(fromCurrency, toCurrency, margin), buildRequestOptions())
    .then((result) => {
      if (result.statusCode < 200 || result.statusCode >= 300) return undefined;

      const response = safeJsonParse(result.body);
      if (getType(response) !== 'object') return undefined;

      if (extractRate(response, toCurrency) !== undefined) writeCache(cacheKey, response);
      return response;
    })
    .catch(() => undefined);
}

// JSON.parse throws on malformed input (e.g. an HTML error page), so check the shape first.
function safeJsonParse(body) {
  if (getType(body) !== 'string') return undefined;

  const trimmedBody = body.trim();
  const firstChar = trimmedBody.charAt(0);
  const lastChar = trimmedBody.charAt(trimmedBody.length - 1);
  const looksLikeJson =
    (firstChar === '{' && lastChar === '}') || (firstChar === '[' && lastChar === ']');
  if (!looksLikeJson) return undefined;

  return JSON.parse(trimmedBody);
}

function buildRequestUrl(fromCurrency, toCurrency, margin) {
  let url = API_URL + '?from=' + enc(fromCurrency) + '&to=' + enc(toCurrency) + '&amount=1';
  if (margin !== undefined) url += '&margin=' + enc(margin);
  return url;
}

function buildRequestOptions() {
  const credentials = makeString(data.accountId) + ':' + makeString(data.apiKey);
  return {
    method: 'GET',
    headers: {
      Authorization: 'Basic ' + toBase64(credentials),
      Accept: 'application/json'
    },
    timeout: REQUEST_TIMEOUT
  };
}

function formatOutput(response, toCurrency, amount) {
  if (!response) return undefined;
  if (data.whatToReturn === 'allData') return response;

  const rate = extractRate(response, toCurrency);
  if (rate === undefined) return undefined;

  if (data.whatToReturn === 'exchangeRate') return roundValue(rate);

  // A provided but invalid Amount must not be reported as a converted value of 1 unit.
  if (amount === undefined) return undefined;
  return roundValue(rate * amount);
}

function extractRate(response, toCurrency) {
  const rates = response.to;
  if (getType(rates) !== 'array') return undefined;

  for (let i = 0; i < rates.length; i++) {
    const rate = rates[i];
    if (rate && rate.quotecurrency === toCurrency && isValidNumber(rate.mid)) return rate.mid;
  }

  return undefined;
}

/*==============================================================================
  Input resolution
==============================================================================*/

function resolveFromCurrency(data, eventData) {
  let currency = data.fromCurrency;
  if (!isValidValue(currency) && data.autoMapEventData) currency = eventData.currency;
  return normalizeCurrency(currency) || DEFAULT_FROM_CURRENCY;
}

function resolveAmount(data, eventData) {
  let rawAmount = data.amount;
  if (!isValidValue(rawAmount) && data.autoMapEventData) rawAmount = eventData.value;
  if (!isValidValue(rawAmount)) return 1;

  const amount = makeNumber(rawAmount);
  return isValidNumber(amount) ? amount : undefined;
}

function resolveMargin() {
  if (!isValidValue(data.margin)) return undefined;

  const margin = makeNumber(data.margin);
  return isValidNumber(margin) ? margin : undefined;
}

function normalizeCurrency(value) {
  if (!isValidValue(value)) return '';
  return makeString(value).trim().toUpperCase();
}

function roundValue(value) {
  if (!isValidValue(data.decimalPlaces)) return value;

  const decimalPlaces = makeNumber(data.decimalPlaces);
  if (!isValidNumber(decimalPlaces) || decimalPlaces < 0) return value;

  const factor = Math.pow(10, Math.round(decimalPlaces));
  return Math.round(value * factor) / factor;
}

/*==============================================================================
  Cache
==============================================================================*/

function buildCacheKey(fromCurrency, toCurrency, margin) {
  const marginKey = margin === undefined ? '' : makeString(margin);

  return (
    'xe_rate|' +
    makeString(data.accountId) +
    '|' +
    fromCurrency +
    '|' +
    toCurrency +
    '|' +
    marginKey
  );
}

function readCache(cacheKey) {
  const cacheTtl = resolveCacheTtlMillis();
  if (!cacheTtl) return undefined;

  const cached = templateDataStorage.getItemCopy(cacheKey);
  if (getType(cached) !== 'object' || !isValidNumber(cached.ts)) return undefined;
  if (cached.ts + cacheTtl <= getTimestampMillis()) return undefined;

  return cached.response;
}

function writeCache(cacheKey, response) {
  if (!resolveCacheTtlMillis()) return;
  templateDataStorage.setItemCopy(cacheKey, { ts: getTimestampMillis(), response: response });
}

function resolveCacheTtlMillis() {
  if (!data.useCache) return 0;

  const minutes = makeNumber(data.cacheTtlMinutes);
  const ttlMinutes = isValidNumber(minutes) && minutes > 0 ? minutes : DEFAULT_CACHE_TTL_MINUTES;
  return ttlMinutes * 60 * 1000;
}

/*==============================================================================
  Helpers
==============================================================================*/

function shouldExitEarly(data, eventData) {
  const url = eventData.page_location || getRequestHeader('referer');
  if (url && url.lastIndexOf('https://gtm-msr.appspot.com/', 0) === 0) return true;
  if (!isValidValue(data.accountId) || !isValidValue(data.apiKey)) return true;
  return false;
}

function isValidValue(value) {
  const valueType = getType(value);
  if (valueType === 'null' || valueType === 'undefined' || value !== value) return false;
  return value !== '' && value !== 'undefined' && value !== 'null';
}

function isValidNumber(value) {
  return getType(value) === 'number' && value === value;
}

function enc(value) {
  if (['null', 'undefined'].indexOf(getType(value)) !== -1) value = '';
  return encodeUriComponent(makeString(value));
}
