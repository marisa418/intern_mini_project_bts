import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:btstickets/Models/callPrice.dart';
import 'package:btstickets/Models/cutomer.dart';
import 'package:btstickets/Models/history_topUP.dart';
import 'package:btstickets/Models/station.dart';
import 'package:btstickets/Service/api.dart';
import 'package:btstickets/main.dart';
import 'package:btstickets/page/About/Rabbit/rabbitcard.dart';
import 'package:btstickets/page/history.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class Tickets extends StatefulWidget {
  Tickets(this.custom, this.RabbitC, this.RabbitP, {Key? key})
      : super(key: key);
  var custom;
  final String RabbitC;
  final String RabbitP;
  @override
  State<Tickets> createState() => Ticket();
}

class Ticket extends State<Tickets> {
  List<Station> Stations = [];
  CalCulatePrice? callPrice;
  var stationStart;
  var stationEnd;
  late int NumTik = 1;
  late int toTalPrice = 0;
  late int discount = 0;
  TextEditingController tikketsCdrl = TextEditingController();

  _getStations() async {
    var response = await http.get(Uri.parse(
        'http://192.168.86.80:50001//bts/api/v1/internal/getStation2'));
    // var response = await http.get(Uri.parse(
    //     'http://192.168.1.107:50001//bts/api/v1/internal/getStation2'));

    if (response.statusCode == 200) {
      Stations = jsonDecode(response.body)
          .map<Station>((json) => Station.fromJson(json))
          .toList();
    } else {
      throw 'cannot conect to server.';
    }
    return Stations;
  }

