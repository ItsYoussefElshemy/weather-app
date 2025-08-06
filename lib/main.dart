import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather/cubits/get_weather_cubit/get_weather_states.dart';
import 'package:weather/views/home_view.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetWeatherCubit(),
      child: BlocBuilder<GetWeatherCubit, WeatherState>(
        builder: (context, state) {
          final MaterialColor themeColor = getThemeColor(
              state is WeatherLoadedState
                  ? state.weatherModel.weatherCondition
                  : null);
                  
          return MaterialApp(
            theme: ThemeData(
              primarySwatch: themeColor,
              primaryColor: themeColor,
              appBarTheme: AppBarTheme(
                backgroundColor: themeColor,
                elevation: 0,
                titleTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: const IconThemeData(color: Colors.white),
              ),
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: themeColor,
                brightness: Brightness.light,
              ).copyWith(
                secondary: themeColor,
              ),
            ),
            debugShowCheckedModeBanner: false,
            home: const HomePage(),
          );
        },
      ),
    );
  }
}

MaterialColor getThemeColor(String? condition) {
  if (condition == null) {
    return Colors.blue;
  }
  switch (condition) {
    case 'Sunny':
    case 'Clear':
      return Colors.orange;

    case 'Partly cloudy':
    case 'Cloudy':
    case 'Overcast':
      return Colors.grey;

    case 'Mist':
    case 'Fog':
    case 'Freezing fog':
      return Colors.blueGrey;

    case 'Patchy rain possible':
    case 'Patchy light drizzle':
    case 'Light drizzle':
    case 'Light rain':
    case 'Patchy light rain':
    case 'Light rain shower':
      return Colors.lightBlue;

    case 'Moderate rain':
    case 'Moderate rain at times':
    case 'Heavy rain':
    case 'Heavy rain at times':
    case 'Moderate or heavy rain shower':
    case 'Torrential rain shower':
    case 'Blowing snow':
    case 'Blizzard':
      return Colors.blue;

    case 'Patchy snow possible':
    case 'Patchy light snow':
    case 'Light snow':
    case 'Patchy moderate snow':
    case 'Light snow showers':
    case 'Light sleet':
    case 'Light sleet showers':
    case 'Patchy sleet possible':
      return Colors.cyan;

    case 'Moderate snow':
    case 'Patchy heavy snow':
    case 'Heavy snow':
    case 'Moderate or heavy snow showers':
    case 'Moderate or heavy sleet':
    case 'Moderate or heavy sleet showers':
      return Colors.indigo;

    case 'Patchy light snow with thunder':
    case 'Moderate or heavy snow with thunder':
      return Colors.deepPurple;

    case 'Thundery outbreaks possible':
    case 'Patchy light rain with thunder':
    case 'Moderate or heavy rain with thunder':
      return Colors.deepOrange;

    case 'Freezing drizzle':
    case 'Patchy freezing drizzle possible':
    case 'Light freezing rain':
    case 'Heavy freezing drizzle':
    case 'Moderate or heavy freezing rain':
      return Colors.teal;

    case 'Ice pellets':
    case 'Light showers of ice pellets':
    case 'Moderate or heavy showers of ice pellets':
      return Colors.lightBlue;

    default:
      return Colors.blue;
  }
}
