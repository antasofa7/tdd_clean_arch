part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object?> get props => [];
}

class WeatherEmpty extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherEntity result;

  const WeatherLoaded(this.result);

  @override
  List<Object?> get props => ['result: $result'];
}

class WeatherLoadFailure extends WeatherState {
  final String message;

  const WeatherLoadFailure(this.message);

  @override
  List<Object?> get props => ['message: $message'];
}
