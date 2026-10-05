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
  "displayName": "Currency Converter",
  "description": "Converts a monetary amount from one currency to another using exchange rates from Frankfurter, the Exchange API or Xe Currency Data.",
  "containerContexts": [
    "SERVER"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "GROUP",
    "name": "apiGroup",
    "displayName": "",
    "groupStyle": "NO_ZIPPY",
    "subParams": [
      {
        "type": "SELECT",
        "name": "apiProvider",
        "displayName": "API Provider",
        "macrosInSelect": false,
        "selectItems": [
          {
            "value": "frankfurter",
            "displayValue": "Frankfurter API"
          },
          {
            "value": "exchangeApi",
            "displayValue": "Exchange API"
          },
          {
            "value": "xe",
            "displayValue": "Xe Currency Data (paid)"
          }
        ],
        "simpleValueType": true,
        "defaultValue": "frankfurter",
        "alwaysInSummary": true,
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ],
        "help": "\u003cul\u003e\n  \u003cli\u003e\u003cb\u003eFrankfurter\u003c/b\u003e: rates from central banks and official sources for 165 currencies. See \u003ca href\u003d\"https://frankfurter.dev\"\u003efrankfurter.dev\u003c/a\u003e.\u003c/li\u003e\n  \u003cli\u003e\u003cb\u003eExchange API \u003c/b\u003e: rates for 200+ currencies, including cryptocurrencies and metals. Requests fall back to a mirror when the main CDN fails. See \u003ca href\u003d\"https://github.com/fawazahmed0/exchange-api\"\u003ethe documentation\u003c/a\u003e.\u003c/li\u003e\n  \u003cli\u003e\u003cb\u003eXe Currency Data (paid)\u003c/b\u003e: mid-market rates from \u003ca href\u003d\"https://xecdapi.xe.com/docs/v1\"\u003eXe\u003c/a\u003e. It requires an Xe Currency Data account and supports an optional margin.\u003c/li\u003e\n\u003c/ul\u003eFrankfurter and the Exchange API are free and require no account or API key, but they only update their rates once a day."
      },
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
        "help": "Your Xe Currency Data account ID. It is sent as the username for HTTP Basic authentication.\u003cbr/\u003e\u003cbr/\u003eFind it in your Xe Currency Data account: \u003ca href\u003d\"https://developers.xe.com/docs/currency-data-api/registration-overview#step-3--find-your-credentials\"\u003edocumentation\u003c/a\u003e. You can request free credentials for a 7-day trial \u003ca href\u003d\"https://xecd-account-api.xe.com/v2/newuser?type\u003dfreetrial/\"\u003ehere\u003c/a\u003e.",
        "enablingConditions": [
          {
            "paramName": "apiProvider",
            "paramValue": "xe",
            "type": "EQUALS"
          }
        ]
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
        "help": "Your Xe Currency Data API key. It is sent as the password for HTTP Basic authentication.\u003cbr/\u003e\u003cbr/\u003eFind it in your Xe Currency Data account: \u003ca href\u003d\"https://developers.xe.com/docs/currency-data-api/registration-overview#step-3--find-your-credentials\"\u003edocumentation\u003c/a\u003e. You can request free credentials for a 7-day trial \u003ca href\u003d\"https://xecd-account-api.xe.com/v2/newuser?type\u003dfreetrial/\"\u003ehere\u003c/a\u003e.",
        "enablingConditions": [
          {
            "paramName": "apiProvider",
            "paramValue": "xe",
            "type": "EQUALS"
          }
        ]
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
              "^[A-Za-z0-9]{2,5}$"
            ],
            "errorMessage": "Must be a currency code, e.g. USD.",
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
        "help": "Code of the currency the amount is converted from, e.g. \u003ci\u003eUSD\u003c/i\u003e.\u003cbr/\u003e\u003cbr/\u003eFalls back to \u003ci\u003eeventData.currency\u003c/i\u003e when left empty and \u003ci\u003eAutomap from Event Data\u003c/i\u003e is enabled, and to \u003ci\u003eUSD\u003c/i\u003e when neither is set."
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
              "^[A-Za-z0-9]{2,5}$"
            ],
            "errorMessage": "Must be a currency code, e.g. EUR.",
            "enablingConditions": []
          }
        ],
        "alwaysInSummary": true,
        "valueHint": "EUR",
        "help": "Code of the currency the amount is converted to, e.g. \u003ci\u003eEUR\u003c/i\u003e.\u003cbr/\u003e\u003cbr/\u003eUse ISO 4217 codes. Both APIs also support some precious metals (e.g. \u003ci\u003eXAU\u003c/i\u003e), and the Exchange API supports cryptocurrencies (e.g. \u003ci\u003eBTC\u003c/i\u003e). The supported codes are listed \u003ca href\u003d\"https://api.frankfurter.dev/v2/currencies\"\u003ehere (Frankfurter)\u003c/a\u003e and \u003ca href\u003d\"https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest/v1/currencies.json\"\u003ehere (Exchange API)\u003c/a\u003e."
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
        ],
        "enablingConditions": [
          {
            "paramName": "whatToReturn",
            "paramValue": "convertedAmount",
            "type": "EQUALS"
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
            "value": "rateData",
            "displayValue": "Rate Data"
          }
        ],
        "simpleValueType": true,
        "defaultValue": "convertedAmount",
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ],
        "help": "\u003cul\u003e\n  \u003cli\u003e\u003cb\u003eConverted Amount\u003c/b\u003e: the Amount multiplied by the exchange rate.\u003c/li\u003e\n  \u003cli\u003e\u003cb\u003eExchange Rate\u003c/b\u003e: the exchange rate for a single unit of the From Currency.\u003c/li\u003e\n  \u003cli\u003e\u003cb\u003eRate Data\u003c/b\u003e: an object with the \u003ci\u003edate\u003c/i\u003e of the rate, the \u003ci\u003ebase\u003c/i\u003e and \u003ci\u003equote\u003c/i\u003e currencies and the \u003ci\u003erate\u003c/i\u003e. It has the same shape for every API; the date of an Xe rate is a full timestamp.\u003c/li\u003e\n\u003c/ul\u003eThe variable returns \u003ci\u003eundefined\u003c/i\u003e when the rate cannot be retrieved, or when Converted Amount is selected and the Amount is not a number."
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
            "paramValue": "rateData",
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
        "valueValidators": [
          {
            "type": "REGEX",
            "args": [
              "^-?\\d+(\\.\\d+)?$"
            ],
            "errorMessage": "Must be a number, e.g. 2.05 or -1.5."
          }
        ],
        "help": "Optional percentage margin (+/-) that Xe applies on top of its mid-market rate. For example, \u003ci\u003e2.05\u003c/i\u003e returns the mid-market rate plus 2.05%.\u003cbr/\u003e\u003cbr/\u003eThe exchange rate, converted amount and rate data returned by this variable include the margin.",
        "enablingConditions": [
          {
            "paramName": "apiProvider",
            "paramValue": "xe",
            "type": "EQUALS"
          }
        ]
      },
      {
        "type": "CHECKBOX",
        "name": "useCache",
        "checkboxText": "Store exchange rates in cache",
        "simpleValueType": true,
        "defaultValue": true,
        "help": "Caches the exchange rate in Template Storage, so that repeated conversions of the same currency pair do not request it again. Rates are always requested for a single unit, which means one cached entry serves every amount."
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
                "string": "https://api.frankfurter.dev/v2/rate/*"
              },
              {
                "type": 1,
                "string": "https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest/v1/currencies/*"
              },
              {
                "type": 1,
                "string": "https://latest.currency-api.pages.dev/v1/currencies/*"
              },
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
- name: '[Early Exit] Returns undefined and makes no request when To Currency is missing'
  code: |-
    const variableResult = runCode(createMockData({toCurrency: ''}));

    assertThat(variableResult).isUndefined();
    assertApi('sendHttpRequest').wasNotCalled();
