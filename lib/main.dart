import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/network.dart';
import 'package:weather_app/weather_cubit.dart';
import 'package:weather_app/weather_state.dart';
import 'package:weather_app/weathermodel.dart';

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
                return buildColumnWithData(state.weather);
              } else {
                // State is WeatherError
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

  Widget buildRow(String speed, String humidity, String temp) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                speed + " km/h",
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(width: 10),
              Text(
                humidity + "%",
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(width: 10),
              Text(
                temp + " °C",
                style: const TextStyle(fontSize: 20),
              ),
            ]),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const <Widget>[
            Icon(
              FontAwesomeIcons.wind,
              color: Colors.black,
              size: 24.0,
              semanticLabel: 'Text to announce in accessibility modes',
            ),
            SizedBox(width: 40),
            Icon(
              FontAwesomeIcons.tint,
              color: Colors.black,
              size: 24.0,
              semanticLabel: 'Text to announce in accessibility modes',
            ),
            SizedBox(width: 30),
            Icon(
              FontAwesomeIcons.thermometerThreeQuarters,
              color: Colors.black,
              size: 24.0,
              semanticLabel: 'Text to announce in accessibility modes',
            ),
          ],
        ),
      ],
    );
  }

  Widget buildForecastContainer(String date, String weatherDescrition,
      String windSpeed, String humidity, String temperature) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.grey,
      ),
      width: 300,
      child: Column(
        children: [
          Text(
            DateFormat('EEEE').format(DateTime.parse(date)),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          getWeatherIcon(weatherDescription: weatherDescrition, size: 180.0),
          buildRow(windSpeed, humidity, temperature)
        ],
      ),
    );
  }

  Widget buildColumnWithData(WeatherForecastModel weather) {
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        const CityInputField(),
        const SizedBox(height: 50),
        Text(
          weather.city.name + "," + weather.city.country,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          DateFormat('EEEE d MMM yyyy')
              .format(DateTime.parse(weather.list[0].dtTxt)),
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        getWeatherIcon(
            weatherDescription: weather.list[0].weather[0].icon, size: 200.0),
        const SizedBox(height: 10),
        Text(
          "${(weather.list[0].main.temp - 273.15).toStringAsFixed(1)} °C, " +
              weather.list[0].weather[0].description,
          style: const TextStyle(fontSize: 30),
        ),
        const SizedBox(height: 10),
        buildRow(
            (weather.list[0].wind.speed * 3.6).toStringAsFixed(1),
            weather.list[0].main.humidity.toString(),
            (weather.list[0].main.temp - 273.15).toStringAsFixed(1)),
        const SizedBox(height: 10),
        const Text("Three days weather forecast",
            style: TextStyle(fontSize: 15)),
        const SizedBox(height: 10),
        CarouselSlider(
            items: [
              buildForecastContainer(
                  weather.list[5].dtTxt,
                  weather.list[5].weather[0].icon,
                  (weather.list[5].wind.speed * 3.6).toStringAsFixed(1),
                  weather.list[5].main.humidity.toString(),
                  (weather.list[5].main.temp - 273.15).toStringAsFixed(1)),
              buildForecastContainer(
                  weather.list[13].dtTxt,
                  weather.list[13].weather[0].icon,
                  (weather.list[13].wind.speed * 3.6).toStringAsFixed(1),
                  weather.list[13].main.humidity.toString(),
                  (weather.list[13].main.temp - 273.15).toStringAsFixed(1)),
              buildForecastContainer(
                  weather.list[20].dtTxt,
                  weather.list[20].weather[0].icon,
                  (weather.list[20].wind.speed * 3.6).toStringAsFixed(1),
                  weather.list[20].main.humidity.toString(),
                  (weather.list[20].main.temp - 273.15).toStringAsFixed(1)),
            ],
            //Slider Container properties
            options: CarouselOptions(
                autoPlay: true, enableInfiniteScroll: true, height: 300))
      ],
    ));
  }

  Widget getWeatherIcon(
      {required String weatherDescription, required double size}) {
    return Image.network(
        "http://openweathermap.org/img/wn/" + weatherDescription + "@4x.png",
        height: size,
        width: size);
  }
}

class CityInputField extends StatelessWidget {
  const CityInputField({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        onSubmitted: (value) => submitCityName(context, value),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: "Entrez une ville",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  void submitCityName(BuildContext context, String cityName) {
    final weatherCubit = context.read<WeatherCubit>();
    weatherCubit.getWeather(cityName);
  }
}
