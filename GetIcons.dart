import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
class GetIcons{
  // ignore: missing_return
  static Icon getIcon(String iconCode){
    if(iconCode == '01d'){
      return Icon(WeatherIcons.day_sunny,color: Colors.yellow,);
    }else if(iconCode == '01n'){
      return Icon(WeatherIcons.moon_full);
    }

    else if(iconCode == '02d'){
      return Icon(WeatherIcons.day_cloudy,color: Colors.black,);
    }

    else if(iconCode == '02n'){
      return Icon(WeatherIcons.night_cloudy,color: Colors.lightBlueAccent,);
    }

    else if(iconCode == '03d' || iconCode == '03n'){
      return Icon(WeatherIcons.cloudy_gusts,color: Colors.lightBlueAccent,);
    }

    //broken clouds
    else if(iconCode == '04d' || iconCode == '04n') {
      return Icon(WeatherIcons.cloudy,color: Colors.lightBlueAccent,);
    }


    //shower rain
    else if(iconCode == '09d' || iconCode == '09n') {
      return Icon(WeatherIcons.raindrops,color: Colors.lightBlueAccent,);
    }


    //rain
    else if(iconCode == '10d' || iconCode == '10n') {
      return Icon(WeatherIcons.rain,color: Colors.lightBlueAccent,);
    }



    //thunderstorm
    else if(iconCode == '11d' || iconCode == '11n') {
      return Icon(WeatherIcons.thunderstorm);
    }



    //snow
    else if(iconCode == '13d' || iconCode == '13n') {
      return Icon(WeatherIcons.snow);
    }



    //mist
    else if(iconCode == '50d' || iconCode == '50n') {
      return Icon(WeatherIcons.wind);
    }

  }
}



