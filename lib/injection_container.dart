import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'data/data_sources/remote_data_source.dart';
import 'data/repositories/weather_reporitory_impl.dart';
import 'domain/repositories/weather_repository.dart';
import 'domain/usecases/get_current_weather.dart';
import 'presentation/bloc/weather_bloc.dart';

final locator = GetIt.instance;

void setupLocator() {
  // bloc
  locator.registerFactory(() => WeatherBloc(locator()));

  // usecase
  locator.registerLazySingleton(() => GetCurrentWeatherUseCase(locator()));

  // reppository
  locator.registerLazySingleton<WeatherRepository>(
      () => WeatherRepositoryImpl(locator()));

  // data source
  locator.registerLazySingleton<WeatherRemoteDataSource>(
      () => WeatherRemoteDataSourceImpl(locator()));

  // external
  locator.registerLazySingleton(() => http.Client());
}
