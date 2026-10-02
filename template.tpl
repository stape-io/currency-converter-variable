___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Currency Converter For Google Tag Manager",
  "description": "Converts a monetary amount from one currency to another using live mid-market exchange rates from the Xe Currency Data API.",
  "containerContexts": [
    "SERVER"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "GROUP",
    "name": "authGroup",
    "displayName": "",
    "groupStyle": "NO_ZIPPY",
    "subParams": [
      {
        "type": "TEXT",
        "name": "accountId",
        "displayName": "Account ID",
        "simpleValueType": true,
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ],
        "alwaysInSummary": true,
        "help": "Your Xe Currency Data API account ID.\n\u003cbr/\u003e\u003cbr/\u003e\nLearn more: \u003ca href\u003d\"https://help.xe.com/hc/en-gb/articles/17085932359057-Where-can-I-find-my-Account-ID-and-API-Key-for-Xe-s-Currency-Data-plugin-on-Business-Central\"\u003e[1]\u003c/a\u003e and \u003ca href\u003d\"https://developers.xe.com/docs/currency-data-api/registration-overview#step-3--find-your-credentials\"\u003e[2]\u003c/a\u003e."
      },
      {
        "type": "TEXT",
        "name": "apiKey",
        "displayName": "API Key",
        "simpleValueType": true,
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ],
        "help": "Your Xe Currency Data API key.\n\u003cbr/\u003e\u003cbr/\u003e\nLearn more: \u003ca href\u003d\"https://help.xe.com/hc/en-gb/articles/17085932359057-Where-can-I-find-my-Account-ID-and-API-Key-for-Xe-s-Currency-Data-plugin-on-Business-Central\"\u003e[1]\u003c/a\u003e and \u003ca href\u003d\"https://developers.xe.com/docs/currency-data-api/registration-overview#step-3--find-your-credentials\"\u003e[2]\u003c/a\u003e."
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "conversionGroup",
    "displayName": "",
    "groupStyle": "NO_ZIPPY",
    "subParams": [
      {
        "type": "TEXT",
        "name": "fromCurrency",
        "displayName": "From Currency",
        "simpleValueType": true,
        "valueValidators": [
          {
            "type": "REGEX",
            "args": [
              "^[A-Za-z]{3}$"
            ],
            "errorMessage": "Must be a 3-letter ISO 4217 currency code, e.g. USD.",
            "enablingConditions": [
              {
                "paramName": "autoMapEventData",
                "paramValue": true,
                "type": "NOT_EQUALS"
              }
            ]
          },
          {
            "type": "NON_EMPTY",
            "enablingConditions": [
              {
                "paramName": "autoMapEventData",
                "paramValue": true,
                "type": "NOT_EQUALS"
              }
            ]
          }
        ],
        "valueHint": "USD",
        "help": "ISO 4217 code of the currency the amount is converted from.\u003cbr/\u003e\u003cbr/\u003eFalls back to \u003ci\u003eeventData.currency\u003c/i\u003e when left empty and \u003ci\u003eAutomap from Event Data\u003c/i\u003e is enabled, and to \u003ci\u003eUSD\u003c/i\u003e when neither is set."
      },
      {
        "type": "TEXT",
        "name": "toCurrency",
        "displayName": "To Currency",
        "simpleValueType": true,
        "valueValidators": [
          {
            "type": "NON_EMPTY",
            "enablingConditions": []
          },
          {
            "type": "REGEX",
            "args": [
              "^[A-Za-z]{3}$"
            ],
            "errorMessage": "Must be a 3-letter ISO 4217 currency code, e.g. EUR.",
            "enablingConditions": []
          }
        ],
        "alwaysInSummary": true,
        "valueHint": "EUR",
        "help": "ISO 4217 code of the currency the amount is converted to. The full list of codes is available \u003ca href\u003d\"https://www.xe.com/iso4217.php\"\u003ehere\u003c/a\u003e."
      },
      {
        "type": "TEXT",
        "name": "amount",
        "displayName": "Amount",
        "simpleValueType": true,
        "valueHint": "99.90",
        "help": "The amount of the From Currency to convert.\u003cbr/\u003e\u003cbr/\u003eFalls back to \u003ci\u003eeventData.value\u003c/i\u003e when left empty and \u003ci\u003eAutomap from Event Data\u003c/i\u003e is enabled, and to \u003ci\u003e1\u003c/i\u003e when neither is set. The variable returns \u003ci\u003eundefined\u003c/i\u003e when the value is not a number.",
        "valueValidators": [
          {
            "type": "NON_EMPTY",
            "enablingConditions": [
              {
                "paramName": "autoMapEventData",
                "paramValue": true,
                "type": "NOT_EQUALS"
              }
            ]
          }
        ]
      },
      {
        "type": "CHECKBOX",
        "name": "autoMapEventData",
        "checkboxText": "Automap from Event Data",
        "simpleValueType": true,
        "defaultValue": true,
        "help": "When enabled (default), fields left empty fall back to values from Event Data, as documented in each field\u0027s help text. Disable to require every value to be set explicitly on this variable.\u003cbr/\u003e\u003cbr/\u003eDefault mappings:\u003cul\u003e\u003cli\u003e\u003ci\u003eFrom Currency\u003c/i\u003e: \u003ci\u003eeventData.currency\u003c/i\u003e\u003c/li\u003e\u003cli\u003e\u003ci\u003eAmount\u003c/i\u003e: \u003ci\u003eeventData.value\u003c/i\u003e\u003c/li\u003e\u003c/ul\u003e"
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "outputGroup",
    "displayName": "",
    "groupStyle": "NO_ZIPPY",
    "subParams": [
      {
        "type": "SELECT",
        "name": "whatToReturn",
        "displayName": "What To Return",
        "macrosInSelect": false,
        "selectItems": [
          {
            "value": "convertedAmount",
            "displayValue": "Converted Amount"
          },
          {
            "value": "exchangeRate",
            "displayValue": "Exchange Rate"
          },
          {
            "value": "allData",
            "displayValue": "Full API Response"
          }
        ],
        "simpleValueType": true,
        "defaultValue": "convertedAmount",
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ],
        "help": "\u003cul\u003e\n  \u003cli\u003e\u003cb\u003eConverted Amount\u003c/b\u003e: the Amount multiplied by the mid-market exchange rate.\u003c/li\u003e\n  \u003cli\u003e\u003cb\u003eExchange Rate\u003c/b\u003e: the mid-market rate for a single unit of the From Currency.\u003c/li\u003e\n  \u003cli\u003e\u003cb\u003eFull API Response\u003c/b\u003e: the parsed Xe API response object. Rates are always requested for a single unit, so \u003ci\u003eto[0].mid\u003c/i\u003e holds the exchange rate rather than the converted amount.\u003c/li\u003e\n\u003c/ul\u003e\nWhen a \u003cb\u003eMargin\u003c/b\u003e is set, the rate and the converted amount include it and are no longer the plain mid-market values.\u003cbr/\u003e\u003cbr/\u003eThe variable returns \u003ci\u003eundefined\u003c/i\u003e when the rate cannot be retrieved, or when Converted Amount is selected and the Amount is not a number."
      },
      {
        "type": "TEXT",
        "name": "decimalPlaces",
        "displayName": "Decimal Places",
        "simpleValueType": true,
        "valueHint": "2",
        "help": "Number of decimal places the returned number is rounded to. Leave empty to return the value at full precision.",
        "valueValidators": [
          {
            "type": "NON_NEGATIVE_NUMBER"
          }
        ],
        "enablingConditions": [
          {
            "paramName": "whatToReturn",
            "paramValue": "allData",
            "type": "NOT_EQUALS"
          }
        ]
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "advancedSettingsGroup",
    "displayName": "Advanced Settings",
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {
        "type": "TEXT",
        "name": "margin",
        "displayName": "Margin (%)",
        "simpleValueType": true,
        "valueHint": "2.05",
        "help": "Optional percentage margin (+/-) that Xe applies on top of its mid-market rate. For example, \u003ci\u003e2.05\u003c/i\u003e returns the mid-market rate plus 2.05%."
      },
      {
        "type": "CHECKBOX",
        "name": "useCache",
        "checkboxText": "Store exchange rates in cache",
        "simpleValueType": true,
        "defaultValue": true,
        "help": "Caches the exchange rate in Template Storage, so that repeated conversions of the same currency pair do not consume Xe API quota. Rates are always requested for a single unit, which means one cached entry serves every amount."
      },
      {
        "type": "TEXT",
        "name": "cacheTtlMinutes",
        "displayName": "Cache TTL",
        "simpleValueType": true,
        "defaultValue": 60,
        "valueHint": "60",
        "help": "How long a cached exchange rate stays valid. Defaults to 60 minutes when left empty or invalid.",
        "valueValidators": [
          {
            "type": "POSITIVE_NUMBER"
          }
        ],
        "enablingConditions": [
          {
            "paramName": "useCache",
            "paramValue": true,
            "type": "EQUALS"
          }
        ],
        "valueUnit": "minutes"
      }
    ]
  }
]


___SANDBOXED_JS_FOR_SERVER___

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


___SERVER_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "read_event_data",
        "versionId": "1"
      },
      "param": [
        {
          "key": "eventDataAccess",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "read_request",
        "versionId": "1"
      },
      "param": [
        {
          "key": "headerWhitelist",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "headerName"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "referer"
                  }
                ]
              }
            ]
          }
        },
        {
          "key": "headersAllowed",
          "value": {
            "type": 8,
            "boolean": true
          }
        },
        {
          "key": "requestAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "headerAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "queryParameterAccess",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "send_http",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedUrls",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "urls",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "https://xecdapi.xe.com/v1/convert_from*"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_template_storage",
        "versionId": "1"
      },
      "param": []
    },
    "isRequired": true
  }
]


