import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/data/models/weathermodel.dart';
import 'package:weather_app/presentation/widgets/get_weather_icon.dart';
import 'package:weather_app/presentation/widgets/weather_row.dart';

import 'city_input_field.dart';

class BuildColumnWithData extends StatelessWidget {
  const BuildColumnWithData({Key? key, required this.weather})
      : super(key: key);
  final WeatherForecastModel weather;

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
          WeatherIconWidget(weatherDescription: weatherDescrition, size: 180.0),
          RowWeatherWidget(
              speed: windSpeed, humidity: humidity, temp: temperature)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
        WeatherIconWidget(
            weatherDescription: weather.list[0].weather[0].icon, size: 200.0),
        const SizedBox(height: 10),
        Text(
          "${(weather.list[0].main.temp - 273.15).toStringAsFixed(1)} °C, " +
              weather.list[0].weather[0].description,
          style: const TextStyle(fontSize: 30),
        ),
        const SizedBox(height: 10),
        RowWeatherWidget(
            speed: (weather.list[0].wind.speed * 3.6).toStringAsFixed(1),
            humidity: weather.list[0].main.humidity.toString(),
            temp: (weather.list[0].main.temp - 273.15).toStringAsFixed(1)),
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
}
