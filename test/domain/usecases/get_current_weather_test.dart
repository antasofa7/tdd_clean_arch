import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_clean_arch_tdd/domain/entities/weather.dart';
import 'package:weather_clean_arch_tdd/domain/usecases/get_current_weather.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetCurrentWeatherUseCase getCurrentWeatherUseCase;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getCurrentWeatherUseCase =
        GetCurrentWeatherUseCase(weatherRepository: mockWeatherRepository);
  });

  const testWeatherDetail = WeatherEntity(
      cityName: 'Surabaya',
      main: 'Clouds',
      description: 'few clouds',
      iconCode: '02d',
      temperature: 302.28,
      pressure: 1009,
      humidity: 70);

  String lat = '-7.303312';
  String lon = '112.768557';

  test('should get current weather detail from the repository', () async {
    // arrange
    when(mockWeatherRepository.getCurrentWeather(lat, lon))
        .thenAnswer((_) async => const Right(testWeatherDetail));

    // act
    final result = await getCurrentWeatherUseCase.execute(lat, lon);

    // assert
    expect(result, const Right(testWeatherDetail));
  });
}
