import 'dart:convert';
import 'dart:io';
import 'package:btstickets/Models/cutomer.dart';
import 'package:btstickets/Models/history_topUP.dart';
import 'package:btstickets/Models/station.dart';
import 'package:btstickets/Service/api.dart';
import 'package:btstickets/main.dart';
import 'package:btstickets/page/home.dart';
import 'package:btstickets/page/tikkets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  Customer? CustomerRes;
  final CustomerIDController = TextEditingController();
  late String res_e = " ";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            width: 360,
            height: 100,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Color(0xff40DFEF),
                  Color(0xff40DFEF),
                  Color(0xffB9F8D3),
                  Colors.white,
                ],
                tileMode: TileMode.mirror,
              ),
            ),
          ),
          Container(
            width: 360,
            height: 550,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(255, 44, 44, 44).withOpacity(0.2),
                        width: 1,
                      ),
                      borderRadius: new BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: CustomerIDController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(6),
                        labelText: 'CustomerID',
                        floatingLabelAlignment: FloatingLabelAlignment.start,
                        fillColor: const Color.fromARGB(255, 255, 255, 255)
                            .withOpacity(0.2),
                        filled: true,
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      res_e,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 50)),
                  Container(
                    width: 360,
                    height: 60,
                    decoration: const BoxDecoration(
                        color: Color(0xffB9F8D3),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: FlatButton(
                      child: const Text(
                        "เข้าสู่ระบบ",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () async {
                        http.Response response =
                            await getCustomer(CustomerIDController.text);

                        if (response.statusCode == 200) {
                          CustomerRes =
                              Customer.fromJson(jsonDecode(response.body));
                          final custom = CustomerRes!.cusID;
                          final RabbitC = CustomerRes!.rabbitCardID;
                          final RabbitP = CustomerRes!.rabbitPass.toString();

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MainPage(custom, RabbitC, RabbitP),
                            ),
                          );
                        } else {
                          print("11111111");
                          res_e = "ชื่อผู้ใช้ไม่ถูกต้อง";
                          setState(() {});
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
