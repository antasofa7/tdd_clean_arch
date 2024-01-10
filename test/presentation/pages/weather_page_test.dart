import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_clean_arch_tdd/domain/entities/weather.dart';
import 'package:weather_clean_arch_tdd/presentation/bloc/weather_bloc.dart';
import 'package:weather_clean_arch_tdd/presentation/pages/weather_page.dart';

class MockWeather extends MockBloc<WeatherEvent, WeatherState>
    implements WeatherBloc {}

void main() {
  late MockWeather mockWeatherBloc;

  setUp(() {
    mockWeatherBloc = MockWeather();
    HttpOverrides.global = null;
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<WeatherBloc>(
        create: (_) => mockWeatherBloc, child: MaterialApp(home: body));
  }

  const testWeather = WeatherEntity(
      cityName: 'Semampir',
      main: 'Clouds',
      description: 'few clouds',
      iconCode: '02n',
      temperature: 300.39,
      pressure: 1010,
      humidity: 52);

  testWidgets('text field should trigger state to change from empty to loading',
      (widgetTester) async {
    // arrange
    when(() => mockWeatherBloc.state).thenReturn(WeatherEmpty());

    // act
    await widgetTester.pumpWidget(makeTestableWidget(const WeatherPage()));

    var textField = find.byType(TextField);

    expect(textField, findsOneWidget);

    await widgetTester.enterText(textField, '-7.303312, 112.763322');

    await widgetTester.pump();

    expect(find.text('-7.303312, 112.763322'), findsOneWidget);
  });

  testWidgets('should show progress indicator when state is loading',
      (widgetTester) async {
    // arrange
    when(() => mockWeatherBloc.state).thenReturn(WeatherLoading());

    // act
    await widgetTester.pumpWidget(makeTestableWidget(const WeatherPage()));

    var circularProgress = find.byType(CircularProgressIndicator);

    expect(circularProgress, findsOneWidget);
  });

  testWidgets('should show widget contain weather data when state is loaded',
      (widgetTester) async {
    // arrange
    when(() => mockWeatherBloc.state)
        .thenReturn(const WeatherLoaded(testWeather));

    // act
    await widgetTester.pumpWidget(makeTestableWidget(const WeatherPage()));
    await widgetTester.pumpAndSettle();

    var weatherWidget = find.byKey(const Key('weather_data'));

    expect(weatherWidget, findsOneWidget);
  });
}
