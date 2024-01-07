import 'package:equatable/equatable.dart';

class WeatherEntity extends Equatable {
  final String cityName;
  final String main;
  final String description;
  final String iconCode;
  final double temperature;
  final int pressure;
  final int humidity;

  const WeatherEntity(
      {required this.cityName,
      required this.main,
      required this.description,
      required this.iconCode,
      required this.temperature,
      required this.pressure,
      required this.humidity});

  @override
  List<Object?> get props => [
        'cityName: $cityName',
        'main: $main',
        'description: $description',
        'iconCode: $iconCode',
        'temperature: $temperature',
        'pressure: $pressure',
        'humidity: $humidity',
      ];
}
