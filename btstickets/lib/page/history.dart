import 'dart:convert';
import 'dart:io';
import 'package:btstickets/Models/history_buyTikkits.dart';
import 'package:btstickets/Models/station.dart';
import 'package:btstickets/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class History extends StatefulWidget {
  History(this.custom, {Key? key}) : super(key: key);
  var custom;
  @override
  State<History> createState() => HistoryPage();
}

class HistoryPage extends State<History> {
  List<history> History = [];

  _getHistory() async {
    var response = await http.get(Uri.parse(
        'http://192.168.86.80:50001//bts/api/v1/internal/getBuyTransection2'));
    // var response = await http.get(Uri.parse(
    //     'http://192.168.1.107:50001/bts/api/v1/internal/getBuyTransection2'));

    if (response.statusCode == 200) {
      History = jsonDecode(response.body)
          .map<history>((json) => history.fromJson(json))
          .toList();
    } else {
      throw 'cannot conect to server.';
    }
    return History;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _getHistory(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (History.length == 0) {}
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
                        "ประวัติการซื้อตั๋ว",
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
                    child: ListView.builder(
                        itemCount: History.length,
                        itemBuilder: (context, index) {
                          if (History[index].cusID == widget.custom) {
                            return ExpansionTile(
                              title: Text("• เลขที่คำสั่งซื้อ: " +
                                  History[index].transID),
                              subtitle: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text("  วันที่: " +
                                        DateFormat.yMMMEd()
                                            .format(History[index].date)),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text("เวลา: " +
                                        DateFormat.Hms()
                                            .format(History[index].date)),
                                  ),
                                ],
                              ),
                              children: <Widget>[
                                ListTile(
                                    title: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("ต้นทาง: " +
                                          History[index].stationStart +
                                          ": " +
                                          History[index].startName),
                                      Text("ปลายทาง: " +
                                          History[index].stationEnd +
                                          ": " +
                                          History[index].endName),
                                      Text("จำนวนตั๋ว: " +
                                          History[index]
                                              .numberTicket
                                              .toString()),
                                      Text("ราคา: " +
                                          History[index].amount.toString() +
                                          " บ."),
                                      Text(
                                        "ส่วนลด: " +
                                            History[index].discount.toString() +
                                            " บ.",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      Text(
                                        "ราคารวม: " +
                                            History[index].total.toString() +
                                            " บ.",
                                        style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 0, 8, 255)),
                                      ),
                                    ],
                                  ),
                                )),
                              ],
                            );
                          }
                          return Container();
                        })),
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