___TESTS___

scenarios:
- name: '[Early Exit] Returns undefined and makes no request when the URL matches
    the GTM preview endpoint'
  code: |-
    mock('getAllEventData', () => ({page_location: 'https://gtm-msr.appspot.com/render'}));

    const variableResult = runCode(mockData);

    assertThat(variableResult).isUndefined();
    assertApi('sendHttpRequest').wasNotCalled();
- name: '[Early Exit] Returns undefined and makes no request when the referer header
    matches the GTM preview endpoint'
  code: |-
    mock('getAllEventData', () => ({}));
    mock('getRequestHeader', (header) =>
      header === 'referer' ? 'https://gtm-msr.appspot.com/render' : undefined
    );

    const variableResult = runCode(mockData);

    assertThat(variableResult).isUndefined();
    assertApi('sendHttpRequest').wasNotCalled();
- name: '[Early Exit] Returns undefined and makes no request when API credentials
    are missing'
  code: |-
    const variableResult = runCode(createMockData({apiKey: undefined}));

    assertThat(variableResult).isUndefined();
    assertApi('sendHttpRequest').wasNotCalled();
- name: '[Early Exit] Returns undefined and makes no request when To Currency is missing'
  code: |-
    const variableResult = runCode(createMockData({toCurrency: ''}));

    assertThat(variableResult).isUndefined();
    assertApi('sendHttpRequest').wasNotCalled();
