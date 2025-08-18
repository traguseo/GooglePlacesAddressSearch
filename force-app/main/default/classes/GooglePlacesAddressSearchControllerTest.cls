@IsTest
public class GooglePlacesAddressSearchControllerTest {
    @IsTest
    static void validateGetSuggestions() {
        //Test.setMock(GooglePlacesAddressSearchController.class, new GooglePlacesAddressSearchController());
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new GooglePlacesAddressSearchMock());

        String searchString = '201 Sussex St',
            latitude = '0.00',
            longitude = '0.00',
            sToken = 'abc123',
            filters = 'US,AU';
        String searchResults = GooglePlacesAddressSearchController.getSuggestions(
            searchString,
            latitude,
            longitude,
            sToken
        );
        String searchResultsWithFilters = GooglePlacesAddressSearchController.getSuggestionsWithFilters(
            searchString,
            latitude,
            longitude,
            sToken,
            filters
        );

        System.assertNotEquals(null, searchResults);
        //String placeId = 'ChIJ9Rr6fhsUyYcRtMLEzbOtijM';

        Test.stopTest();
    }
    @IsTest
    static void validateGetPlaceDetails() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new GooglePlacesAddressSearchMock());

        String placeId = 'ChIJ9Rr6fhsUyYcRtMLEzbOtijM', sToken = 'abc123';
        String searchResults = GooglePlacesAddressSearchController.getPlaceDetails(placeId, sToken);

        System.assertNotEquals(null, searchResults);

        Test.stopTest();
    }
    @IsTest
    static void describeLabelsTest() {
        Boolean TestOk = GooglePlacesAddressSearchController.describeLabels();
        System.assert(TestOk == true);
    }
}