import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/views/search_view.dart';

class WeatherService {
  final Dio dio;
  final String baseUrl = 'http://api.weatherapi.com/v1';
  final String apiKey = '26709e04504741a884d163950251806';
  WeatherService(this.dio);
  Future<WeatherModel> getCurrentWeather({required String cityName}) async {
    try {
      Response response = await dio
          .get('$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=1');

      WeatherModel weatherModel = WeatherModel.fromJson(response.data);
      return weatherModel;
    } on DioException catch (e) {
      final String errMessage = e.response?.data['error']['message'] ??
          "there was an error, try later";
      throw Exception(errMessage);
    } catch (e) {
      log(e.toString());
      throw Exception('there was an error, try later');
    }
  }
}
