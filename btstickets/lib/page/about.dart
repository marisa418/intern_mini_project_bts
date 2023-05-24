// ignore_for_file: prefer_const_constructors

import 'package:btstickets/page/About/Rabbit/rabbitcard.dart';
import 'package:btstickets/page/About/TopUP/topUP.dart';
import 'package:btstickets/page/history.dart';

import 'package:btstickets/page/tikkets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:intl/intl.dart';

class AboutMe extends StatefulWidget {
  AboutMe(this.customerID, this.RabbitC, this.RabbitP, {Key? key})
      : super(key: key);
  final customerID;
  final RabbitC;
  final RabbitP;
  @override
  State<AboutMe> createState() => _AboutMe();
}

class _AboutMe extends State<AboutMe> {
  late String thispage = "BuyTikkets";
  final double Monney = 400;
  @override
  Widget build(BuildContext context) {
    if (widget.RabbitC != null) {
      return Scaffold(
        body: ListView(
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
                    "ข้อมูลส่วนตัว",
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                  Text(
                    DateFormat.yMMMEd().format(DateTime.now()),
                    style: TextStyle(
                        fontSize: 20, color: Color.fromARGB(255, 84, 84, 84)),
                  ),
                ],
              ),
            ),
            // CircleAvatar(
            //   radius: 50,
            // ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                child: Column(
                  children: [
                    // InkWell(
                    //   child: Container(
                    //       height: 50,
                    //       alignment: Alignment.centerLeft,
                    //       decoration: BoxDecoration(
                    //         border: Border(
                    //             bottom: const BorderSide(
                    //           color: Color.fromARGB(255, 168, 168, 171),
                    //           width: 1.0,
                    //         )),
                    //       ),
                    //       child: Text(
                    //         "ยอดเงิน: " + Monney.toStringAsFixed(2) + "  บ.",
                    //         style: TextStyle(
                    //           fontSize: 20,
                    //         ),
                    //       )),
                    //   onTap: () {},
                    // ),
                    InkWell(
                      child: Container(
                          height: 50,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            border: Border(
                                bottom: const BorderSide(
                              color: Color.fromARGB(255, 168, 168, 171),
                              width: 1.0,
                            )),
                          ),
                          child: const Text(
                            "เติมเงิน",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          )),
                      onTap: () {
                        if (widget.RabbitC == "isEmpaty") {
                          showPlatformDialog(
                            context: context,
                            builder: (context) => BasicDialogAlert(
                              title: Text("ท่านยังไม่มีบัตร Rabbit Cart"),
                              content: Text("ท่านต้องการสร้างบัตรเลยหรือไม่"),
                              actions: <Widget>[
                                BasicDialogAction(
                                  title: Text("ตกลง"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Rabbit(
                                            widget.customerID,
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TopUp(widget.customerID,
                                  widget.RabbitC, widget.RabbitP),
                            ),
                          );
                        }
                      },
                    ),
                    InkWell(
                      child: Container(
                          height: 50,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            border: Border(
                                bottom: const BorderSide(
                              color: Color.fromARGB(255, 168, 168, 171),
                              width: 1.0,
                            )),
                          ),
                          child: const Text(
                            "Rabbit Card",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          )),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Rabbit(widget.customerID,
                                widget.RabbitC, widget.RabbitP),
                          ),
                        );
                      },
                    ),
                    InkWell(
                      child: Container(
                          height: 50,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            border: Border(
                                bottom: const BorderSide(
                              color: Color.fromARGB(255, 168, 168, 171),
                              width: 1.0,
                            )),
                          ),
                          child: Text(
                            "ออกจากระบบ",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          )),
                      onTap: () {
                        Navigator.pushNamed(context, '/Login');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
    return Container();
  }
}
