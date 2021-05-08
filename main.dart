import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'GetIcons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}
class _MainState extends State<Main> {
  // ignore: non_constant_identifier_names
  var humidity,speed,pressure,country,icon,temp,description,feels_like,temp_min,temp_max,city,image;
  var day = DateFormat.E().format(DateTime.now());
  var currentTime = DateFormat.jm().format(DateTime.now());
  static const String _apiKey = 'ea429197b38be89cb9a58407faa003b0';
  Future getTemp() async {
    var lalo = await Getlocation.getCurrentLocation();
    if (lalo != null) {
      http.Response response = await http.get(
          'https://api.openweathermap.org/data/2.5/weather?lat=${lalo.latitude}&lon=${lalo.longitude}&appid=$_apiKey&units=metric');
      var get = jsonDecode(response.body);
      setState(() {
        this.country = get['sys']['country'];
        this.description = get['weather'][0]['description'];
        this.icon = get['weather'][0]['icon'];
        this.temp = get['main']['temp'];
        this.humidity = get['main']['humidity'];
        this.pressure = get['main']['pressure'];
        this.speed = get['wind']['speed'];
        this.feels_like = get['main']['feels_like'];
        this.temp_min = get['main']['temp_min'];
        this.temp_max = get['main']['temp_max'];
        this.city = get['name'];
        this.image = get['weather'][0]['main'];
      });
    }
    else
      {
        throw Exception('Failed to fetch the data');
      }
  }
  @override
  void initState()
  {
    super.initState();
    this.getTemp();
  }
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home : new Scaffold(
          body : Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image : AssetImage('assets/images/$image.gif'),
                fit: BoxFit.cover,
              )
            ),
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 30),
            child : new Text('$day, $currentTime',style: TextStyle(color: Colors.white,fontSize: 25),),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child : new Text('${temp != null ? temp.toString() + '\u00b0' : "Loading..." } C',style: TextStyle(color: Colors.white,fontSize: 55),),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children : <Widget>[
                new Text('${temp_min != null ? temp_min.toString()+'\u00b0 C/' : 'Retrieving.. '} ',style: TextStyle(color: Colors.white,),),
                new Text('${temp_max != null ? temp_max.toString()+'\u00b0C   Real Feel : ' : ''} ',style: TextStyle(color: Colors.white),),
               new Text('${temp != null ? temp.toString()+'\u00b0':''} C',style: TextStyle(color: Colors.white,),)
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
          child : Row(
            mainAxisAlignment: MainAxisAlignment.center,
          children : <Widget>[
            new Text('${country != null ? country.toString()+', ' : 'Retrieving.. '}',style: TextStyle(color: Colors.white,fontSize: 25),),
            new Text('${city != null ? city.toString()+' ' : ''}',style: TextStyle(color: Colors.white,fontSize: 25),),
            new Icon(MdiIcons.mapMarker,color: Colors.red,size: 27,),
         ],
          ),
          ),
          Card(
            color: Colors.white,
            margin: EdgeInsets.symmetric(vertical: 17.0, horizontal:17.0),
            child: ListTile(
              leading: GetIcons.getIcon(icon),
              title: Text(
                'Temperature: ${temp != null ? temp.toString()+'\u00b0':'Loading ..'} C',
              ),
              subtitle: Text('Status: ${description != null ? description.toString():'Loading ..'}'),
            ),
          ),
          Card(
            color: Colors.white,
            margin: EdgeInsets.symmetric(vertical: 17.0, horizontal:17.0),
            child: ListTile(
              leading: GetIcons.getIcon(icon),
              title: Text(
                'Pressure: ${pressure != null ? pressure.toString():'Loading ..'} Pa',
              ),
              subtitle: Text('Humidity: ${humidity != null ? humidity.toString():'Loading ..'} %'),
            ),
          ),
          Card(
            color: Colors.white,
            margin: EdgeInsets.symmetric(vertical: 17.0, horizontal:17.0),
            child: ListTile(
              leading: GetIcons.getIcon(icon),
              title: Text(
                'Min Temp:  ${temp_min != null ? temp_min.toString()+'\u00b0':'Loading ..'} C',
              ),
              subtitle: Text('Max Temp:  ${temp_max != null ? temp_max.toString()+'\u00b0':'Loading ..'} C'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child : new Text('Wind Speed : ${speed != null ? speed.toString()  : "Loading..." } mps',style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    )
      )
    );
  }
}
class Getlocation{
  //Get current location
  static Future getCurrentLocation() async{
    try{
      Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      return position;
    }catch(e){
      print(e);
    }
  }
}



