WeatherAPI.com provides access to weather and geo data via a JSON/XML restful API. It allows developers to create desktop, web and mobile applications using this data very easy. This module provide capabilities to connect to WeatherAPI.com from Ballerina.

# Module Overview
This WeatherAPI Connector allows you to get current Weather data of a particular location through realtime weather API.

## Compatibility
|                    | Version                                                          |
|:------------------:|:----------------------------------------------------------------:|
| Ballerina Language | SLP5                                                             |
| WeatherAPI        | [v1](https://www.weatherapi.com/docs/#apis-realtime)              |

## Getting Started

The WeatherAPI connector can be instantiated using the APIKey.

**Obtaining API Key**


1. Visit https://www.weatherapi.com/signup.aspx and sign up.
2. Get your API key from your weatherAPI dashboard.


## Guide

First, import the `lakshans/weatherapi` module into the Ballerina project.

```ballerina
import lakshans/weatherapi;
```

Now, create the WeatherAPI client using the API key.

```ballerina
weatherapi:WeatherAPI weatherapi = new ("API_KEY");
```

`getCurrentWeatherByCityName(string cityName)` function can be used to get current weather data by providing a city name.

```ballerina
var data = weatherapi->getCurrentWeatherByCityName("Colombo");
```

`getCurrentWeatherByCoordinates(string latitude, string longitude)` function can be used to get current weather data by providing latitude and longitude of a location.

```ballerina
var data = weatherapi->getCurrentWeatherByCoordinates("48.8567","2.3508");
```

`getCurrentWeatherByIATAAirportCode(string IATAAirportCode)` function can be used to get current weather data by providing a IATA Airport Code.

```ballerina
var data = weatherapi->getCurrentWeatherByIATAAirportCode("DXB");
```

`getCurrentWeatherByIPAddress(string IPAddress)` function can be used to get current weather data by providing an IP address.

```ballerina
var data = weatherapi->getCurrentWeatherByIPAddress("100.0.0.1");
```

## Example
The following is an example code for using the weatherAPI connector.

```ballerina
import ballerina/io;
import lakshans/weatherapi;

public function main() {
    weatherapi:WeatherAPI weatherapi = new ("API_KEY");
    var data = weatherapi->getCurrentWeatherByCityName("Colombo");
    io:println(data);
}
```

