import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_clean_arch_tdd/core/error/failure.dart';
import 'package:weather_clean_arch_tdd/domain/entities/weather.dart';
import 'package:weather_clean_arch_tdd/presentation/bloc/weather_bloc.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetCurrentWeatherUseCase mockGetCurrentWeatherUseCase;
  late WeatherBloc weatherBloc;

  setUp(() {
    mockGetCurrentWeatherUseCase = MockGetCurrentWeatherUseCase();
    weatherBloc =
        WeatherBloc(getCurrentWeatherUseCase: mockGetCurrentWeatherUseCase);
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

  test('initial state should be empty', () {
    expect(weatherBloc.state, WeatherEmpty());
  });

  blocTest<WeatherBloc, WeatherState>(
    'should emit [WeatherLoading, WeatherLoaded] when data is gotten successfully',
    build: () {
      when(mockGetCurrentWeatherUseCase.execute(lat, lon))
          .thenAnswer((_) async => const Right(testWeatherDetail));

      return weatherBloc;
    },
    act: (bloc) => bloc.add(OnCityChanged(lat: lat, lon: lon)),
    wait: const Duration(milliseconds: 500),
    expect: () => [WeatherLoading(), const WeatherLoaded(testWeatherDetail)],
  );

  blocTest<WeatherBloc, WeatherState>(
    'should emit [WeatherLoading, WeatherLoadFailure] when data is gotten unsuccessful',
    build: () {
      when(mockGetCurrentWeatherUseCase.execute(lat, lon))
          .thenAnswer((_) async => const Left(ServerFailure('Server failure')));

      return weatherBloc;
    },
    act: (bloc) => bloc.add(OnCityChanged(lat: lat, lon: lon)),
    wait: const Duration(milliseconds: 500),
    expect: () =>
        [WeatherLoading(), const WeatherLoadFailure('Server failure')],
  );
}