- name: '[Early Exit] Returns undefined and makes no request when Xe credentials are missing'
  code: |-
    const variableResult = runCode(createMockData({apiProvider: 'xe', apiKey: undefined}));

    assertThat(variableResult).isUndefined();
    assertApi('sendHttpRequest').wasNotCalled();
- name: '[Provider] Requests the single-unit rate from Frankfurter when the provider is not set'
  code: |-
    runCode(createMockData({apiProvider: undefined})).then((variableResult) => {
      assertApi('sendHttpRequest').wasCalledWith(FRANKFURTER_URL, expectedRequestOptions);
      assertThat(requestedUrls).isEqualTo([FRANKFURTER_URL]);
      assertThat(variableResult).isEqualTo(87.65);
    });
- name: '[Frankfurter] Trims and upper-cases the configured currency codes'
  code: |-
    runCode(createMockData({fromCurrency: ' usd ', toCurrency: 'eur'})).then((variableResult) => {
      assertApi('sendHttpRequest').wasCalledWith(FRANKFURTER_URL, expectedRequestOptions);
      assertThat(variableResult).isEqualTo(87.65);
    });
- name: '[Frankfurter] Returns undefined when the API responds with a non-2xx status
    code'
  code: |-
    mockHttpRequest(() => ({
      statusCode: 422,
      body: '{"status":422,"message":"invalid currency: XXX"}'
    }));

    runCode(mockData).then((variableResult) => {
      assertThat(variableResult).isUndefined();
    });
