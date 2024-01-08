import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_clean_arch_tdd/core/error/exception.dart';
import 'package:weather_clean_arch_tdd/core/error/failure.dart';
import 'package:weather_clean_arch_tdd/data/models/weather_model.dart';
import 'package:weather_clean_arch_tdd/data/repositories/weather_reporitory_impl.dart';
import 'package:weather_clean_arch_tdd/domain/entities/weather.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockWeatherRemoteDataSource mockWeatherRemoteDataSource;
  late WeatherRepositoryImpl weatherRepositoryImpl;

  setUp(() {
    mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();
    weatherRepositoryImpl = WeatherRepositoryImpl(
        weatherRemoteDataSource: mockWeatherRemoteDataSource);
  });

  const testWeatherModel = WeatherModel(
      cityName: 'Semampir',
      main: 'Clouds',
      description: 'few clouds',
      iconCode: '02n',
      temperature: 300.39,
      pressure: 1010,
      humidity: 52);

  const testWeatherEntity = WeatherEntity(
      cityName: 'Semampir',
      main: 'Clouds',
      description: 'few clouds',
      iconCode: '02n',
      temperature: 300.39,
      pressure: 1010,
      humidity: 52);

  const lat = '-7.303312';
  const lon = '112.768557';

  group('get current weather', () {
    test(
        'should return current weather when a call to data source is successful',
        () async {
      // arrange
      when(mockWeatherRemoteDataSource.getCurrentWeather(lat, lon))
          .thenAnswer((_) async => testWeatherModel);

      // act
      final result = await weatherRepositoryImpl.getCurrentWeather(lat, lon);

      // assert
      expect(result, equals(const Right(testWeatherEntity)));
    });

    test(
        'should return server failure when a call to data source is unsuccessful',
        () async {
      // arrange
      when(mockWeatherRemoteDataSource.getCurrentWeather(lat, lon))
          .thenThrow(ServerException());

      // act
      final result = await weatherRepositoryImpl.getCurrentWeather(lat, lon);

      // assert
      expect(
          result, equals(const Left(ServerFailure('An error has occurred'))));
    });

    test(
        'should return connection failure when the device has no internet connection',
        () async {
      // arrange
      when(mockWeatherRemoteDataSource.getCurrentWeather(lat, lon))
          .thenThrow(SocketException('Failed to connect the network'));

      // act
      final result = await weatherRepositoryImpl.getCurrentWeather(lat, lon);

      // assert
      expect(
          result,
          equals(
              const Left(ConnectionFailure('Failed to connect the network'))));
    });
  });
}
