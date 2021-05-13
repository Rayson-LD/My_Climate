import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:weather_app_2/GetIcons.dart';
// ignore: camel_case_types
class fetchLocation extends StatefulWidget {
  @override
  _fetchLocationState createState() => _fetchLocationState();
}
// ignore: camel_case_types
class _fetchLocationState extends State<fetchLocation> {
  double temp = 0;
  String city = 'California';
  int id = 4350049;
  String country = 'USA';
  String description = 'clear';
  var image,icon,pressure,humidity;
  initState() {
    super.initState();
    fetchlocation();
  }
  Future fetchSearch(String input) async{
    var searchResult = await http.get('https://api.openweathermap.org/data/2.5/weather?q=$input&appid=ea429197b38be89cb9a58407faa003b0&units=metric');
    var result = json.decode(searchResult.body);
    setState(() {
      this.city = result["name"];
      this.id = result["id"];
    });
  }
  Future fetchlocation() async{
    var locationResult = await http.get('https://api.openweathermap.org/data/2.5/weather?id=$id&appid=ea429197b38be89cb9a58407faa003b0&units=metric');
    var get = json.decode(locationResult.body);
    setState(() {
      this.icon = get['weather'][0]['icon'];
      this.country = get['sys']['country'];
      this.temp = get['main']['temp'];
      this.description = get['weather'][0]['description'];
      this.image = get['weather'][0]['main'];
      this.humidity = get['main']['humidity'];
      this.pressure = get['main']['pressure'];
    });
  }
  void onSubmit(String input)
  async{
    await fetchSearch(input);
    await fetchlocation();
  }
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                image : AssetImage('assets/images/$image.gif'),
                fit: BoxFit.cover,
              )
          ),
        child : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: TextField(onSubmitted: (String input){onSubmit(input);},
                style: TextStyle(color: Colors.white,fontSize: 25),
                decoration: InputDecoration(hintText: 'Search another location ...',
                    hintStyle: TextStyle(color: Colors.white,fontSize: 18),
                    prefixIcon: Icon(Icons.search,color: Colors.white,)
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
                    child : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(' ${city != null ? city.toString():'Loading ..'}, ',style: TextStyle(fontSize: 22,color: Colors.white),),
                          Text('${country != null ? country.toString():'Loading ..'}',style: TextStyle(fontSize: 28,color: Colors.white),),
                    ],
            ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child : GetIcons.getIcon(icon),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child : new Text('${temp != null ? temp.toString() + '\u00b0' : "Loading..." } C',style: TextStyle(color: Colors.white,fontSize: 55),),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children : <Widget>[
                  new Text('Pressure : ${pressure != null ? pressure.toString() : 'Retrieving.. '}Pa',style: TextStyle(color: Colors.white,),),
                  new Text('Humidity : ${humidity != null ? humidity.toString()  : ''}%',style: TextStyle(color: Colors.white),),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children : <Widget>[
                  new Text('${description != null ? description.toString() : 'Retrieving.. '}',style: TextStyle(color: Colors.white,fontSize: 25),),
                ],
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
