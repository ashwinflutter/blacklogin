import 'dart:convert';
import 'dart:io';

import 'package:blacklogin/main.dart';
import 'package:blacklogin/Splashscreen.dart';
import 'package:blacklogin/clientpage.dart';
import 'package:blacklogin/viewPRoduct.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;




class addpage extends StatefulWidget {

  const addpage({Key? key}) : super(key: key);

  @override
  State<addpage> createState() => _addpageState();
}

class _addpageState extends State<addpage> {

  TextEditingController name =TextEditingController();
  TextEditingController price =TextEditingController();
  TextEditingController detail =TextEditingController();

  String str ="";

  String pname="";
  String pprice="";
  String pdetail="";
 String?  id;



  final ImagePicker _picker = ImagePicker();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id=splash_screen.preferences!.getString("id")??"";
    setState(() {

    });
    print("id=====$id");
  }

  @override
  Widget build(BuildContext context) {
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
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12))),
              ),
            ),
            SizedBox(
              height: 10,
            ),  Container(
              width: 320,
              child: TextField(controller: price,

                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.details,
                      size: 30,
                      color: Colors.blueAccent,
                    ),
                    labelText: "PRODUCT PRICE",
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12))),
              ),
            ),

            SizedBox(
              height: 10,
            ),
            Container(
              width: 320,
              child: TextField(controller: detail,

                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.money,
                      size: 30,
                      color: Colors.blueAccent,
                    ),
                    labelText: "PRODUCT DETAIL",
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12))),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            SizedBox(
              height: 33,
            ),
            InkWell(onTap: () async {


              setState(() {

                 pname=name.text;
                 pprice=price.text;
                 pdetail=detail.text;


              });

                print("yesssss");

                List<int> imagebydata=File(str).readAsBytesSync();
                String imagedata=base64Encode(imagebydata);

                Map map={
                  "loginid":id,
                  "name": pname,
                  "price": pprice,
                  "detail":pdetail,
                  "imagedata":imagedata
                };

                var url = Uri.parse('https://ashwinbhaiamzon.000webhostapp.com/maxproduct.php');
                var response = await http.post(url, body: map);
                print('Response status: ${response.statusCode}');
                print('Response body: ${response.body}');

              var pl = jsonDecode(response.body);
                productresponse pp=productresponse.fromJson(pl);

                setState(() {
                  if(pp.connection==1){
                    if(pp.result==1)
                      {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                          return clientpage();
                        },));
                      }
                  }
                });

              setState(() {

              });

            },
              child: Container(
                alignment: Alignment.center,
                height: 50,
                child: Text(
                  "ADD CART",
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


}
  class productresponse {
  int? connection;
  int? result;

  productresponse({this.connection, this.result});

  productresponse.fromJson(Map<String, dynamic> json) {
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
