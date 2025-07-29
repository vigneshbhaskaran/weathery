import 'package:flutter/material.dart';
import 'package:weathery/api.dart';
import 'package:weathery/weather_model.dart';

class DisplayWeather extends StatefulWidget {
  const DisplayWeather({super.key});

  @override
  State<DisplayWeather> createState() => _DisplayWeatherState();
}

class _DisplayWeatherState extends State<DisplayWeather> {
late Future<WeatherModel> getWeatherReport;

final TextEditingController _locController=TextEditingController();
final _formKey=GlobalKey<FormState>();
String location='punalur';

void validateSubmit(String locValue){
  
                      if(_formKey.currentState!.validate())
                      {
                        setState(() {
                          location=locValue;
                          getWeatherReport=WeatherApi().fetchWeather(location);
                        });
                      }
}
  @override
  void initState(){
    super.initState();
    getWeatherReport=WeatherApi().fetchWeather(location);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyanAccent,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    width: 200,
                    child: TextFormField(
                      controller: _locController,
                       onFieldSubmitted: validateSubmit,
                      decoration: InputDecoration(
                        
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if(value==null||value.isEmpty)
                        {
                          return "pls input a location";
                        }
                        else if(value.length<2)
                        {
                          return 'location mustbe atleast 2 characters';
                        }
                        return null;
                      },
                      
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextButton(style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                  ),
                    onPressed: (){
                    
                      if(_formKey.currentState!.validate())
                      {
                        setState(() {
                          location=_locController.text;
                          getWeatherReport=WeatherApi().fetchWeather(location);
                        });
                      }
                    
                  },
                    child: Text('SEARCH')),
                ],
              ),
            ),
            FutureBuilder(
              future: getWeatherReport, 
              builder: (context,snapshot){
                if(snapshot.connectionState==ConnectionState.waiting)
                {
                  return Center(child: CircularProgressIndicator(),);
                }
                else if(snapshot.hasError)
                {
                  return Center(child: Text('error in connectivity:${snapshot.error}'),);
                }
                else if(!snapshot.hasData)
                {
                  return Center(child: Text('data is not available'),);
                }
                else {
                  final WeatherModel wm=snapshot.data!;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                       
                        Image.asset('assets/images/location.png',width: 100,height: 50,fit: BoxFit.cover,),
                        Text(wm.location.name),
                      ],
                     
            
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/temperature.png',width: 100,height: 50,),
                        Text('${wm.current.temp}'),
                      ],
                    ),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/latitude.png',width: 100,height: 50,),
                         Text('${wm.current.cloud}'),
                      ],
                    ),
                  
                   
                   ],
                  );
                }
              },
              ),
          ],
        ),
        ),
    );
  }
}