- name: '[Frankfurter] Returns undefined when the response holds no numeric rate'
  code: |-
    mockRates(FRANKFURTER_URL, {date: '2026-10-05', base: 'USD', quote: 'EUR', rate: 'n/a'});

    runCode(mockData).then((variableResult) => {
      assertThat(variableResult).isUndefined();
    });
- name: '[Exchange API] Requests the rates of the lower-cased From Currency from the
    CDN'
  code: |-
    runCode(createMockData({apiProvider: 'exchangeApi'})).then((variableResult) => {
      assertApi('sendHttpRequest').wasCalledWith(EXCHANGE_API_URL, expectedRequestOptions);
      assertThat(requestedUrls).isEqualTo([EXCHANGE_API_URL]);
      assertThat(variableResult).isEqualTo(87.65);
    });
- name: '[Exchange API] Falls back to the mirror when the CDN request fails'
  code: |-
    mockRates(EXCHANGE_API_FALLBACK_URL, createExchangeApiResponse('USD', 'EUR', RATE));

    runCode(createMockData({apiProvider: 'exchangeApi'})).then((variableResult) => {
      assertApi('sendHttpRequest').wasCalledWith(EXCHANGE_API_URL, expectedRequestOptions);
      assertApi('sendHttpRequest').wasCalledWith(EXCHANGE_API_FALLBACK_URL, expectedRequestOptions);
      assertThat(variableResult).isEqualTo(87.65);
    });
- name: '[Exchange API] Falls back to the mirror when the CDN does not return JSON'
  code: |-
    mockHttpRequest((url) =>
      url === EXCHANGE_API_URL
        ? {statusCode: 200, body: '<html>Bad Gateway</html>'}
        : jsonResponse(createExchangeApiResponse('USD', 'EUR', RATE))
    );

    runCode(createMockData({apiProvider: 'exchangeApi'})).then((variableResult) => {
      assertApi('sendHttpRequest').wasCalledWith(EXCHANGE_API_FALLBACK_URL, expectedRequestOptions);
      assertThat(variableResult).isEqualTo(87.65);
    });
- name: '[Exchange API] Does not call the mirror when the CDN responds with a valid
    rate'
  code: |-
    runCode(createMockData({apiProvider: 'exchangeApi'})).then(() => {
      assertThat(requestedUrls).isEqualTo([EXCHANGE_API_URL]);
    });