- name: '[Request] Requests the rate for a single unit with Basic authentication'
  code: |-
    runCode(mockData).then(() => {
      assertApi('sendHttpRequest').wasCalledWith(
        'https://xecdapi.xe.com/v1/convert_from?from=USD&to=EUR&amount=1',
        expectedRequestOptions
      );
    });
- name: '[Request] Appends the margin parameter when a margin is configured'
  code: |-
    runCode(createMockData({margin: '2.05'})).then(() => {
      assertApi('sendHttpRequest').wasCalledWith(
        'https://xecdapi.xe.com/v1/convert_from?from=USD&to=EUR&amount=1&margin=2.05',
        expectedRequestOptions
      );
    });
- name: '[Request] Trims and upper-cases the configured currency codes'
  code: |-
    runCode(createMockData({fromCurrency: ' usd ', toCurrency: 'eur'})).then((variableResult) => {
      assertApi('sendHttpRequest').wasCalledWith(
        'https://xecdapi.xe.com/v1/convert_from?from=USD&to=EUR&amount=1',
        expectedRequestOptions
      );
      assertThat(variableResult).isEqualTo(87.65);
    });
- name: '[Automap] Falls back to the Event Data currency and value when the fields
    are empty'
  code: |-
    mock('getAllEventData', () => ({
      page_location: 'https://example.com/checkout',
      currency: 'GBP',
      value: 250
    }));
    mockSuccessfulResponse(createRateResponse('GBP', 'EUR', RATE));

    runCode(createMockData({fromCurrency: '', amount: ''})).then((variableResult) => {
      assertApi('sendHttpRequest').wasCalledWith(
        'https://xecdapi.xe.com/v1/convert_from?from=GBP&to=EUR&amount=1',
        expectedRequestOptions
      );
      assertThat(variableResult).isEqualTo(219.14);
    });
- name: '[Automap] Ignores Event Data and applies the defaults when automap is disabled'
  code: |-
    mock('getAllEventData', () => ({
      page_location: 'https://example.com/checkout',
      currency: 'GBP',
      value: 250
    }));

    const overrides = {fromCurrency: '', amount: '', autoMapEventData: false};

    runCode(createMockData(overrides)).then((variableResult) => {
      assertApi('sendHttpRequest').wasCalledWith(
        'https://xecdapi.xe.com/v1/convert_from?from=USD&to=EUR&amount=1',
        expectedRequestOptions
      );
      assertThat(variableResult).isEqualTo(0.88);
    });
