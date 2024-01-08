import 'package:dartz/dartz.dart';

import 'package:weather_clean_arch_tdd/core/error/failure.dart';

import 'package:weather_clean_arch_tdd/domain/entities/weather.dart';

import '../../core/error/exception.dart';
import '../../domain/repositories/weather_repository.dart';
import '../data_sources/remote_data_source.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherRemoteDataSource weatherRemoteDataSource;

  WeatherRepositoryImpl({required this.weatherRemoteDataSource});

  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(
      String lat, String lon) async {
    try {
      final result = await weatherRemoteDataSource.getCurrentWeather(lat, lon);

      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect the network'));
    }
  }
}
