import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:weather_clean_arch_tdd/data/models/weather_model.dart';
import 'package:weather_clean_arch_tdd/domain/entities/weather.dart';

import '../../helpers/json_reader.dart';

void main() {
  const testWeatherModel = WeatherModel(
      cityName: 'Surabaya',
      main: 'Clouds',
      description: 'few clouds',
      iconCode: '02d',
      temperature: 302.28,
      pressure: 1009,
      humidity: 70);

  test('should be a subclass of weather entity', () async {
    // assert
    expect(testWeatherModel, isA<WeatherEntity>());
  });

  test('should return a valid model from JSON', () {
    // arrange
    final Map<String, dynamic> jsonMap =
        jsonDecode(readJson('helpers/dummy_data/dummy_weather_response.json'));

    // act
    final result = WeatherModel.fromJson(jsonMap);

    // assert
    expect(result, equals(testWeatherModel));
  });

  test('should return a JSON map containing proper data', () async {
    // act
    final result = testWeatherModel.toJson();

    // assert
    final expectedJson = {
      'weather': [
        {'main': 'Clouds', 'description': 'few clouds', 'icon': '02d'}
      ],
      'main': {
        'temp': 302.28,
        'pressure': 1009,
        'humidity': 70,
      },
      'name': 'Surabaya'
    };
    expect(result, equals(expectedJson));
  });
}
