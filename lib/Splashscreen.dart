import 'package:blacklogin/main.dart';
import 'package:blacklogin/clientpage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class splash_screen extends StatefulWidget {
 static SharedPreferences? preferences;

  const splash_screen({Key? key}) : super(key: key);

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {

  bool loginsattus = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getlogin();
  }

  Future<void> getlogin() async {


    splash_screen.preferences = await SharedPreferences.getInstance();
    loginsattus = splash_screen.preferences!.getBool("loginstatus")??false;

    Future.delayed(Duration(seconds:3 )).then((value) {

      setState(() {
        if(loginsattus)
        {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            return clientpage();
          },));
        }
        else{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            return loginpage();
          },));

        }

      });

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Lottie.asset("raw/loading.json"),);
  }


}
