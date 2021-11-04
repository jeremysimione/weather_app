import 'package:bloc/bloc.dart';
import 'package:weather_app/data/repository/network.dart';
import 'package:weather_app/business_logic/weather_state.dart';
import 'package:weather_app/data/models/weathermodel.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final Network _weatherRepository;

  WeatherCubit(this._weatherRepository) : super(const WeatherInitial());

  Future<WeatherForecastModel?> getWeather(String cityName) async {
    try {
      emit(const WeatherLoading());
      final weather =
          await _weatherRepository.getWeatherForecast(cityName: cityName);
      emit(WeatherLoaded(weather));
    } on MyNetworkException {
      emit(const WeatherError("Impossible de récupérer les données"));
    }
  }
}

class MyNetworkException implements Exception {}
