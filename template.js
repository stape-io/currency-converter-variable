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

const eventData = getAllEventData();

if (shouldExitEarly(eventData)) return undefined;

const toCurrency = normalizeCurrency(data.toCurrency);
if (!toCurrency) return undefined;

const provider = getProvider(data.apiProvider);
const fromCurrency = resolveFromCurrency(data, eventData);
return getRateData(provider, fromCurrency, toCurrency).then((rateData) => {
  const amount =
    data.whatToReturn === 'convertedAmount' ? resolveAmount(data, eventData) : undefined;
  return formatOutput(rateData, amount);
});

/*==============================================================================
  Vendor related functions
==============================================================================*/

function getProvider(apiProvider) {
  if (apiProvider === 'xe') {
    const margin = resolveMargin();
    const marginKey = margin === undefined ? '' : makeString(margin);
    const credentials = makeString(data.accountId) + ':' + makeString(data.apiKey);

    return {
      name: 'xe',
      cacheScope: makeString(data.accountId) + '|' + marginKey,
      headers: { Authorization: 'Basic ' + toBase64(credentials), Accept: 'application/json' },
      buildUrls: (fromCurrency, toCurrency) => {
        const url =
          'https://xecdapi.xe.com/v1/convert_from?from=' +
          enc(fromCurrency) +
          '&to=' +
          enc(toCurrency) +
          '&amount=1';
        return [margin === undefined ? url : url + '&margin=' + enc(margin)];
      },
      extractRate: (body, fromCurrency, toCurrency) => {
        const rates = body.to;
        if (getType(rates) !== 'array') return undefined;

        for (let i = 0; i < rates.length; i++) {
          if (rates[i] && rates[i].quotecurrency === toCurrency) return rates[i].mid;
        }

        return undefined;
      },
      extractDate: (body) => body.timestamp
    };
  }

  if (apiProvider === 'exchangeApi') {
    return {
      name: 'exchangeApi',
      headers: { Accept: 'application/json' },
      buildUrls: (fromCurrency) => {
        const path = '/v1/currencies/' + enc(fromCurrency.toLowerCase()) + '.min.json';
        return [
          'https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest' + path,
          'https://latest.currency-api.pages.dev' + path
        ];
      },
      extractRate: (body, fromCurrency, toCurrency) => {
        const rates = body[fromCurrency.toLowerCase()];
        return getType(rates) === 'object' ? rates[toCurrency.toLowerCase()] : undefined;
      },
      extractDate: (body) => body.date
    };
  }

  return {
    name: 'frankfurter',
    headers: { Accept: 'application/json' },
    buildUrls: (fromCurrency, toCurrency) => [
      'https://api.frankfurter.dev/v2/rate/' + enc(fromCurrency) + '/' + enc(toCurrency)
    ],
    extractRate: (body) => body.rate,
    extractDate: (body) => body.date
  };
}

function getRateData(provider, fromCurrency, toCurrency) {
  const cacheKey = buildCacheKey(provider, fromCurrency, toCurrency);

  const cachedRateData = readCache(cacheKey);
  if (cachedRateData) return Promise.create((resolve) => resolve(cachedRateData));

  const parseBody = (body) => parseRateData(provider, body, fromCurrency, toCurrency);

  const urls = provider.buildUrls(fromCurrency, toCurrency);

  return requestFirstValidRateData(provider.headers, urls, parseBody).then((rateData) => {
    if (rateData) writeCache(cacheKey, rateData);
    return rateData;
  });
}

function requestFirstValidRateData(headers, urls, parseBody) {
  if (!urls.length) return Promise.create((resolve) => resolve(undefined));

  return sendHttpRequest(urls[0], { method: 'GET', headers: headers, timeout: 3000 })
    .then((result) => {
      if (result.statusCode < 200 || result.statusCode >= 300) return undefined;
      return parseBody(safeJsonParse(result.body));
    })
    .catch(() => undefined)
    .then((rateData) => rateData || requestFirstValidRateData(headers, urls.slice(1), parseBody));
}

function parseRateData(provider, body, fromCurrency, toCurrency) {
  if (getType(body) !== 'object') return undefined;

  const rate = provider.extractRate(body, fromCurrency, toCurrency);
  if (!isValidNumber(rate)) return undefined;

  return { date: provider.extractDate(body), base: fromCurrency, quote: toCurrency, rate: rate };
}

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

function formatOutput(rateData, amount) {
  if (!rateData) return undefined;
  if (data.whatToReturn === 'rateData') return rateData;
  if (data.whatToReturn === 'exchangeRate') return roundValue(rateData.rate);

  // A provided but invalid Amount must not be reported as a converted value of 1 unit.
  if (amount === undefined) return undefined;
  return roundValue(rateData.rate * amount);
}

/*==============================================================================
  Input resolution
==============================================================================*/

function resolveMargin() {
  if (!isValidValue(data.margin)) return undefined;

  const margin = makeNumber(data.margin);
  return isValidNumber(margin) ? margin : undefined;
}

function resolveFromCurrency(data, eventData) {
  let currency = data.fromCurrency;
  if (!isValidValue(currency) && data.autoMapEventData) currency = eventData.currency;
  return normalizeCurrency(currency) || 'USD';
}

function resolveAmount(data, eventData) {
  let rawAmount = data.amount;
  if (!isValidValue(rawAmount) && data.autoMapEventData) rawAmount = eventData.value;
  if (!isValidValue(rawAmount)) return 1;

  const amount = makeNumber(rawAmount);
  return isValidNumber(amount) ? amount : undefined;
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

function buildCacheKey(provider, fromCurrency, toCurrency) {
  const scope = provider.cacheScope === undefined ? '' : provider.cacheScope + '|';
  return 'rate|' + provider.name + '|' + scope + fromCurrency + '|' + toCurrency;
}

function readCache(cacheKey) {
  const cacheTtl = resolveCacheTtlMillis();
  if (!cacheTtl) return undefined;

  const cached = templateDataStorage.getItemCopy(cacheKey);
  if (getType(cached) !== 'object' || !isValidNumber(cached.ts)) return undefined;
  if (cached.ts + cacheTtl <= getTimestampMillis()) return undefined;

  return cached.rateData;
}

function writeCache(cacheKey, rateData) {
  if (!resolveCacheTtlMillis()) return;
  templateDataStorage.setItemCopy(cacheKey, { ts: getTimestampMillis(), rateData: rateData });
}

function resolveCacheTtlMillis() {
  if (!data.useCache) return 0;

  const minutes = makeNumber(data.cacheTtlMinutes);
  const ttlMinutes = isValidNumber(minutes) && minutes > 0 ? minutes : 60;
  return ttlMinutes * 60 * 1000;
}

/*==============================================================================
  Helpers
==============================================================================*/

function shouldExitEarly(eventData) {
  const url = eventData.page_location || getRequestHeader('referer');
  if (url && url.lastIndexOf('https://gtm-msr.appspot.com/', 0) === 0) return true;

  const isMissingCredentials = !isValidValue(data.accountId) || !isValidValue(data.apiKey);
  return data.apiProvider === 'xe' && isMissingCredentials;
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