  @override
  void initState() {
    tikketsCdrl.text = NumTik.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _getStations(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: [
                Container(
                  alignment: Alignment.center,
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
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "จำหน่ายตั๋วเดินทาง",
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                      Text(
                        DateFormat.yMMMEd().format(DateTime.now()),
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 84, 84, 84)),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 360,
                  height: 575,
                  child: Column(
                    children: [
                      const Padding(padding: EdgeInsets.only(top: 20)),
                      Container(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text(
                            "ผู้ใช้  " + widget.custom,
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 30, bottom: 10, top: 10),
                        child: Container(
                            alignment: Alignment.topLeft,
                            child: const Text(
                              "ต้นทาง",
                              style: TextStyle(fontSize: 20),
                            )),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 360,
                        height: 40,
                        color: Color(0xffB9F8D3).withOpacity(0.2),
                        child: DropdownButton(
                          hint: stationStart == null
                              ? Text("เลือกสถานี")
                              : Text(stationStart.toString()),
                          items: Stations.map((results) {
                            return DropdownMenuItem(
                                child: Text(results.stationID +
                                    ": " +
                                    results.stationName),
                                value: results.stationID);
                          }).toList(),
                          onChanged: (value) async {
                            if (stationEnd == null) {
                              stationStart = value;
                            } else {
                              if (value == stationEnd) {
                                stationStart = null;
                                const Snackbar = SnackBar(
                                  content: Text("โปรดเลือกสถานีที่แตกต่างกัน",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 20)),
                                  duration: Duration(seconds: 1),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(Snackbar);
                              } else {
                                stationStart = value;
                                if (widget.RabbitC == "isEmpaty") {
                                  http.Response response = await CallPrice(
                                      stationStart,
                                      stationEnd,
                                      NumTik.toString());
                                  toTalPrice = int.parse(response.body);
                                } else {
                                  http.Response response =
                                      await CallPriceHaveRabbit(
                                          widget.custom,
                                          stationStart,
                                          stationEnd,
                                          NumTik.toString());
                                  callPrice = CalCulatePrice.fromJson(
                                      jsonDecode(response.body));
                                  toTalPrice = callPrice!.total;
                                  discount = callPrice!.discount;
                                }
                              }
                            }
                            setState(() {});
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 30, bottom: 10, top: 30),
                        child: Container(
                            alignment: Alignment.topLeft,
                            child: const Text(
                              "ปลายทาง",
                              style: TextStyle(fontSize: 20),
                            )),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 360,
                        height: 40,
                        color: Color(0xffB9F8D3).withOpacity(0.2),
                        child: DropdownButton(
                          hint: stationEnd == null
                              ? Text("เลือกสถานี")
                              : Text(stationEnd.toString()),
                          items: Stations.map((results) {
                            return DropdownMenuItem(
                              child: new Text(results.stationID +
                                  ": " +
                                  results.stationName),
                              value: results.stationID,
                            );
                          }).toList(),
                          onChanged: (value) async {
                            if (stationStart == null) {
                              stationEnd = value;
                            } else {
                              if (value == stationStart) {
                                stationEnd = null;
                                const Snackbar = SnackBar(
                                  content: Text("โปรดเลือกสถานีที่แตกต่างกัน",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 20)),
                                  duration: Duration(seconds: 1),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(Snackbar);
                              } else {
                                stationEnd = value;
                                if (widget.RabbitC == "isEmpaty") {
                                  http.Response response = await CallPrice(
                                      stationStart,
                                      stationEnd,
                                      NumTik.toString());
                                  toTalPrice = int.parse(response.body);
                                } else {
                                  http.Response response =
                                      await CallPriceHaveRabbit(
                                          widget.custom,
                                          stationStart,
                                          stationEnd,
                                          NumTik.toString());

                                  callPrice = CalCulatePrice.fromJson(
                                      jsonDecode(response.body));
                                  toTalPrice = callPrice!.total;
                                  discount = callPrice!.discount;
                                }
                              }
                            }
                            setState(() {});
                          },
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 30)),
                      Text(
                        "ราคารวม  " + toTalPrice.toString() + "  บ.",
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        callPrice == null
                            ? ""
                            : "หักส่วนลด  " + discount.toString() + "  บ.",
                        style: TextStyle(fontSize: 15, color: Colors.red),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 25)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "จำนวนตั๋ว   ",
                            style: TextStyle(fontSize: 20),
                          ),
                          InkWell(
                            child: Text(
                              "  -  ",
                              style: TextStyle(fontSize: 40),
                            ),
                            onTap: () async {
                              NumTik -= 1;

                              if (NumTik < 1) {
                                NumTik = 1;
                              } else {
                                if (stationStart == null ||
                                    stationEnd == null) {
                                } else {
                                  if (widget.RabbitC == "isEmpaty") {
                                    http.Response response = await CallPrice(
                                        stationStart,
                                        stationEnd,
                                        NumTik.toString());
                                    toTalPrice = int.parse(response.body);
                                  } else {
                                    http.Response response =
                                        await CallPriceHaveRabbit(
                                            widget.custom,
                                            stationStart,
                                            stationEnd,
                                            NumTik.toString());
                                    callPrice = CalCulatePrice.fromJson(
                                        jsonDecode(response.body));
                                    toTalPrice = callPrice!.total;
                                    discount = callPrice!.discount;
                                  }
                                }
                              }
                              tikketsCdrl.text = NumTik.toString();
                              setState(() {});
                            },
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: 40,
                            height: 30,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color.fromARGB(255, 44, 44, 44)
                                    .withOpacity(0.2),
                                width: 1,
                              ),
                              borderRadius: new BorderRadius.circular(5),
                            ),
                            child: TextFormField(
                              controller: tikketsCdrl,
                              // key: Key(NumTik.toString()),
                              textAlign: TextAlign.center,
                              //  initialValue: NumTik.toString(),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                              ],
                              onChanged: (e) async {
                                if (stationStart == null ||
                                    stationEnd == null) {
                                  if (tikketsCdrl.text == "0") {
                                    tikketsCdrl.text = "1";
                                    NumTik = int.parse(tikketsCdrl.text);
                                  }
                                  if (tikketsCdrl.text == "") {
                                    tikketsCdrl.text = "1";
                                    NumTik = int.parse(tikketsCdrl.text);
                                  }
                                  if (tikketsCdrl.text != "") {
                                    NumTik = int.parse(tikketsCdrl.text);
                                  }
                                } else {
                                  if (tikketsCdrl.text == "0") {
                                    tikketsCdrl.text = "1";
                                    NumTik = int.parse(tikketsCdrl.text);
                                    if (widget.RabbitC == "isEmpaty") {
                                      http.Response response = await CallPrice(
                                          stationStart,
                                          stationEnd,
                                          NumTik.toString());
                                      toTalPrice = int.parse(response.body);
                                    } else {
                                      http.Response response =
                                          await CallPriceHaveRabbit(
                                              widget.custom,
                                              stationStart,
                                              stationEnd,
                                              NumTik.toString());
                                      callPrice = CalCulatePrice.fromJson(
                                          jsonDecode(response.body));
                                      toTalPrice = callPrice!.total;
                                      discount = callPrice!.discount;
                                    }
                                  }
                                  if (tikketsCdrl.text == "") {
                                    tikketsCdrl.text = "1";
                                    NumTik = int.parse(tikketsCdrl.text);
                                    if (widget.RabbitC == "isEmpaty") {
                                      http.Response response = await CallPrice(
                                          stationStart,
                                          stationEnd,
                                          NumTik.toString());
                                      toTalPrice = int.parse(response.body);
                                    } else {
                                      http.Response response =
                                          await CallPriceHaveRabbit(
                                              widget.custom,
                                              stationStart,
                                              stationEnd,
                                              NumTik.toString());
                                      callPrice = CalCulatePrice.fromJson(
                                          jsonDecode(response.body));
                                      toTalPrice = callPrice!.total;
                                      discount = callPrice!.discount;
                                    }
                                  }
                                  if (tikketsCdrl.text != "") {
                                    NumTik = int.parse(tikketsCdrl.text);
                                    if (widget.RabbitC == "isEmpaty") {
                                      http.Response response = await CallPrice(
                                          stationStart,
                                          stationEnd,
                                          NumTik.toString());
                                      toTalPrice = int.parse(response.body);
                                    } else {
                                      http.Response response =
                                          await CallPriceHaveRabbit(
                                              widget.custom,
                                              stationStart,
                                              stationEnd,
                                              NumTik.toString());
                                      callPrice = CalCulatePrice.fromJson(
                                          jsonDecode(response.body));
                                      toTalPrice = callPrice!.total;
                                      discount = callPrice!.discount;
                                    }
                                  }
                                }

                                setState(() {});
                              },
                            ),
                          ),
                          InkWell(
                            child: Text(
                              "  +  ",
                              style: TextStyle(fontSize: 30),
                            ),
                            onTap: () async {
                              NumTik += 1;
                              tikketsCdrl.text = NumTik.toString();

                              if (stationStart == null || stationEnd == null) {
                              } else {
                                if (widget.RabbitC == "isEmpaty") {
                                  http.Response response = await CallPrice(
                                      stationStart,
                                      stationEnd,
                                      NumTik.toString());
                                  toTalPrice = int.parse(response.body);
                                } else {
                                  http.Response response =
                                      await CallPriceHaveRabbit(
                                          widget.custom,
                                          stationStart,
                                          stationEnd,
                                          NumTik.toString());
                                  callPrice = CalCulatePrice.fromJson(
                                      jsonDecode(response.body));
                                  toTalPrice = callPrice!.total;
                                  discount = callPrice!.discount;
                                }
                              }
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(top: 50)),
                      Container(
                        width: 360,
                        height: 60,
                        decoration: BoxDecoration(
                            color: widget.custom == null ||
                                    stationStart == null ||
                                    stationEnd == null ||
                                    NumTik == 0
                                ? Color.fromARGB(255, 76, 76, 76)
                                : Color(0xffB9F8D3),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: FlatButton(
                          child: const Text(
                            "ซื้อตั๋ว",
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                          onPressed: () async {
                            if (widget.custom == null ||
                                stationStart == null ||
                                stationEnd == null ||
                                NumTik == 0) {
                            } else {
                              if (widget.RabbitC == "isEmpaty") {
                                showPlatformDialog(
                                  context: context,
                                  builder: (context) => BasicDialogAlert(
                                    title: Text("ท่านยังไม่มีบัตร Rabbit Cart"),
                                    content:
                                        Text("ท่านต้องการสร้างบัตรเลยหรือไม่"),
                                    actions: <Widget>[
                                      BasicDialogAction(
                                        title: Text("ตกลง"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Rabbit(
                                                  widget.custom,
                                                  widget.RabbitC,
                                                  widget.RabbitP),
                                            ),
                                          );
                                        },
                                      ),
                                      BasicDialogAction(
                                        title: Text("ไม่"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                http.Response response = await BuyTikkets(
                                    widget.custom,
                                    stationStart,
                                    stationEnd,
                                    NumTik.toString());
                                print("response_BuyTikkets  " +
                                    response.statusCode.toString());
                                stationStart = null;
                                stationEnd = null;
                                NumTik = 1;
                                toTalPrice = 0;
                                discount = 0;
                                tikketsCdrl.text = "1";
                                setState(() {});
                                if (response.statusCode == 200) {
                                  const Snackbar = SnackBar(
                                    content: Text("สำเร็จ",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 20)),
                                    duration: Duration(seconds: 1),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(Snackbar);
                                  // http.Response responseRabbit =
                                  //     await SendAmountToRabbit(
                                  //   widget.RabbitC,
                                  //   widget.RabbitP,
                                  //   toTalPrice.toString(),
                                  // );
                                  // print("response_SendAmountToRabbit  " +
                                  //     responseRabbit.statusCode.toString());
                                  // if (responseRabbit.statusCode == 200) {
                                  //   const Snackbar = SnackBar(
                                  //     content: Text("สำเร็จ",
                                  //         textAlign: TextAlign.center,
                                  //         style: TextStyle(fontSize: 20)),
                                  //     duration: Duration(seconds: 1),
                                  //   );
                                  //   ScaffoldMessenger.of(context)
                                  //       .showSnackBar(Snackbar);
                                  //   stationStart = null;
                                  //   stationEnd = null;
                                  //   NumTik = 1;
                                  //   toTalPrice = 0;

                                  //   setState(() {});
                                  // } else
                                  // {
                                  //   const Snackbar = SnackBar(
                                  //     content: Text("ไม่สำเร็จ",
                                  //         textAlign: TextAlign.center,
                                  //         style: TextStyle(fontSize: 20)),
                                  //     duration: Duration(seconds: 1),
                                  //   );
                                  //   ScaffoldMessenger.of(context)
                                  //       .showSnackBar(Snackbar);
                                  // }
                                } else {
                                  const Snackbar = SnackBar(
                                    content: Text("ไม่สำเร็จ",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 20)),
                                    duration: Duration(seconds: 1),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(Snackbar);
                                }
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  CircularProgressIndicator(),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
