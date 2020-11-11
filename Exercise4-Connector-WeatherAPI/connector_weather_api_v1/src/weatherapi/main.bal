import ballerina/http;

final string WEATHER_API_URL = "http://api.weatherapi.com";
final string CURRENT_WEATHER_API = "/v1/current.json";

public client class WeatherAPI {
    private string apiKey;
    private http:Client weatherAPIClient;

    public function init(string apiKey) {
        self.apiKey = apiKey;
        self.weatherAPIClient = new (WEATHER_API_URL);
    }

    public remote function getCurrentWeatherByCityName(string cityName) returns @tainted json|error {
        string targetURL = CURRENT_WEATHER_API + "?key=" + self.apiKey + "&q=" + cityName;
        json response = <json>check self.weatherAPIClient->get(targetURL, targetType = json);
        return response;
    }

    public remote function getCurrentWeatherByCoordinates(string latitude, string longitude) returns @tainted json|error {
        string targetURL = CURRENT_WEATHER_API + "?key=" + self.apiKey + "&q=" + latitude + "," +longitude;
        json response = <json>check self.weatherAPIClient->get(targetURL, targetType = json);
        return response;
    }

    public remote function getCurrentWeatherByIATAAirportCode(string IATAAirportCode) returns @tainted json|error {
        string targetURL = CURRENT_WEATHER_API + "?key=" + self.apiKey + "&q=iata:" + IATAAirportCode;
        json response = <json>check self.weatherAPIClient->get(targetURL, targetType = json);
        return response;
    }

    public remote function getCurrentWeatherByIPAddress(string IPAddress) returns @tainted json|error {
        string targetURL = CURRENT_WEATHER_API + "?key=" + self.apiKey + "&q=iata:" + IPAddress;
        json response = <json>check self.weatherAPIClient->get(targetURL, targetType = json);
        return response;
    }
}
