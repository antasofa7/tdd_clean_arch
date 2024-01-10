import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/entities/weather.dart';
import '../../domain/usecases/get_current_weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeatherUseCase _getCurrentWeatherUseCase;

  WeatherBloc(GetCurrentWeatherUseCase getCurrentWeatherUseCase)
      : _getCurrentWeatherUseCase = getCurrentWeatherUseCase,
        super(WeatherEmpty()) {
    on<OnCityChanged>((event, emit) async {
      emit(WeatherLoading());
      final result =
          await _getCurrentWeatherUseCase.execute(event.lat, event.lon);

      result.fold((failure) => emit(WeatherLoadFailure(failure.message)),
          (data) => emit(WeatherLoaded(data)));
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}

EventTransformer<T> debounce<T>(Duration duration) =>
    (event, mapper) => event.debounceTime(duration).flatMap(mapper);
