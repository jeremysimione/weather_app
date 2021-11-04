import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/data/repository/network.dart';
import 'package:weather_app/business_logic/weather_cubit.dart';
import 'package:weather_app/business_logic/weather_state.dart';
import 'package:weather_app/data/models/weathermodel.dart';
import 'package:weather_app/presentation/widgets/build_col_with_data.dart';
import 'package:weather_app/presentation/widgets/city_input_field.dart';
import 'package:weather_app/presentation/widgets/get_weather_icon.dart';
import 'package:weather_app/presentation/widgets/weather_row.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: BlocProvider(
        create: (context) => WeatherCubit(Network()),
        child: WeatherSearchPage(),
      ),
    );
  }
}

class WeatherSearchPage extends StatefulWidget {
  const WeatherSearchPage({Key? key}) : super(key: key);
  @override
  _WeatherSearchPageState createState() => _WeatherSearchPageState();
}

class _WeatherSearchPageState extends State<WeatherSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          alignment: Alignment.center,
          child: BlocConsumer<WeatherCubit, WeatherState>(
            listener: (context, state) {
              if (state is WeatherError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is WeatherInitial) {
                return buildInitialInput();
              } else if (state is WeatherLoading) {
                return buildLoading();
              } else if (state is WeatherLoaded) {
                return BuildColumnWithData(weather: state.weather);
              } else {
                return buildInitialInput();
              }
            },
          )),
    );
  }

  Widget buildInitialInput() {
    return const Center(
      child: CityInputField(),
    );
  }

  Widget buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

void submitCityName(BuildContext context, String cityName) {
  final weatherCubit = context.read<WeatherCubit>();
  weatherCubit.getWeather(cityName);
}