- name: '[Exchange API] Returns undefined when the CDN and the mirror both fail'
  code: |-
    mockHttpRequest(() => undefined);

    runCode(createMockData({apiProvider: 'exchangeApi'})).then((variableResult) => {
      assertThat(requestedUrls).isEqualTo([EXCHANGE_API_URL, EXCHANGE_API_FALLBACK_URL]);
      assertThat(variableResult).isUndefined();
    });
- name: '[Exchange API] Returns undefined when the response holds no rate for the
    requested currency'
  code: |-
    mockRates(EXCHANGE_API_URL, createExchangeApiResponse('USD', 'GBP', RATE));

    runCode(createMockData({apiProvider: 'exchangeApi'})).then((variableResult) => {
      assertThat(variableResult).isUndefined();
    });
- name: '[Xe] Requests the rate for a single unit with Basic authentication'
  code: |-
    runCode(createMockData({apiProvider: 'xe'})).then((variableResult) => {
      assertApi('sendHttpRequest').wasCalledWith(XE_URL, expectedXeRequestOptions);
      assertThat(requestedUrls).isEqualTo([XE_URL]);
      assertThat(variableResult).isEqualTo(87.65);
    });
- name: '[Xe] Appends the margin parameter when a margin is configured'
  code: |-
    mockRates(XE_URL + '&margin=2.05', createXeResponse('USD', 'EUR', RATE));

    runCode(createMockData({apiProvider: 'xe', margin: '2.05'})).then((variableResult) => {
      assertApi('sendHttpRequest').wasCalledWith(XE_URL + '&margin=2.05', expectedXeRequestOptions);
      assertThat(variableResult).isEqualTo(87.65);
    });
- name: '[Xe] Ignores an invalid margin, and ignores the margin for the free APIs'
  code: |-
    runCode(createMockData({apiProvider: 'xe', margin: 'not-a-number'}))
      .then(() => {
        assertThat(requestedUrls).isEqualTo([XE_URL]);
        return runCode(createMockData({margin: '2.05'}));
      })
      .then(() => {
        assertThat(requestedUrls).isEqualTo([XE_URL, FRANKFURTER_URL]);
      });
- name: '[Xe] Reads the rate of the requested currency among the returned quotes'
  code: |-
    const response = createXeResponse('USD', 'EUR', RATE);
    response.to = [{quotecurrency: 'GBP', mid: 0.5}, {quotecurrency: 'EUR', mid: RATE}];
    mockRates(XE_URL, response);

    runCode(createMockData({apiProvider: 'xe'})).then((variableResult) => {
      assertThat(variableResult).isEqualTo(87.65);
    });
- name: '[Xe] Returns undefined when the API responds with a non-2xx status code'
  code: |-
    mockHttpRequest(() => ({
      statusCode: 401,
      body: JSON.stringify(createXeResponse('USD', 'EUR', RATE))
    }));

    runCode(createMockData({apiProvider: 'xe'})).then((variableResult) => {
      assertThat(variableResult).isUndefined();
    });
- name: '[Xe] Returns undefined when the response holds no rate for the requested currency'
  code: |-
    mockRates(XE_URL, createXeResponse('USD', 'GBP', RATE));

    runCode(createMockData({apiProvider: 'xe'})).then((variableResult) => {
      assertThat(variableResult).isUndefined();
    });
- name: '[Automap] Falls back to the Event Data currency and value when the fields
    are empty'
  code: |-
    mock('getAllEventData', () => ({
      page_location: 'https://example.com/checkout',
      currency: 'GBP',
      value: 250
    }));
    mockRates(GBP_FRANKFURTER_URL, createFrankfurterResponse('GBP', 'EUR', RATE));

    runCode(createMockData({fromCurrency: '', amount: ''})).then((variableResult) => {
      assertApi('sendHttpRequest').wasCalledWith(GBP_FRANKFURTER_URL, expectedRequestOptions);
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
      assertApi('sendHttpRequest').wasCalledWith(FRANKFURTER_URL, expectedRequestOptions);
      assertThat(variableResult).isEqualTo(0.88);
    });
