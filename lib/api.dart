import 'dart:convert';

import 'package:weathery/weather_model.dart';
import 'package:http/http.dart' as http;
class WeatherApi{
  
  Future<WeatherModel> fetchWeather(String location) async{
final url="http://api.weatherapi.com/v1/current.json?key=f0b33b8a9ddd4f5f8df43929251905&q=$location";
      final resp= await http.get(Uri.parse(url));
      if(resp.statusCode==200)
      {
     final  Map<String,dynamic> body =jsonDecode(resp.body);  
      WeatherModel wm= WeatherModel.fromJson(body);
      return wm;
      }
      else
      {
        throw Exception('failed to load weather report:${resp.statusCode}');
      
      }

  }
}