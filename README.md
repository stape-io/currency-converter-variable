# Currency Converter Variable for Google Tag Manager Server Side

The **Currency Converter variable for the Google Tag Manager server container** converts a monetary amount from one currency to another using exchange rates from one of three APIs: [Frankfurter API](https://frankfurter.dev/) (default), the [Exchange API](https://github.com/fawazahmed0/exchange-api), or the paid [Xe Currency Data API](https://xecdapi.xe.com/docs/v1/).

Use it to normalise purchase values into a single reporting currency before they reach Google Analytics 4, Google Ads, Meta, or any other destination — so every platform receives comparable revenue figures regardless of the currency the customer paid in.

## Features

- **Three APIs, one set of fields** — choose Frankfurter, the Exchange API or Xe from a drop-down. Frankfurter and the Exchange API are free and need no account or API key. Xe needs a paid account and adds its own credentials and margin fields, which are only shown when Xe is selected. The rest of the configuration is the same for all three.
- **Automap from Event Data** — From Currency and Amount fall back to `eventData.currency` and `eventData.value`, so a single variable works across every ecommerce event without per-event configuration.
- **Built-in rate caching** — rates are always requested for a single unit and cached in Template Storage, so one request serves every amount converted for that currency pair until the cache expires. Template Storage is kept per server instance, so each instance of your server container makes its own request.
- **Optional margin (Xe only)** — apply a percentage margin (+/-) on top of Xe's mid-market rate, for example to model FX fees.
- **Mirror fallback** — when the Exchange API's main CDN fails, the request falls back to its Cloudflare mirror.
- **Flexible output** — return the converted amount, the exchange rate on its own, or the rate data (`date`, `base`, `quote` and `rate`), which has the same shape for every API.
- **Configurable rounding** — round the returned number to a fixed number of decimal places, or return it at full precision.

## Choosing an API

| | Frankfurter | Exchange API | Xe Currency Data |
|---|---|---|---|
| Cost | Free | Free | Paid (7-day free trial) |
| Currencies | 165, from central banks and official sources | 200+, including cryptocurrencies | See the Xe documentation |
| Authentication | None | None | Account ID and API key |
| Quotas and rate limits | None | None | Depend on your Xe plan |
| Update frequency | Daily | Daily (the primary CDN can serve a rate up to about 12 hours old) | Live, 15-minute, hourly or daily, depending on your Xe plan |
| Margin | No | No | Yes |

Frankfurter and the Exchange API publish daily rates, so a long cache TTL is fine. Xe can refresh rates more often depending on your plan, so set the cache TTL accordingly. The APIs use different sources, so the same currency pair can return slightly different rates.

## How to use the Currency Converter variable

1. Add the **Currency Converter** variable to your server GTM container from the template gallery.
2. Choose the **API Provider**. **Frankfurter** is the default.
3. If you chose **Xe**, add your **Account ID** and **API Key**. They are sent as the username and password for HTTP Basic authentication, and you can find them in [your Xe Currency Data account](https://developers.xe.com/docs/currency-data-api/registration-overview#step-3--find-your-credentials). You can request free API credentials for a 7-day trial on the [Xe Currency Data API](https://xecd-account-api.xe.com/v2/newuser?type=freetrial/) site.
4. Set the **To Currency** — the code of your reporting currency, for example `EUR`.
5. Optionally set the **From Currency** and the **Amount**. The Amount is only shown when **What To Return** is **Converted Amount** (step 6). With **Automap from Event Data** enabled (the default), leaving them empty falls back to `eventData.currency` and `eventData.value`; if neither is set, the variable converts `1` unit of `USD`. If an Amount is provided but is not a number, the variable returns `undefined`. Disable the checkbox to require both values to be set explicitly.
6. Choose **What To Return**:
   - **Converted Amount** (default) — the Amount multiplied by the exchange rate.
   - **Exchange Rate** — the exchange rate for a single unit of the From Currency.
   - **Rate Data** — an object with the `date` of the rate, the `base` and `quote` currencies and the `rate`. Rates are always requested for a single unit, so `rate` is the exchange rate rather than the converted amount. The `date` is a day (`YYYY-MM-DD`) for Frankfurter and the Exchange API, and a full timestamp for Xe.
7. Optionally set **Decimal Places** to round the returned number. Leave it empty to return the value at full precision.
8. Under **Advanced Settings**, optionally add a **Margin (%)** (Xe only) and adjust the cache. Caching is enabled by default with a 60-minute TTL.
9. Use the variable in your tags — for example as the `value` parameter of a GA4 or Conversion API tag.

The variable returns `undefined` when the To Currency is not set, when Xe is selected and its credentials are missing, when **Converted Amount** is selected and the Amount is not a number, or when the rate cannot be retrieved from the API (for example an API error, an unexpected response, or no rate for the requested currency).

### Currency codes

Use ISO 4217 codes, for example `USD`. Codes are trimmed and converted to upper case. Frankfurter and the Exchange API support some precious metals (for example `XAU`), and the Exchange API also supports cryptocurrencies (for example `BTC`). For Xe, see its documentation for the supported codes. The supported codes are listed by [Frankfurter](https://api.frankfurter.dev/v2/currencies) and by the [Exchange API](https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest/v1/currencies.json).

## Useful resources

- [Frankfurter documentation](https://frankfurter.dev/)
- [Exchange API documentation](https://github.com/fawazahmed0/exchange-api)
- [Xe Currency Data API documentation](https://xecdapi.xe.com/docs/v1/)
- [ISO 4217 currency codes](https://www.xe.com/iso4217.php)

## Open Source

The **Currency Converter Variable for GTM Server Side** is developed and maintained by the [Stape Team](https://stape.io/) under the Apache 2.0 license.
