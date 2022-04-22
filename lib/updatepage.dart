import 'dart:convert';
import 'dart:io';

import 'package:blacklogin/viewPRoduct.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'clientpage.dart';

class updatepage extends StatefulWidget {

  Productdata productdata;
  updatepage(Productdata this.productdata);

  @override
  State<updatepage> createState() => _updatepageState();
}

class _updatepageState extends State<updatepage> {
  TextEditingController tname = TextEditingController();
  TextEditingController tprice = TextEditingController();
  TextEditingController tdetail = TextEditingController();

  String str = "";
  String id ="";
  String imagename = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imagename = widget.productdata.proimage!;
    id = widget.productdata.id!;
    setState(() {});
    getdata();
  }

  void getdata() {
    tname.text = widget.productdata.name!;
    tprice.text = widget.productdata.price!;
    tdetail.text = widget.productdata.detail!;
  }

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 70),
            InkWell(
                onTap: () async {
                  final XFile? image =
                      await _picker.pickImage(source: ImageSource.gallery);
                  str = image!.path;
                  setState(() {});
                },
                child: str != ""
                    ? CircleAvatar(
                        backgroundImage: FileImage(File(str)),
                      )
                    : CircleAvatar(
                        radius: 72,
                        backgroundImage: NetworkImage(
                            "https://ashwinbhaiamzon.000webhostapp.com/${widget.productdata.proimage}"),
                      )),
            SizedBox(
              height: 30,
            ),
            Container(
              width: 320,
              child: TextField(
                controller: tname,
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
            ),
            Container(
              width: 320,
              child: TextField(
                controller: tprice,
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
              child: TextField(
                controller: tdetail,
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
            InkWell(
              onTap: () async {
                setState(() {


                  List<int> imagebydata = File(str).readAsBytesSync();
                  String imagedataa = base64Encode(imagebydata);

                  String namee = tname.text;
                  String price = tprice.text;
                  String detail = tdetail.text;
                  setState(() {

                  });

                   map = {
                    "id": id,
                    "namee": namee,
                    "price": price,
                    "detail": detail,
                    "imagedataa": imagedataa,
                    "imagename": imagename
                  };
                });

                print("yesssss");

                setState(() {});

                var url = Uri.parse(
                    'https://ashwinbhaiamzon.000webhostapp.com/update.php');
                var response = await http.post(url, body: map);
                print('Response status: ${response.statusCode}');
                print('Response body: ${response.body}');

                var rr = jsonDecode(response.body);

                UpdateResponse mm = UpdateResponse.fromJson(rr);

                if(mm.connection==1)
                  {
                   if(mm.result==1)
                     {
                       Navigator.pushReplacement(context, MaterialPageRoute(
                         builder: (context) {
                           return clientpage();
                         },
                       ));
                     }
                  }



              },
              child: Container(
                alignment: Alignment.center,
                height: 50,
                child: Text(
                  "UPDATE DATA",
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
                width: 220,
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

  Map map  = {};
}

class UpdateResponse {
  int? connection;
  int? result;

  UpdateResponse({this.connection, this.result});

  UpdateResponse.fromJson(Map<String, dynamic> json) {
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
