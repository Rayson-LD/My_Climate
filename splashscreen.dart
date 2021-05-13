import 'package:splashscreen/splashscreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'main.dart';
void main() => runApp(splashscreen());
// ignore: camel_case_types
class splashscreen extends StatefulWidget {
  @override
  _splashscreenState createState() => _splashscreenState();
}
// ignore: camel_case_types
class _splashscreenState extends State<splashscreen> {
  final GlobalKey<ScaffoldState> skey = new GlobalKey<ScaffoldState>();

  void isOn()
  async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi)
    {
      // ignore: deprecated_member_use
      skey.currentState.showSnackBar(new SnackBar(content: new Text('You are online',style: TextStyle(color: Colors.white,fontWeight:FontWeight.bold),
      ),backgroundColor: Colors.green,
      )
      );
    }
    else  {
      // ignore: deprecated_member_use
      skey.currentState.showSnackBar(new SnackBar(content: new Text('You are offline',style: TextStyle(color: Colors.white,fontWeight:FontWeight.bold),
      ),
        backgroundColor: Colors.red,)
      );
    }
  }
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home : new Scaffold(
          key : skey,
            body : new SplashScreen(
              seconds: 5,
              navigateAfterSeconds: new Main(),
              title: new Text(
                'Climate App',
                style: GoogleFonts.pacifico(textStyle: TextStyle(color: Colors.blue[100],fontSize: 40)),
              ),
              image: new Image.asset("assets/images/background.gif",),
              photoSize: 75.0,
              loadingText: new Text(
                  'Loading ..',
                  style: GoogleFonts.pacifico(textStyle: TextStyle(color: Colors.green,fontSize: 25))),
              backgroundColor: Colors.black,
              loaderColor: Colors.blue,
              imageBackground: AssetImage('assets/images/bg.jpg'),
            )
        )
    );
  }
}
