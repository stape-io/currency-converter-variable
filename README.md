# Currency Converter Variable for Google Tag Manager Server Side

The **Currency Converter variable for the Google Tag Manager server container** converts a monetary amount from one currency to another using live mid-market exchange rates from the [Xe Currency Data API](https://xecdapi.xe.com/docs/v1/).

Use it to normalise purchase values into a single reporting currency before they reach Google Analytics 4, Google Ads, Meta, or any other destination — so every platform receives comparable revenue figures regardless of the currency the customer paid in.

## Features

- **Live mid-market rates** — conversions use Xe's `convert_from` endpoint, the same mid-market rate Xe publishes.
- **Automap from Event Data** — From Currency and Amount fall back to `eventData.currency` and `eventData.value`, so a single variable works across every ecommerce event without per-event configuration.
- **Built-in rate caching** — rates are always requested for a single unit and cached in Template Storage, so one API call serves every amount converted for that currency pair until the cache expires. This keeps the variable well within the Xe API request quota.
- **Flexible output** — return the converted amount, the exchange rate on its own, or the full Xe API response.
- **Optional margin** — apply a percentage margin (+/-) on top of the mid-market rate, for example to model FX fees.
- **Configurable rounding** — round the returned number to a fixed number of decimal places, or return it at full precision.

## How to use the Currency Converter variable

1. Add the **Currency Converter** variable to your server GTM container from the template gallery.
2. Add your **Account ID** and **API Key**. They are sent as the username and password for HTTP Basic authentication. You can request free API credentials for a 7-day trial on the [Xe Currency Data API](https://xecd-account-api.xe.com/v2/newuser?type=freetrial/) site.
3. Set the **To Currency** — the ISO 4217 code of your reporting currency, for example `EUR`.
4. Optionally set the **From Currency** and the **Amount**. With **Automap from Event Data** enabled (the default), leaving them empty falls back to `eventData.currency` and `eventData.value`; if neither is set, the variable converts `1` unit of `USD`. Disable the checkbox to require both values to be set explicitly.
5. Choose **What To Return**:
   - **Converted Amount** (default) — the Amount multiplied by the mid-market exchange rate.
   - **Exchange Rate** — the mid-market rate for a single unit of the From Currency.
   - **Full API Response** — the parsed Xe API response object. Rates are always requested for a single unit, so `to[0].mid` holds the exchange rate rather than the converted amount.
6. Optionally set **Decimal Places** to round the returned number. Leave it empty to return the value at full precision.
7. Under **Advanced Settings**, optionally add a **Margin (%)** and adjust the cache. Caching is enabled by default with a 60-minute TTL.
8. Use the variable in your tags — for example as the `value` parameter of a GA4 or Conversion API tag.

The variable returns `undefined` when credentials are missing, when the To Currency is not set, or when the rate cannot be retrieved from the API.

## Useful resources

- [Xe Currency Data API documentation](https://xecdapi.xe.com/docs/v1/)
- [ISO 4217 currency codes](https://www.xe.com/iso4217.php)

## Open Source

The **Currency Converter Variable for GTM Server Side** is developed and maintained by the [Stape Team](https://stape.io/) under the Apache 2.0 license.
