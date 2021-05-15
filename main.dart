import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:weather_app_2/fetchLocation.dart';
import 'GetIcons.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'Getlocation.dart';
import 'package:weather_icons/weather_icons.dart';
class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}
class _MainState extends State<Main> with SingleTickerProviderStateMixin {
  TabController tabs;
  // ignore: non_constant_identifier_names
  var humidity,speed,pressure,country,icon,temp,description,feels_like,temp_min,temp_max,city,image,location,id;
  String errorMessage='';
  var day = DateFormat.E().format(DateTime.now());
  var currentTime = DateFormat.jm().format(DateTime.now());
  static const String _apiKey = '//Add your API key';
  Future getTemp() async {
    var lalo = await Getlocation.getCurrentLocation();
    try{
    if (lalo != null) {
        var response = await http.get(
            'https://api.openweathermap.org/data/2.5/weather?lat=${lalo
                .latitude}&lon=${lalo.longitude}&appid=$_apiKey&units=metric');
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
    }
    catch(error)
      {
        setState(() {
          errorMessage="Sorry, We are not able to connect. Please check your internet and make sure location is turned On!";
        });
      }
  }
  @override
  void initState()
  {
    super.initState();
    this.getTemp();
    tabs = new TabController(length: 3, vsync: this);
  }
  void dialog()
  {
    showDialog(context: context, builder:(BuildContext context) =>  AlertDialog(
      title: Text('Designed by :') ,
      content: Text('Rayson Lawrence Dsouza'),
      actions: [
        // ignore: deprecated_member_use
        FlatButton(onPressed: (){Navigator.pop(context);}, child: Text('Close',))
      ],
    ),
    );
  }
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home : new Scaffold(
          bottomNavigationBar: new Material(
              color: Colors.black,
              child: new TabBar(controller: tabs, tabs: <Widget>[
                new Tab(
                  icon: new Icon(MdiIcons.information),
                ),
                new Tab(
                  icon: new Icon(WeatherIcons.thermometer_exterior),
                ),
                new Tab(
                  icon: new Icon(WeatherIcons.barometer),
                )
              ])),
          body : Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image : AssetImage('assets/images/$image.gif'),
                fit: BoxFit.cover,
              )
            ),
      child:  TabBarView(
        controller : tabs,
      children : [
      Column(
        children: <Widget>[
          new AppBar(
      leading:IconButton(icon : new Icon(Icons.search,color: Colors.white,),onPressed: () => {
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new fetchLocation()))
          },
          ),
        backgroundColor: Colors.transparent,
        elevation: 0,
            actions: <Widget>[
              IconButton(icon: Icon(Icons.info_outline_rounded), onPressed: dialog)
            ],
      ),

          Container(
            margin: EdgeInsets.only(top: 200),
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
          Container(
            margin: EdgeInsets.only(top: 20),
            child:  Text(errorMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold)),
          )
          ],
      ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height : 150,
                width : 350,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
                child : Card(
            color: Colors.transparent,
            child: ListTile(
              leading: GetIcons.getIcon(icon),
              title: Text(
                'Temperature: ${temp != null ? temp.toString()+'\u00b0':'Loading ..'} C',style: TextStyle(fontSize: 28,color: Colors.white),
              ),
              subtitle: Text('Status: ${description != null ? description.toString():'Loading ..'}',style: TextStyle(fontSize: 20,color: Colors.white),),
            ),
          ),
                ),
          Container(
            height : 150,
            width : 350,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
         child : Card(
            color: Colors.transparent,
            child: ListTile(
              leading: GetIcons.getIcon(icon),
              title: Text(
                'Pressure: ${pressure != null ? pressure.toString():'Loading ..'} Pa',style: TextStyle(fontSize: 28,color: Colors.white),
              ),
              subtitle: Text('Humidity: ${humidity != null ? humidity.toString():'Loading ..'} %',style: TextStyle(fontSize: 20,color: Colors.white),),
            ),
          ),
          ),
          ],
          ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height : 150,
                  width : 350,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
         child : Card(
            color: Colors.transparent,
            child: ListTile(
              leading: GetIcons.getIcon(icon),
              title: Text(
                'Min Temp:  ${temp_min != null ? temp_min.toString()+'\u00b0':'Loading ..'} C',style: TextStyle(fontSize: 28,color: Colors.white),
              ),
              subtitle: Text('Max Temp:  ${temp_max != null ? temp_max.toString()+'\u00b0':'Loading ..'} C',style: TextStyle(fontSize: 20,color: Colors.white),),
            ),
          ),
                ),
          Container(
            height : 150,
            width : 350,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
            child : Card(
              color: Colors.transparent,
              child: ListTile(
                leading: GetIcons.getIcon(icon),
                title: Text(
                  'Speed :  ${speed != null ? speed.toString()+'\u00b0':'Loading ..'} C',style: TextStyle(fontSize: 28,color: Colors.white),
                ),
                subtitle: Text('Max Temp:  ${temp_max != null ? temp_max.toString()+'\u00b0':'Loading ..'} C',style: TextStyle(fontSize: 20,color: Colors.white),),
              ),
            ),
          ),
        ],
      ),
        ],
      ),
    )
      )
    );
  }
}




