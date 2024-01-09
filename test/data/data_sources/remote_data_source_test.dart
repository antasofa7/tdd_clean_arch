import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:weather_clean_arch_tdd/core/constants/constants.dart';
import 'package:weather_clean_arch_tdd/core/error/exception.dart';
import 'package:weather_clean_arch_tdd/data/data_sources/remote_data_source.dart';
import 'package:weather_clean_arch_tdd/data/models/weather_model.dart';

import '../../helpers/json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late WeatherRemoteDataSourceImpl weatherRemoteDataSourceImpl;

  setUp(() {
    mockHttpClient = MockHttpClient();
    weatherRemoteDataSourceImpl =
        WeatherRemoteDataSourceImpl(client: mockHttpClient);
  });

  const lat = '-7.303312';
  const lon = '112.768557';

  group('get current weather', () {
    test('should return weather model when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(Urls.currentWeatherByLatLon(lat, lon))))
          .thenAnswer((_) async => http.Response(
              readJson('helpers/dummy_data/dummy_weather_response.json'), 200));

      // act
      final result =
          await weatherRemoteDataSourceImpl.getCurrentWeather(lat, lon);

      // assert
      expect(result, isA<WeatherModel>());
    });

    test('should return weather model when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(Urls.currentWeatherByLatLon(lat, lon))))
          .thenAnswer((_) async => http.Response('Not found', 404));

      // act
      final result = weatherRemoteDataSourceImpl.getCurrentWeather(lat, lon);

      // print('result: $result');
      // print(throwsA(isA<ServerException>()));

      // assert
      expect(result, throwsA(isA<ServerException>()));
    });
  });
}