- name: '[Amount] A non-numeric amount returns undefined for Converted Amount only'
  code: |-
    runCode(createMockData({amount: 'not-a-number'}))
      .then((variableResult) => {
        assertThat(variableResult).isUndefined();
        return runCode(createMockData({amount: 'not-a-number', whatToReturn: 'exchangeRate'}));
      })
      .then((variableResult) => {
        assertThat(variableResult).isEqualTo(0.88);
      });
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
- name: '[Output] Returns the same rate data shape for Frankfurter and Exchange API'
  code: |-
    runCode(createMockData({whatToReturn: 'rateData'}))
      .then((variableResult) => {
        assertThat(variableResult).isEqualTo(expectedRateData);
        return runCode(createMockData({apiProvider: 'exchangeApi', whatToReturn: 'rateData'}));
      })
      .then((variableResult) => {
        assertThat(variableResult).isEqualTo(expectedRateData);
      });
- name: '[Output] Returns the Xe rate data with the full timestamp as the date'
  code: |-
    const overrides = {apiProvider: 'xe', whatToReturn: 'rateData'};

    runCode(createMockData(overrides)).then((variableResult) => {
      assertThat(variableResult).isEqualTo({
        date: XE_TIMESTAMP,
        base: 'USD',
        quote: 'EUR',
        rate: RATE
      });
    });
- name: '[Failure] Returns undefined when the response body is not valid JSON'
  code: |-
    mockHttpRequest(() => ({statusCode: 200, body: '<html>Bad Gateway</html>'}));

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
- name: '[Cache] Serves a valid cached rate without calling the API'
  code: |-
    let requestedKey;

    mockObject('templateDataStorage', {
      getItemCopy: (key) => {
        requestedKey = key;
        return {ts: NOW, rateData: expectedRateData};
      },
      setItemCopy: () => {}
    });

    runCode(createMockData({useCache: true})).then((variableResult) => {
      assertApi('sendHttpRequest').wasNotCalled();
      assertThat(requestedKey).isEqualTo('rate|frankfurter|USD|EUR');
      assertThat(variableResult).isEqualTo(87.65);
    });
- name: '[Cache] Requests a fresh rate when the cached entry has expired'
  code: |-
    mockObject('templateDataStorage', {
      getItemCopy: () => ({ts: NOW - 60 * 60 * 1000, rateData: expectedRateData}),
      setItemCopy: () => {}
    });

    runCode(createMockData({useCache: true})).then(() => {
      assertApi('sendHttpRequest').wasCalled();
    });
- name: '[Cache] Falls back to the default TTL when Cache TTL is empty'
  code: |-
    mockObject('templateDataStorage', {
      getItemCopy: () => ({ts: NOW - 59 * 60 * 1000, rateData: expectedRateData}),
      setItemCopy: () => {}
    });

    runCode(createMockData({useCache: true, cacheTtlMinutes: ''})).then(() => {
      assertApi('sendHttpRequest').wasNotCalled();
    });
- name: '[Cache] Stores a successful response under a provider-aware cache key'
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

    const overrides = {apiProvider: 'exchangeApi', useCache: true};

    runCode(createMockData(overrides)).then(() => {
      assertThat(storedKey).isEqualTo('rate|exchangeApi|USD|EUR');
      assertThat(storedValue.ts).isEqualTo(NOW);
      assertThat(storedValue.rateData).isEqualTo(expectedRateData);
    });
- name: '[Cache] Scopes the Xe cache key by account and margin'
  code: |-
    let storedKey;

    mockObject('templateDataStorage', {
      getItemCopy: () => undefined,
      setItemCopy: (key) => {
        storedKey = key;
      }
    });
    mockRates(XE_URL + '&margin=2.05', createXeResponse('USD', 'EUR', RATE));

    const overrides = {apiProvider: 'xe', useCache: true, margin: '2.05'};

    runCode(createMockData(overrides)).then(() => {
      assertThat(storedKey).isEqualTo('rate|xe|testAccountId|2.05|USD|EUR');
    });
