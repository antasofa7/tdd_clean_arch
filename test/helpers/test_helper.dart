import 'package:mockito/annotations.dart';
import 'package:weather_clean_arch_tdd/domain/repositories/weather_repository.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  WeatherRepository,
], customMocks: [
  MockSpec<http.Client>(
    as: #MockHttpClient,
  ),
])
void main() {}
