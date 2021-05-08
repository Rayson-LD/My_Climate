import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
class GetIcons{
  // ignore: missing_return
  static Icon getIcon(String iconCode){
    if(iconCode == '01d'){
      return Icon(MdiIcons.weatherSunny,size: 25,
        color: Colors.amber,);
    }else if(iconCode == '01n'){
      return Icon(MdiIcons.moonFull,size: 25,);
    }

    else if(iconCode == '02d'){
      return Icon(MdiIcons.weatherPartlyCloudy,size: 25,
        color: Colors.amber,);
    }

    else if(iconCode == '02n'){
      return Icon(MdiIcons.weatherNightPartlyCloudy,color:Colors.grey,size: 25,);
    }

    else if(iconCode == '03d' || iconCode == '03n'){
      return Icon(MdiIcons.weatherCloudy,color: Colors.blue,size: 25,);
    }

    //broken clouds
    else if(iconCode == '04d' || iconCode == '04n') {
      return Icon(MdiIcons.weatherPartlyRainy,size: 25,
        color: Colors.blue,);
    }


    //shower rain
    else if(iconCode == '09d' || iconCode == '09n') {
      return Icon(MdiIcons.weatherPartlySnowyRainy,size: 25,
        color: Colors.blue,);
    }


    //rain
    else if(iconCode == '10d' || iconCode == '10n') {
      return Icon(MdiIcons.weatherRainy,size: 25,
        color: Colors.blue,);
    }



    //thunderstorm
    else if(iconCode == '11d' || iconCode == '11n') {
      return Icon(MdiIcons.weatherLightning,size: 25,
        color: Colors.yellow,);
    }



    //snow
    else if(iconCode == '13d' || iconCode == '13n') {
      return Icon(MdiIcons.weatherSnowy,size: 25,
        color: Colors.yellow,);
    }



    //mist
    else if(iconCode == '50d' || iconCode == '50n') {
      return Icon(MdiIcons.weatherFog,size: 25,
        color: Colors.blue,);
    }

  }
}



