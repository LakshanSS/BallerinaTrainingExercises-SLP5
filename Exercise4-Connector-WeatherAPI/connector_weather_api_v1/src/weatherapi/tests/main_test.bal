import ballerina/io;
import ballerina/test;

@test:Config {}
function testCityName() returns error? {
    WeatherAPI weatherapi = new ("API_KEY");
    var data = weatherapi->getCurrentWeatherByCityName("Colombo");
    io:println(data);
}

@test:Config {}
function testCoordinates() returns error? {
    WeatherAPI weatherapi = new ("API_KEY");
    var data = weatherapi->getCurrentWeatherByCoordinates("48.8567","2.3508");
    io:println(data);
}

@test:Config {}
function testIATAAirportCode() returns error? {
    WeatherAPI weatherapi = new ("API_KEY");
    var data = weatherapi->getCurrentWeatherByIATAAirportCode("DXB");
    io:println(data);
}

@test:Config {}
function testIPAddress() returns error? {
    WeatherAPI weatherapi = new ("API_KEY");
    var data = weatherapi->getCurrentWeatherByIPAddress("100.0.0.1");
    io:println(data);
}
