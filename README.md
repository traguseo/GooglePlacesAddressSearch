# Google Places Address Search for Flow

Originally provided by Salesforce Labs as [Address Picker Autocomplete For Flow](https://github.com/SalesforceLabs/AddressPickerAutocompleteForFlow)

This component helps you, and your users make filling in addresses a breeze! It will find address suggestions as you type and upon selection will fill out all the relevant fields for you to make use of however you'd like in your flow.

This version fixes a bug where certain address components would come through as null (blank) and expands functionality to allow for apartments, condos, suites, units, etc.

[Install in Production](https://login.salesforce.com/packaging/installPackage.apexp?p0=04tgL000000BMQDQA4)

[Install in Sandbox](https://test.salesforce.com/packaging/installPackage.apexp?p0=04tgL000000BMQDQA4)

## Setup Guide

[Click here to see the setup guide](https://salesforce.quip.com/kyF3AzG256XL)

## Migration Guide

Recommended Steps:
1. Install the new package from the link above
2. Download all of your flows that use the old component into VSCode or your preferred IDE
3. Replace all instances of `DV_Flow_AP:AddressValidation` with `c:GooglePlacesAddressSearch`
4. Remove any references to the old deprecated "TITLE (DO NOT USE)" input field
5. Deploy all of your flows back to your org

