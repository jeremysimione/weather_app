import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RowWeatherWidget extends StatelessWidget {
  const RowWeatherWidget(
      {Key? key,
      required this.speed,
      required this.humidity,
      required this.temp})
      : super(key: key);
  final String speed;
  final String humidity;
  final String temp;

  @override
  Widget build(BuildContext context) {
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
}
