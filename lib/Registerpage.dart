import 'dart:convert';
import 'dart:io';
import 'package:blacklogin/main.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class acntpage extends StatefulWidget {

  const acntpage({Key? key}) : super(key: key);

  @override
  State<acntpage> createState() => _acntpageState();
}

class _acntpageState extends State<acntpage> {
  String str = "";

  String ename="";
  String eemail="";
  String enumber="";
  String epassword="";

  bool enastatus=false;
  bool eestatus=false;
  bool enumstatus=false;
  bool epassstatus=false;


  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    double theight = MediaQuery.of(context).size.height;
    double twidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [SizedBox(height: 70),
            InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Column(
                        children: [
                          RaisedButton.icon(
                              onPressed: () async {
                                final XFile? image = await _picker
                                    .pickImage(source: ImageSource.gallery);
                                // Capture a photo

                                str = image!.path;
                                setState(() {});
                              },
                              icon: Icon(Icons.photo),
                              label: Text("Gallary")),
                          RaisedButton.icon(
                              onPressed: () async {
                                final XFile? photo = await _picker
                                    .pickImage(source: ImageSource.camera);
                                str = photo!.path;
                                setState(() {});
                              },
                              icon: Icon(Icons.camera_alt),
                              label: Text("Camera"))
                        ],
                      );
                    },
                  );
                },
                child: CircleAvatar(
                  radius: 72,
                  backgroundImage: FileImage(File(str)),
                )),
            SizedBox(height: 30,),
            Container(
              width: 320,
              child: TextField(controller: name,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.account_circle_outlined,
                      size: 30,
                      color: Colors.blueAccent,
                    ),
                    labelText: "NAME",
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "name",
                    errorText:  enastatus ? 'name Can\'t Be Empty' : null,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12))),
              ),
            ),
            SizedBox(
              height: 10,
            ),  Container(
              width: 320,
              child: TextField(controller: email,

                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email,
                      size: 30,
                      color: Colors.blueAccent,
                    ),
                    labelText: "EMAIL",
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "email",
                    errorText:  eestatus? 'email Can\'t Be Empty' : null,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12))),
              ),
            ),

            SizedBox(
              height: 10,
            ),
            Container(
              width: 320,
              child: TextField(controller: number,

                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.mobile_screen_share,
                      size: 30,
                      color: Colors.blueAccent,
                    ),
                    labelText: "MOBILE",
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "mobile",errorText:  enumstatus? 'number Can\'t Be Empty' : null,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12))),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 320,
              child: TextField(controller: password,

                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.vpn_key,
                      size: 30,
                      color: Colors.blueAccent,
                    ),
                    labelText: "PASSWORD",errorText:  epassstatus? 'password Can\'t Be Empty' : null,
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12))),
              ),
            ),
            SizedBox(
              height: 33,
            ),
            InkWell(onTap: () async {

              enastatus=false;
              eestatus=false;
              enumstatus=false;
              epassstatus=false;

              setState(() {


              });


              RegExp nameExp = RegExp(r"^[a-z ,.\'-]+$");
              RegExp emailExp=RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
              RegExp numberExp=RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
              RegExp passwordExp= RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

              setState(() {
                ename=name.text;
                eemail=email.text;
                enumber=number.text;
                epassword=password.text;
              });



             if(ename.isEmpty || !nameExp.hasMatch(ename))
              {
              enastatus = true;
              print("===ename$enastatus");
              setState(() {

              });
              }
              else  if(eemail.isEmpty || !emailExp.hasMatch(eemail))
              {
                eestatus = true;
                print("===email$eestatus");
                setState(() {

                });
              }
              else  if(enumber.isEmpty || !numberExp.hasMatch(enumber))
              {
                enumstatus = true;
                print("===number$enumstatus");
                setState(() {

                });
              }

              else  if(epassword.isEmpty || !passwordExp.hasMatch(epassword))
              {
                epassstatus = true;
                print("===password$epassstatus");
                setState(() {

                });
              }
               else{

                 print("yesssss");

                List<int> imagebydata=File(str).readAsBytesSync();
                String imagedata=base64Encode(imagebydata);

                Map map={
                  "name": ename,
                  "email":eemail,
                  "number": enumber,
                  "password":epassword,
                  "imagedata":imagedata
                };

                var url = Uri.parse('https://ashwinbhaiamzon.000webhostapp.com/private.php');
                var response = await http.post(url, body: map);
                print('Response status: ${response.statusCode}');
                print('Response body: ${response.body}');

                var res = jsonDecode(response.body);

                RegisterResponse rs = RegisterResponse.fromJson(res);

                setState(() {
                  if(rs.connection==1)
                    {
                      if(rs.result==1)
                        {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                            return loginpage()  ;
                          },));

                        }

                    }
                });
                setState(() {

                });
               }
               },
              child: Container(
                alignment: Alignment.center,
                height: 50,
                child: Text(
                  "Submit",
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
                width: 220,
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
  TextEditingController name=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController number=TextEditingController();
  TextEditingController password=TextEditingController();
}


class RegisterResponse {
  int? connection;
  int? result;

  RegisterResponse({this.connection, this.result});

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    return data;
  }
}
