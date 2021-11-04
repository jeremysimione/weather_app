import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/data/models/weathermodel.dart';

class Network {
  Future<WeatherForecastModel> getWeatherForecast(
      {required String cityName}) async {
    String appid = "1a4596db52a9f2e0e0fda9e40a9c36b8";
    var finalUrl = "https://api.openweathermap.org/data/2.5/forecast?q=" +
        cityName +
        "&appid=" +
        appid;

    final response = await http.get(Uri.parse(finalUrl));
    if (response.statusCode == 200) {
      return WeatherForecastModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Error getting weather forecast");
    }
  }
}
