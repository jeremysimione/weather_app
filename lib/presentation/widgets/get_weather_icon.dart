import 'package:flutter/cupertino.dart';

class WeatherIconWidget extends StatelessWidget {
  const WeatherIconWidget(
      {Key? key, required this.weatherDescription, required this.size})
      : super(key: key);
  final String weatherDescription;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Image.network(
        "http://openweathermap.org/img/wn/" + weatherDescription + "@4x.png",
        height: size,
        width: size);
  }
}