- name: '[Amount] Returns undefined when the configured amount is not a number'
  code: |-
    runCode(createMockData({amount: 'not-a-number'})).then((variableResult) => {
      assertThat(variableResult).isUndefined();
    });
- name: '[Amount] Still returns the exchange rate when the configured amount is not
    a number'
  code: |-
    runCode(createMockData({amount: 'not-a-number', whatToReturn: 'exchangeRate'})).then(
      (variableResult) => {
        assertThat(variableResult).isEqualTo(0.88);
      }
    );
- name: '[Amount] Converts a zero amount to zero'
  code: |-
    runCode(createMockData({amount: '0'})).then((variableResult) => {
      assertThat(variableResult).isEqualTo(0);
    });
- name: '[Output] Returns the converted amount rounded to the configured decimal places'
  code: |-
    runCode(mockData).then((variableResult) => {
      assertThat(variableResult).isEqualTo(87.65);
    });
- name: '[Output] Returns the exchange rate when Exchange Rate is selected'
  code: |-
    runCode(createMockData({whatToReturn: 'exchangeRate'})).then((variableResult) => {
      assertThat(variableResult).isEqualTo(0.88);
    });
- name: '[Output] Returns the value at full precision when Decimal Places is empty'
  code: |-
    runCode(createMockData({whatToReturn: 'exchangeRate', decimalPlaces: ''})).then(
      (variableResult) => {
        assertThat(variableResult).isEqualTo(RATE);
      }
    );
- name: '[Output] Returns the parsed API response when Full API Response is selected'
  code: |-
    const rateResponse = createRateResponse('USD', 'EUR', RATE);
    mockSuccessfulResponse(rateResponse);

    runCode(createMockData({whatToReturn: 'allData'})).then((variableResult) => {
      assertThat(variableResult).isEqualTo(rateResponse);
    });
- name: '[Failure] Returns undefined when the API responds with a non-2xx status code'
  code: |-
    mock('sendHttpRequest', () =>
      Promise.create((resolve) =>
        resolve({statusCode: 401, body: '{"code":1,"message":"Bad credentials"}'})
      )
    );

    runCode(mockData).then((variableResult) => {
      assertThat(variableResult).isUndefined();
    });
- name: '[Failure] Returns undefined when the response body is not valid JSON'
  code: |-
    mock('sendHttpRequest', () =>
      Promise.create((resolve) => resolve({statusCode: 200, body: '<html>Bad Gateway</html>'}))
    );

    runCode(mockData).then((variableResult) => {
      assertThat(variableResult).isUndefined();
    });
- name: '[Failure] Returns undefined when the response body is empty'
  code: |-
    mock('sendHttpRequest', () =>
      Promise.create((resolve) => resolve({statusCode: 200, body: ''}))
    );

    runCode(mockData).then((variableResult) => {
      assertThat(variableResult).isUndefined();
    });
- name: '[Failure] Returns undefined when the request fails or times out'
  code: |-
    mock('sendHttpRequest', () =>
      Promise.create((resolve, reject) => reject({reason: 'timed_out'}))
    );

    runCode(mockData).then((variableResult) => {
      assertThat(variableResult).isUndefined();
    });
- name: '[Failure] Returns undefined when the response holds no rate for the requested
    currency'
  code: |-
    mockSuccessfulResponse(createRateResponse('USD', 'GBP', RATE));

    runCode(mockData).then((variableResult) => {
      assertThat(variableResult).isUndefined();
    });
- name: '[Cache] Serves a valid cached rate without calling the API'
  code: |-
    let requestedKey;

    mockObject('templateDataStorage', {
      getItemCopy: (key) => {
        requestedKey = key;
        return {ts: NOW, response: createRateResponse('USD', 'EUR', RATE)};
      },
      setItemCopy: () => {}
    });

    runCode(createMockData({useCache: true})).then((variableResult) => {
      assertApi('sendHttpRequest').wasNotCalled();
      assertThat(requestedKey).isEqualTo('xe_rate|testAccountId|USD|EUR|');
      assertThat(variableResult).isEqualTo(87.65);
    });
- name: '[Cache] Requests a fresh rate when the cached entry has expired'
  code: |-
    mockObject('templateDataStorage', {
      getItemCopy: () => ({
        ts: NOW - 60 * 60 * 1000,
        response: createRateResponse('USD', 'EUR', RATE)
      }),
      setItemCopy: () => {}
    });

    runCode(createMockData({useCache: true})).then(() => {
      assertApi('sendHttpRequest').wasCalled();
    });
