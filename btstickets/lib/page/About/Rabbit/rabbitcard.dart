import 'dart:convert';

import 'package:btstickets/Models/cutomer.dart';
import 'package:btstickets/Models/rabbitCard.dart';
import 'package:btstickets/Service/api.dart';
import 'package:btstickets/page/About/Rabbit/historyRabbit.dart';
import 'package:btstickets/page/About/TopUP/topUP.dart';
import 'package:btstickets/page/history.dart';
import 'package:btstickets/page/tikkets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class Rabbit extends StatefulWidget {
  Rabbit(this.customerID, this.RabbitC, this.RabbitP, {Key? key})
      : super(key: key);
  final String customerID;
  final String RabbitC;
  final String RabbitP;

  @override
  State<Rabbit> createState() => _Rabbit();
}

class _Rabbit extends State<Rabbit> {
  RabbitCard? detailRabbitCard;
  late String thispage = "BuyTikkets";
  final double Monney = 400;
  DateTime start = DateTime.now();
  TextEditingController rabbitIDController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  late String rabbitID = widget.RabbitC;
  late String isPage = "Ask";

  _getRabbitCard() async {
    var response = await http.post(
      Uri.parse(
          'http://192.168.86.80:50001//bts/api/v1/rabbit/getRabbitAccInfo'),
      //   Uri.parse('http://192.168.1.107:50001//bts/api/v1/rabbit/getRabbitAccInfo'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'rabbitID': rabbitID,
        'rabbitPass': widget.RabbitP,
      }),
    );
    detailRabbitCard = RabbitCard.fromJson(jsonDecode(response.body));
    print(response.statusCode);
    return detailRabbitCard;
  }

  @override
  Widget build(BuildContext context) {
    if (rabbitID != "isEmpaty") {
      return Scaffold(
          body: FutureBuilder(
              future: _getRabbitCard(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    children: [
                      Header(),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          height: 240,
                          decoration: BoxDecoration(
                            color: Colors.purple.withOpacity(0.4),
                            border: Border.all(
                              color: Color.fromARGB(255, 44, 44, 44)
                                  .withOpacity(0.2),
                              width: 1,
                            ),
                            borderRadius: new BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, left: 10),
                                child: Container(
                                    height: 70,
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Rabbit Cart",
                                      style: TextStyle(fontSize: 40),
                                    )),
                              ),
                              Container(
                                  height: 70,
                                  alignment: Alignment.center,
                                  child: Text(
                                    rabbitID,
                                    style: TextStyle(fontSize: 30),
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 10, right: 10),
                                child: Container(
                                    height: 70,
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      detailRabbitCard!.rabbitLv,
                                      style: TextStyle(fontSize: 25),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 20,
                        ),
                        child: Container(
                          alignment: Alignment.topRight,
                          child: Text(
                            "ยอดเงิน " +
                                detailRabbitCard!.rabbitMoney.toString() +
                                " บ.",
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                  child: Container(
                                    height: 80,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.purple.withOpacity(0.4),
                                      border: Border.all(
                                        color: Color.fromARGB(255, 44, 44, 44)
                                            .withOpacity(0.2),
                                        width: 1,
                                      ),
                                      borderRadius:
                                          new BorderRadius.circular(10),
                                    ),
                                    child: Text("เติมเงิน"),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TopUp(
                                            widget.customerID,
                                            widget.RabbitC,
                                            widget.RabbitP),
                                      ),
                                    );
                                  }),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: InkWell(
                                child: Container(
                                  height: 80,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.purple.withOpacity(0.4),
                                    border: Border.all(
                                      color: Color.fromARGB(255, 44, 44, 44)
                                          .withOpacity(0.2),
                                      width: 1,
                                    ),
                                    borderRadius: new BorderRadius.circular(10),
                                  ),
                                  child: Text("ประวัติธุรกรรม"),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HistoryRabbit(
                                          widget.customerID, widget.RabbitC),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 140,
                      ),
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
              }));
    } else {
      if (isPage == "Ask") {
        return Scaffold(
            body: ListView(children: [
          Header(),
          const SizedBox(
            height: 30,
          ),
          Container(
            alignment: Alignment.center,
            child: const Text(
              "ท่านยังไม่ได้ผูก Rabbit Card",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                  child: const Text(
                    "สร้างบัตรใหม่",
                    style: TextStyle(
                        fontSize: 25, color: Color.fromARGB(255, 12, 0, 246)),
                  ),
                  onTap: () {
                    isPage = "Create";
                    setState(() {});
                  }),
              const SizedBox(
                height: 30,
                width: 30,
              ),
              InkWell(
                child: const Text(
                  "มีบัตรอยู่แล้ว",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                onTap: () {
                  isPage = "Add";
                  setState(() {});
                },
              ),
            ],
          ),
          SizedBox(
            height: 460,
          ),
          ButtonBack(),
        ]));
      }
      if (isPage == "Create") {
        return Scaffold(
          body: ListView(
            children: [
              Header(),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  child: Column(children: [
                    const Padding(padding: EdgeInsets.only(top: 30)),
                    Text(
                      "ลงทะเบียน Rabbit Card",
                      style: TextStyle(fontSize: 28),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 30)),
                    Container(
                      alignment: Alignment.center,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:
                              Color.fromARGB(255, 44, 44, 44).withOpacity(0.2),
                          width: 1,
                        ),
                        borderRadius: new BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(6),
                          labelText: 'First Name',
                          border: InputBorder.none,
                        ),
                        controller: fNameController,
                        textAlign: TextAlign.center,
                        onChanged: (e) async {
                          setState(() {});
                        },
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 30)),
                    Container(
                      alignment: Alignment.center,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:
                              Color.fromARGB(255, 44, 44, 44).withOpacity(0.2),
                          width: 1,
                        ),
                        borderRadius: new BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(6),
                          labelText: 'Last Name',
                          border: InputBorder.none,
                        ),
                        controller: lNameController,
                        textAlign: TextAlign.center,
                        onChanged: (e) async {
                          setState(() {});
                        },
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 30)),
                    Container(
                      alignment: Alignment.center,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:
                              Color.fromARGB(255, 44, 44, 44).withOpacity(0.2),
                          width: 1,
                        ),
                        borderRadius: new BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(6),
                          labelText: 'Pin',
                          border: InputBorder.none,
                        ),
                        controller: pinController,
                        textAlign: TextAlign.center,
                        onChanged: (e) async {
                          setState(() {});
                        },
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 30)),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(255, 44, 44, 44)
                              .withOpacity(0.2),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          showCupertinoModalPopup(
                            context: context,
                            builder: (context) {
                              return CupertinoTheme(
                                data: const CupertinoThemeData(
                                  brightness: Brightness.dark,
                                ),
                                child: SizedBox(
                                  height: 200,
                                  child: CupertinoDatePicker(
                                    backgroundColor: Colors.black87,
                                    initialDateTime: start,
                                    maximumDate: DateTime.now().add(
                                      const Duration(days: 1500),
                                    ),
                                    maximumYear: DateTime.now().year,
                                    minuteInterval: 1,
                                    mode: CupertinoDatePickerMode.date,
                                    use24hFormat: true,
                                    onDateTimeChanged: (e) {
                                      start = e;
                                      setState(() {});
                                    },
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 50,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromARGB(255, 44, 44, 44)
                                  .withOpacity(0.2),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                              '  Births Day: ${DateFormat(' E d MMM y').format(start)}',
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 18)),
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 80)),
                    Container(
                      width: 360,
                      height: 60,
                      decoration: BoxDecoration(
                          color: pinController.text == "" ||
                                  fNameController.text == "" ||
                                  lNameController.text == ""
                              ? Color.fromARGB(255, 76, 76, 76)
                              : Color(0xffB9F8D3),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: FlatButton(
                        child: Text("ลงทะเบียน"),
                        onPressed: () async {
                          if (pinController.text == "" ||
                              fNameController.text == "" ||
                              lNameController.text == "") {
                          } else {
                            http.Response response = await RegisterRabbit(
                                pinController.text,
                                fNameController.text,
                                lNameController.text,
                                start.day.toString(),
                                start.month.toString(),
                                start.year.toString());
                            print(response.statusCode);

                            if (response.statusCode == 200) {
                              http.Response responseAddRabbit = await AddCard(
                                widget.customerID,
                                response.body,
                                pinController.text,
                              );
                              print(responseAddRabbit.statusCode);

                              if (responseAddRabbit.statusCode == 200) {
                                Navigator.pushNamed(context, '/Login');
                                final Snackbar = SnackBar(
                                  content: Text("สำเร็จ",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 20)),
                                  duration: Duration(seconds: 1),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(Snackbar);
                              } else {
                                final Snackbar = SnackBar(
                                  content: Text("ไม่สำเร็จ",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 20)),
                                  duration: Duration(seconds: 1),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(Snackbar);
                              }
                            } else {
                              final Snackbar = SnackBar(
                                content: Text("ไม่สำเร็จ",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 20)),
                                duration: Duration(seconds: 1),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(Snackbar);
                            }
                          }
                        },
                      ),
                    )
                  ]),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ButtonBack(),
            ],
          ),
        );
      }
      if (isPage == "Add") {
        return Scaffold(
          body: ListView(
            children: [
              Header(),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  child: Column(children: [
                    const Padding(padding: EdgeInsets.only(top: 30)),
                    Text(
                      "ผูก Rabbit Card",
                      style: TextStyle(fontSize: 28),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 30)),
                    Container(
                      alignment: Alignment.center,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:
                              Color.fromARGB(255, 44, 44, 44).withOpacity(0.2),
                          width: 1,
                        ),
                        borderRadius: new BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(6),
                          labelText: 'Rabbit ID',
                          border: InputBorder.none,
                        ),
                        controller: rabbitIDController,
                        textAlign: TextAlign.center,
                        onChanged: (e) async {
                          setState(() {});
                        },
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 30)),
                    Container(
                      alignment: Alignment.center,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:
                              Color.fromARGB(255, 44, 44, 44).withOpacity(0.2),
                          width: 1,
                        ),
                        borderRadius: new BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(6),
                          labelText: 'Pin',
                          border: InputBorder.none,
                        ),
                        controller: pinController,
                        textAlign: TextAlign.center,
                        onChanged: (e) async {
                          setState(() {});
                        },
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 80)),
                    Container(
                      width: 360,
                      height: 60,
                      decoration: BoxDecoration(
                          color: pinController.text == "" ||
                                  rabbitIDController.text == ""
                              ? Color.fromARGB(255, 76, 76, 76)
                              : Color(0xffB9F8D3),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: FlatButton(
                        child: Text("ลงทะเบียน"),
                        onPressed: () async {
                          if (pinController.text == "" ||
                              rabbitIDController.text == "") {
                          } else {
                            http.Response responseAddRabbit = await AddCard(
                              widget.customerID,
                              rabbitIDController.text,
                              pinController.text,
                            );
                            print(responseAddRabbit.statusCode);

                            if (responseAddRabbit.statusCode == 200) {
                              Navigator.pushNamed(context, '/Login');
                              final Snackbar = SnackBar(
                                content: Text("สำเร็จ",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 20)),
                                duration: Duration(seconds: 1),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(Snackbar);
                            } else {
                              final Snackbar = SnackBar(
                                content: Text("ไม่สำเร็จ",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 20)),
                                duration: Duration(seconds: 1),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(Snackbar);
                            }
                          }
                        },
                      ),
                    )
                  ]),
                ),
              ),
              SizedBox(
                height: 170,
              ),
              ButtonBack(),
            ],
          ),
        );
      }
    }
    return Container();
  }
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
            "Rabbit Card",
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
          Text(
            DateFormat.yMMMEd().format(DateTime.now()),
            style:
                TextStyle(fontSize: 20, color: Color.fromARGB(255, 84, 84, 84)),
          ),
        ],
      ),
    );
  }
}

class ButtonBack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            child: Container(
              width: 140,
              height: 50,
              decoration: const BoxDecoration(
                color: Color(0xffB9F8D3),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.arrow_left, color: Colors.grey),
                  Text(
                    'ย้อนกลับ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.grey),
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
