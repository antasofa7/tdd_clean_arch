part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object?> get props => [];
}

class OnCityChanged extends WeatherEvent {
  final String lat;
  final String lon;

  const OnCityChanged({required this.lat, required this.lon});

  @override
  List<Object?> get props => ['lat: $lat', 'lon: $lon'];
}