- name: '[Cache] Falls back to the default TTL when Cache TTL is empty'
  code: |-
    mockObject('templateDataStorage', {
      getItemCopy: () => ({
        ts: NOW - 59 * 60 * 1000,
        response: createRateResponse('USD', 'EUR', RATE)
      }),
      setItemCopy: () => {}
    });

    runCode(createMockData({useCache: true, cacheTtlMinutes: ''})).then(() => {
      assertApi('sendHttpRequest').wasNotCalled();
    });
- name: '[Cache] Stores a successful response under a margin-aware cache key'
  code: |-
    let storedKey;
    let storedValue;

    mockObject('templateDataStorage', {
      getItemCopy: () => undefined,
      setItemCopy: (key, value) => {
        storedKey = key;
        storedValue = value;
      }
    });

    runCode(createMockData({useCache: true, margin: '2.05'})).then(() => {
      assertThat(storedKey).isEqualTo('xe_rate|testAccountId|USD|EUR|2.05');
      assertThat(storedValue.ts).isEqualTo(NOW);
      assertThat(storedValue.response).isEqualTo(createRateResponse('USD', 'EUR', RATE));
    });
- name: '[Cache] Does not store a response that holds no rate for the requested currency'
  code: |-
    let storeCalls = 0;

    mockObject('templateDataStorage', {
      getItemCopy: () => undefined,
      setItemCopy: () => {
        storeCalls++;
      }
    });
    mockSuccessfulResponse(createRateResponse('USD', 'GBP', RATE));

    runCode(createMockData({useCache: true})).then((variableResult) => {
      assertThat(variableResult).isUndefined();
      assertThat(storeCalls).isEqualTo(0);
    });
- name: '[Cache] Neither reads nor writes Template Storage when caching is disabled'
  code: |-
    let storageCalls = 0;

    mockObject('templateDataStorage', {
      getItemCopy: () => {
        storageCalls++;
        return undefined;
      },
      setItemCopy: () => {
        storageCalls++;
      }
    });

    runCode(createMockData({useCache: false})).then(() => {
      assertApi('sendHttpRequest').wasCalled();
      assertThat(storageCalls).isEqualTo(0);
    });
setup: |-
  const JSON = require('JSON');
  const Object = require('Object');
  const Promise = require('Promise');
  const toBase64 = require('toBase64');

  const assign = (target, source) => {
    if (!source) return target;
    const keys = Object.keys(source);
    keys.forEach((key) => {
      target[key] = source[key];
    });
    return target;
  };

  const NOW = 1000000000000;
  const RATE = 0.876543;

  const createRateResponse = (from, to, mid) => ({
    terms: 'https://www.xe.com/legal/dfs.php',
    privacy: 'https://www.xe.com/privacy.php',
    from: from,
    amount: 1,
    timestamp: '2026-09-18T00:00:00Z',
    to: [{quotecurrency: to, mid: mid}]
  });

  const mockSuccessfulResponse = (response) => {
    mock('sendHttpRequest', () =>
      Promise.create((resolve) => resolve({statusCode: 200, body: JSON.stringify(response)}))
    );
  };

  const expectedRequestOptions = {
    method: 'GET',
    headers: {
      Authorization: 'Basic ' + toBase64('testAccountId:testApiKey'),
      Accept: 'application/json'
    },
    timeout: 3000
  };

  const baseMockData = {
    accountId: 'testAccountId',
    apiKey: 'testApiKey',
    fromCurrency: 'USD',
    toCurrency: 'EUR',
    amount: '100',
    autoMapEventData: true,
    whatToReturn: 'convertedAmount',
    decimalPlaces: '2',
    margin: undefined,
    useCache: false,
    cacheTtlMinutes: '60'
  };

  const createMockData = (overrides) => assign(assign({}, baseMockData), overrides || {});

  mock('getAllEventData', () => ({page_location: 'https://example.com/checkout'}));
  mock('getRequestHeader', () => undefined);
  mock('getTimestampMillis', () => NOW);
  mockObject('templateDataStorage', {
    getItemCopy: () => undefined,
    setItemCopy: () => {}
  });
  mockSuccessfulResponse(createRateResponse('USD', 'EUR', RATE));

  const mockData = createMockData({});


___NOTES___

2026-09-18 - Change Notes:
  - First release

Created on 09/18/2026, 05:06:00

