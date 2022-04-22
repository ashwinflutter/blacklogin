import 'dart:convert';

import 'package:blacklogin/Registerpage.dart';
import 'package:blacklogin/Splashscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'clientpage.dart';
import 'updatepage.dart';

void main() {
  runApp(MaterialApp( builder: EasyLoading.init(),
    debugShowCheckedModeBanner: false,
    home: splash_screen(),
  ));
}

class loginpage extends StatefulWidget {


  const loginpage({Key? key}) : super(key: key);

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  String eemail = "";
  String epassword = "";

  bool eestatus = false;
  bool epassstatus = false;


  @override
  Widget build(BuildContext context) {
    double theight = MediaQuery.of(context).size.height;
    double twidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(80, 60, 80, 10),
              height: theight * .20,
              decoration: BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage("images/black.jpg"))),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(100, 30, 80, 20),
              height: 50,
              width: 120,
              child: Text(
                "LOGIN",
                style: TextStyle(fontSize: 35, color: Colors.white),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 320,
              child: TextField(
                controller: email,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.account_circle_outlined,
                      size: 30,
                      color: Colors.blueAccent,
                    ),
                    labelText: "Email",
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12))),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 320,
              child: TextField(
                controller: password,
                // obscureText: true,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.vpn_key_outlined,
                      size: 30,
                      color: Colors.blueAccent,
                    ),
                    labelText: "Password",
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12))),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () async {
                eestatus = false;
                epassstatus = false;
                setState(() {});

                setState(() {
                  eemail = email.text;
                  epassword = password.text;
                });


                Map map = {
                  "email": eemail,
                  "password": epassword,
                };

                var url = Uri.parse('https://ashwinbhaiamzon.000webhostapp.com/mylogin.php');

                var response = await http.post(url, body: map);
                print('Response status: ${response.statusCode}');
                print('Response body: ${response.body}');

                var rr = jsonDecode(response.body);

              LoginResponse  ll = LoginResponse.fromJson(rr);



                if(ll.connection==1)
                  {
                    if(ll.result==1)
                      {
                    String? id =ll.userdata!.id;
                    String?  name=ll.userdata!.name;
                    String?  email=ll.userdata!.email;
                    String?  number=ll.userdata!.number;
                    String?  password=ll.userdata!.password;
                    String?  imagename=ll.userdata!.imagename;


                    splash_screen.preferences!.setBool("loginstatus", true);

                    splash_screen.preferences!.setString("id", id!);
                    splash_screen.preferences!.setString("name", name!);
                    splash_screen.preferences!.setString("email", email!);
                    splash_screen.preferences!.setString("number", number!);
                    splash_screen.preferences!.setString("password", password!);
                    splash_screen.preferences!.setString("imagename", imagename!);

                    setState(() {

                    });
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                      return clientpage();

                    },));

                      }
                  }



              },
              child: Container(
                alignment: Alignment.center,
                height: 50,
                child: Text(
                  "Sign In",
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
                width: 220,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              height: 44,
              child: Text(
                "Forgot Password ?",
                style: TextStyle(fontSize: 20, color: Colors.blue),
              ),
              width: 220,
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return acntpage();
                  },
                ));
              },
              child: Container(
                alignment: Alignment.center,
                height: 44,
                child: Text(
                  "Creat New Account",
                  style: TextStyle(fontSize: 17, color: Colors.white),
                ),
                width: 280,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginResponse {
  int? connection;
  int? result;
  Userdata? userdata;

  LoginResponse({this.connection, this.result, this.userdata});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
    userdata = json['userdata'] != null
        ? new Userdata.fromJson(json['userdata'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    if (this.userdata != null) {
      data['userdata'] = this.userdata!.toJson();
    }
    return data;
  }
}

class Userdata {
  String? id;
  String? name;
  String? email;
  String? number;
  String? password;
  String? imagename;

  Userdata(
      {this.id,
      this.name,
      this.email,
      this.number,
      this.password,
      this.imagename});

  Userdata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    number = json['number'];
    password = json['password'];
    imagename = json['imagename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['number'] = this.number;
    data['password'] = this.password;
    data['imagename'] = this.imagename;
    return data;
  }
}
