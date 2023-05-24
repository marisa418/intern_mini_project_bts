import 'dart:convert';
import 'dart:io';
import 'package:btstickets/Models/history_buyTikkits.dart';
import 'package:btstickets/Models/history_rabbit.dart';
import 'package:btstickets/Models/station.dart';
import 'package:btstickets/main.dart';
import 'package:btstickets/page/About/Rabbit/rabbitcard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class HistoryRabbit extends StatefulWidget {
  HistoryRabbit(this.custom, this.RabbitC, {Key? key}) : super(key: key);
  final custom;
  final RabbitC;
  @override
  State<HistoryRabbit> createState() => _HistoryRabbit();
}

class _HistoryRabbit extends State<HistoryRabbit> {
  List<HistoryRabbits> historyRabbit = [];

  _getHistoryRabbit() async {
    var response = await http.get(Uri.parse(
        'http://192.168.86.80:50001/bts/api/v1/rabbitinternal/getRabbitPayTransection'));
    // var response = await http.get(Uri.parse(
    //     'http://192.168.1.107:50001/bts/api/v1/rabbitinternal/getRabbitPayTransection'));

    if (response.statusCode == 200) {
      historyRabbit = jsonDecode(response.body)
          .map<HistoryRabbits>((json) => HistoryRabbits.fromJson(json))
          .toList();
    } else {
      throw 'cannot conect to server.';
    }
    return historyRabbit;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _getHistoryRabbit(),
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
                        "ประวัติการใช้จ่าย",
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
                        itemCount: historyRabbit.length,
                        itemBuilder: (context, index) {
                          if (historyRabbit[index].rabbitID == widget.RabbitC) {
                            return ListTile(
                                title: Padding(
                              padding: const EdgeInsets.only(left: 10, top: 10),
                              child: Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                    color: Color.fromARGB(255, 148, 148, 148),
                                    width: 1,
                                  )),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "ชำระสินค้ากับ " +
                                          historyRabbit[index].shopName,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Text(DateFormat.yMMMEd()
                                            .format(historyRabbit[index].date) +
                                        "  ," +
                                        DateFormat.Hms()
                                            .format(historyRabbit[index].date)),
                                    Container(
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        "- " +
                                            historyRabbit[index]
                                                .total
                                                .toString() +
                                            "  THB",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ));
                          }
                          return Container();
                        })),
                ButtonBack(),
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
