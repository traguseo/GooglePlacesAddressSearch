/*
   Author:         Derrick Vuong
   Company:        Salesforce
   Description:    src/classes/GooglePlacesAddressSearchController.cls
   Date/Time:      5/20/2019, 4:49:47 PM

   History:
   When        Who         What
                               
   TODO:
   
 */
global with sharing class GooglePlacesAddressSearchController {
    @AuraEnabled
    global static String getSuggestions(String input, String latitude, String longitude, String sessionToken) {
        /* https://developers.google.com/places/web-service/autocomplete#place_types */

        String url =
            'https://maps.googleapis.com/maps/api/place/autocomplete/json?' +
            'input=' +
            EncodingUtil.urlEncode(input, 'UTF-8') +
            '&key=' +
            getKey() +
            '&sessiontoken=' +
            sessionToken;
        if (latitude != null && longitude != null) {
            url += '&location=' + latitude + ',' + longitude + '&radius=1000';
        }

        String response = getResponse(url);
        return response;
    }
    @AuraEnabled
    global static String getSuggestionsWithFilters(
        String input,
        String latitude,
        String longitude,
        String sessionToken,
        String countryFilters
    ) {
        /* https://developers.google.com/places/web-service/autocomplete#place_types */
        String countryComponents = '';
        if (countryFilters != '' && countryFilters != null) {
            List<String> countries = countryFilters.split(',');
            for (String country : countries) {
                countryComponents += countryComponents == ''
                    ? '&components=country:' + country.toLowerCase()
                    : '|country:' + country.toLowerCase();
            }
        }

        String url =
            'https://maps.googleapis.com/maps/api/place/autocomplete/json?' +
            'input=' +
            EncodingUtil.urlEncode(input, 'UTF-8') +
            '&key=' +
            getKey() +
            countryComponents +
            '&sessiontoken=' +
            sessionToken;
        if (latitude != null && longitude != null) {
            url += '&location=' + latitude + ',' + longitude + '&radius=1000';
        }
        System.debug('#### URL' + url);
        String response = getResponse(url);
        return response;
    }
    @AuraEnabled
    global static String getPlaceDetails(String placeId, String sessionToken) {
        /* https://developers.google.com/places/web-service/details#PlaceDetailsResults */

        String url =
            'https://maps.googleapis.com/maps/api/place/details/json?' +
            'placeid=' +
            EncodingUtil.urlEncode(placeId, 'UTF-8') +
            '&key=' +
            getKey() +
            '&sessiontoken=' +
            sessionToken;
        // + '&fields=address_components,formatted_address,geometry,name,adr_address,photos';

        // Available Places Detail Fields
        // address_component, adr_address, formatted_address, geometry, icon, name,
        // permanently_closed, photo, place_id, plus_code, type, url, utc_offset, vicinity

        String response = getResponse(url);
        return response;
    }

    global static String getResponse(String strURL) {
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        req.setMethod('GET');
        req.setEndpoint(strURL);
        req.setTimeout(120000);
        res = h.send(req);
        String responseBody = res.getBody();
        return responseBody;
    }

    private static String getKey() {
        List<PlacesAPI__c> placesAPIs = [SELECT Id, key__c FROM PlacesAPI__c LIMIT 1];
        for (PlacesAPI__c placesAPI : placesAPIs) {
            if (placesAPI != null) {
                String APIkey = placesAPI.key__c;
                return APIkey;
            }
        }

        System.debug('##### FlowAddress: #####');
        System.debug('API key not found. Check Custom Settings.');
        return null;
    }

    // https://salesforce.stackexchange.com/questions/185617/packaging-custom-labels-used-in-lightning-helpers-and-controllers
    // Include any dynamic custom labels that are referenced in Lightning in alphabetical order
    global static Boolean describeLabels() {
        String TitleLabel = System.Label.GPAS_Title;
        String ErrorLabel = System.Label.GPAS_API_Unknown_Error;
        String CityLabel = System.Label.GPAS_City;
        String CountryLabel = System.Label.GPAS_Country;
        String CountryFilterFormatLabel = System.Label.GPAS_Country_Filter_Format;
        String CountryFilterLimitLabel = System.Label.GPAS_Country_Filter_Limit;
        String CountyLabel = System.Label.GPAS_County;
        String CurrentLocationLabel = System.Label.GPAS_Current_Location;
        String DefaultAddressLabel = System.Label.GPAS_Default_Address;
        String LocationTrackingLabel = System.Label.GPAS_Enable_Location_Tracking;
        String FieldsRequiredLabel = System.Label.GPAS_Filled_Address_Fields_Required;
        String InputAddressLabel = System.Label.GPAS_Input_Address;
        String PlaceholderLabel = System.Label.GPAS_Input_Address_Placeholder;
        String ContactAdminLabel = System.Label.GPAS_Please_contact_your_admin;
        String PositionUnavailableLabel = System.Label.GPAS_Position_Unavailable;
        String PostalCodeLabel = System.Label.GPAS_Postal_Code;
        String ProvinceLabel = System.Label.GPAS_Province;
        String RequestTimedOutLabel = System.Label.GPAS_Request_Timed_Out;
        String SearchRequiredLabel = System.Label.GPAS_Search_and_Address_Field_Required;
        String SearchAndFieldsRequiredLabel = System.Label.GPAS_Search_and_All_Address_Fields_Required;
        String SelectedAddressLabel = System.Label.GPAS_Selected_Address;
        String StreetLabel = System.Label.GPAS_Street;
        String UnknownErrorLabel = System.Label.GPAS_Unknown_Error;
        return true;
    }
}