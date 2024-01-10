import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'injection_container.dart';
import 'presentation/bloc/weather_bloc.dart';
import 'presentation/pages/weather_page.dart';

void main() {
  setupLocator();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => locator<WeatherBloc>())],
      child: const MaterialApp(
        home: WeatherPage(),
      ),
    );
  }
}
