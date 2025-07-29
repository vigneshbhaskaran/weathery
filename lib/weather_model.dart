class WeatherModel {
final Location location;
final Current current;
  WeatherModel({required this.location,required this.current});
  factory WeatherModel.fromJson(Map<String,dynamic> wea){
    return WeatherModel(location: Location.fromJson(wea['location']), current: Current.fromJson(wea['current']));
  }
}

class Location{
  final String name;
  final double latitude;
  final double longitude;
  Location({required this.name,required this.latitude,required this.longitude});
  factory Location.fromJson(Map<String,dynamic> js){
    return Location(name: js['name'], latitude: (js['lat'] as num).toDouble(), longitude: (js['lon'] as num).toDouble());
  }
}

class Current{
  final double humidity;
  final double mph;
  final double cloud;
  final double temp;
  Current({required this.humidity,required this.cloud,required this.mph,required this.temp});
  factory Current.fromJson(Map<String,dynamic> js){
    return Current(humidity: (js['humidity'] as num).toDouble(), cloud: (js['cloud'] as num).toDouble(), mph: (js['wind_mph'] as num).toDouble(),temp: (js['temp_c'] as num).toDouble());
  }
}