- name: '[Cache] Does not store a response that holds no rate'
  code: |-
    let storeCalls = 0;

    mockObject('templateDataStorage', {
      getItemCopy: () => undefined,
      setItemCopy: () => {
        storeCalls++;
      }
    });
    mockHttpRequest(() => ({statusCode: 200, body: '{}'}));

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

  const FRANKFURTER_URL = 'https://api.frankfurter.dev/v2/rate/USD/EUR';
  const EXCHANGE_API_URL =
    'https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest/v1/currencies/usd.min.json';
  const EXCHANGE_API_FALLBACK_URL =
    'https://latest.currency-api.pages.dev/v1/currencies/usd.min.json';
  const GBP_FRANKFURTER_URL = 'https://api.frankfurter.dev/v2/rate/GBP/EUR';
  const XE_URL = 'https://xecdapi.xe.com/v1/convert_from?from=USD&to=EUR&amount=1';
  const XE_TIMESTAMP = '2026-09-24T14:25:00Z';

  const requestedUrls = [];

  const createFrankfurterResponse = (from, to, rate) => ({
    date: '2026-10-05',
    base: from,
    quote: to,
    rate: rate
  });

  const createExchangeApiResponse = (from, to, rate) => {
    const rates = {xxx: 1};
    rates[to.toLowerCase()] = rate;
    const response = {date: '2026-10-05'};
    response[from.toLowerCase()] = rates;
    return response;
  };

  const createXeResponse = (from, to, mid) => ({
    terms: 'https://www.xe.com/legal',
    privacy: 'https://www.xe.com/privacy',
    from: from,
    amount: 1,
    timestamp: XE_TIMESTAMP,
    to: [{quotecurrency: to, mid: mid}]
  });

  const expectedRateData = {date: '2026-10-05', base: 'USD', quote: 'EUR', rate: RATE};

  const jsonResponse = (body) => ({statusCode: 200, body: JSON.stringify(body)});

  // The handler receives the requested URL and returns the response, or undefined to fail it.
  const mockHttpRequest = (handler) => {
    mock('sendHttpRequest', (url) =>
      Promise.create((resolve, reject) => {
        requestedUrls.push(url);
        const result = handler(url);
        if (result) resolve(result);
        else reject({reason: 'failed'});
      })
    );
  };

  const mockRates = (mockedUrl, body) => {
    mockHttpRequest((url) => (url === mockedUrl ? jsonResponse(body) : undefined));
  };

  const expectedRequestOptions = {
    method: 'GET',
    headers: {Accept: 'application/json'},
    timeout: 3000
  };

  const expectedXeRequestOptions = {
    method: 'GET',
    headers: {
      Authorization: 'Basic ' + toBase64('testAccountId:testApiKey'),
      Accept: 'application/json'
    },
    timeout: 3000
  };

  const baseMockData = {
    apiProvider: 'frankfurter',
    accountId: 'testAccountId',
    apiKey: 'testApiKey',
    margin: undefined,
    fromCurrency: 'USD',
    toCurrency: 'EUR',
    amount: '100',
    autoMapEventData: true,
    whatToReturn: 'convertedAmount',
    decimalPlaces: '2',
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
  mockHttpRequest((url) => {
    if (url === FRANKFURTER_URL) {
      return jsonResponse(createFrankfurterResponse('USD', 'EUR', RATE));
    }
    if (url === EXCHANGE_API_URL) {
      return jsonResponse(createExchangeApiResponse('USD', 'EUR', RATE));
    }
    if (url === XE_URL) {
      return jsonResponse(createXeResponse('USD', 'EUR', RATE));
    }
    return undefined;
  });

  const mockData = createMockData({});


___NOTES___

2026-09-18 - Change Notes:
  - First release

Created on 09/18/2026, 05:06:00

