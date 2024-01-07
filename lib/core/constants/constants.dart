class Urls {
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String apiKey = 'c1f3841107e6965a25d69ea496af4a93';
  static String currentWeatherByLatLon(String lat, String lon) =>
      '$baseUrl/weather?lat=$lat&lon=$lon&appid=$apiKey';
  // '$baseUrl/weather?lat=-7.303312&lon=112.768557&appid=';

  static String watherIcon(String iconCode) =>
      'http://openweathermap.org/img/wn/$iconCode@2x.png';
}
