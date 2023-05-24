import 'package:btstickets/Service/api.dart';
import 'package:btstickets/page/About/Rabbit/rabbitcard.dart';
import 'package:btstickets/page/About/TopUP/topUP_History.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class TopUp extends StatefulWidget {
  TopUp(this.customerID, this.RabbitC, this.RabbitP, {Key? key})
      : super(key: key);
  final customerID;
  final RabbitC;
  final RabbitP;
  @override
  State<TopUp> createState() => _TopUp();
}

class _TopUp extends State<TopUp> {
  var selectTopUp = "Money";
  late String topUPFrom = "Cash";
  List<String> Page = ["Money", "MasterCard"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Header(),
          Container(
            height: 170,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "วิธีชำระเงิน",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    alignment: Alignment.center,
                    width: 360,
                    height: 50,
                    child: DropdownButton(
                        hint: Text(
                          selectTopUp,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        items: Page.map((results) {
                          return DropdownMenuItem(
                              child: Text(results), value: results);
                        }).toList(),
                        onChanged: (value) {
                          selectTopUp = value.toString();
                          setState(() {});
                        })),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Container(
                //       width: 180,
                //       height: 60,
                //       decoration: BoxDecoration(
                //           color: selectTopUp == "Money"
                //               ? Color(0xffB9F8D3)
                //               : Color.fromARGB(255, 195, 193, 193),
                //           borderRadius: BorderRadius.all(Radius.circular(10))),
                //       child: FlatButton(
                //           child: const Text(
                //             "เงินสด",
                //             style: TextStyle(fontSize: 25, color: Colors.white),
                //           ),
                //           onPressed: () {
                //             selectTopUp = "Money";
                //             topUPFrom = "Cash";
                //             setState(() {});
                //           }),
                //     ),
                //     const SizedBox(
                //       width: 20,
                //     ),
                //     Container(
                //       width: 180,
                //       height: 60,
                //       decoration: BoxDecoration(
                //           color: selectTopUp == "MasterCard"
                //               ? Color(0xffB9F8D3)
                //               : Color.fromARGB(255, 195, 193, 193),
                //           borderRadius: BorderRadius.all(Radius.circular(10))),
                //       child: FlatButton(
                //           child: const Text(
                //             "MasterCard",
                //             style: TextStyle(fontSize: 25, color: Colors.white),
                //           ),
                //           onPressed: () {
                //             selectTopUp = "MasterCard";
                //             topUPFrom = "MasterCard";
                //             setState(() {});
                //           }),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
          Container(
            height: 400,
            child: SelectTopUp(selectTopUp, widget.customerID, widget.RabbitC,
                widget.RabbitP, topUPFrom),
          ),
          Container(
            height: 81,
            child: ButtonBack(),
          ),
        ],
      ),
    );
  }
}

class SelectTopUp extends StatefulWidget {
  SelectTopUp(this.selectTopUp, this.customerID, this.RabbitC, this.RabbitP,
      this.topUPFrom,
      {Key? key})
      : super(key: key);
  final String selectTopUp;
  final customerID;
  final RabbitC;
  final RabbitP;
  final topUPFrom;
  @override
  State<SelectTopUp> createState() => _SelectTopUp();
}

class _SelectTopUp extends State<SelectTopUp> {
  TextEditingController MoneyController = TextEditingController();
  TextEditingController atmIDController =
      TextEditingController(text: "7843545676878072");
  TextEditingController pinController = TextEditingController(text: "225544");
  late int inputMoney = 0;
  @override
  void initState() {
    MoneyController.text = inputMoney.toString();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.selectTopUp == "Money") {
      return Container(
        height: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "กรอกจำนวนเงิน",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            Container(
              alignment: Alignment.center,
              width: 150,
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromARGB(255, 44, 44, 44).withOpacity(0.2),
                  width: 1,
                ),
                borderRadius: new BorderRadius.circular(5),
              ),
              child: TextFormField(
                controller: MoneyController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                textAlign: TextAlign.center,
                onChanged: (e) async {
                  if (MoneyController.text == "") {
                    inputMoney = 0;
                  } else {
                    inputMoney = int.parse(MoneyController.text);
                  }

                  setState(() {});
                },
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              width: 360,
              height: 60,
              decoration: BoxDecoration(
                  color:
                      inputMoney == "" || inputMoney == null || inputMoney == 0
                          ? Color.fromARGB(255, 195, 193, 193)
                          : Color(0xffB9F8D3),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: FlatButton(
                  child: const Text(
                    "เติมเงิน",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                  onPressed: () async {
                    if (inputMoney == "" ||
                        inputMoney == null ||
                        inputMoney == 0) {
                    } else {
                      http.Response response = await AddTopUP(
                          widget.RabbitC,
                          widget.RabbitP,
                          inputMoney.toString(),
                          widget.topUPFrom);
                      print("response_AddTopUP  " +
                          response.statusCode.toString());
                      if (response.statusCode == 200) {
                        const Snackbar = SnackBar(
                          content: Text("สำเร็จ",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20)),
                          duration: Duration(seconds: 1),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(Snackbar);
                        inputMoney = 0;
                        MoneyController.text = "0";
                        setState(() {});
                      } else {
                        const Snackbar = SnackBar(
                          content: Text("ไม่สำเร็จ",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20)),
                          duration: Duration(seconds: 1),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(Snackbar);
                      }
                    }
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 20),
              child: InkWell(
                child: Container(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    "ประวัติการเติมเงิน",
                    style: TextStyle(
                        fontSize: 20, color: Color.fromARGB(255, 0, 26, 255)),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          HistoryTopUP(widget.customerID, widget.RabbitC),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      );
    }
    if (widget.selectTopUp == "MasterCard") {
      return Container(
        height: 400,
        child: Column(children: [
          const Text(
            "กรอกจำนวนเงิน",
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: 150,
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(
                color: Color.fromARGB(255, 44, 44, 44).withOpacity(0.2),
                width: 1,
              ),
              borderRadius: new BorderRadius.circular(5),
            ),
            child: TextFormField(
              controller: MoneyController,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              textAlign: TextAlign.center,
              onChanged: (e) async {
                if (MoneyController.text == "") {
                  inputMoney = 0;
                } else {
                  inputMoney = int.parse(MoneyController.text);
                }

                setState(() {});
              },
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 30)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              alignment: Alignment.center,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromARGB(255, 44, 44, 44).withOpacity(0.2),
                  width: 1,
                ),
                borderRadius: new BorderRadius.circular(5),
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(6),
                  labelText: 'ATM ID',
                  border: InputBorder.none,
                ),
                controller: atmIDController,
                textAlign: TextAlign.center,
                onChanged: (e) async {
                  setState(() {});
                },
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 30)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              alignment: Alignment.center,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromARGB(255, 44, 44, 44).withOpacity(0.2),
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
          ),
          const Padding(padding: EdgeInsets.only(top: 30)),
          Container(
            width: 360,
            height: 60,
            decoration: BoxDecoration(
                color: inputMoney == "" ||
                        inputMoney == null ||
                        inputMoney == 0 ||
                        pinController.text == null ||
                        atmIDController == null
                    ? Color.fromARGB(255, 195, 193, 193)
                    : Color(0xffB9F8D3),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: FlatButton(
                child: const Text(
                  "เติมเงิน",
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
                onPressed: () async {
                  if (inputMoney == "" ||
                      inputMoney == null ||
                      inputMoney == 0 ||
                      pinController.text == null ||
                      atmIDController == null) {
                  } else {
                    http.Response responseMasterCard = await TopUpMasterCard(
                        atmIDController.text,
                        pinController.text,
                        inputMoney.toString());
                    print("responseMasterCard " +
                        responseMasterCard.statusCode.toString());
                    if (responseMasterCard.statusCode == 200) {
                      http.Response response = await AddTopUP(
                          widget.RabbitC,
                          widget.RabbitP,
                          inputMoney.toString(),
                          widget.topUPFrom);
                      print("response_AddTopUP  " +
                          response.statusCode.toString());
                      if (response.statusCode == 200) {
                        const Snackbar = SnackBar(
                          content: Text("สำเร็จ",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20)),
                          duration: Duration(seconds: 1),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(Snackbar);
                        inputMoney = 0;
                        MoneyController.text = "0";

                        setState(() {});
                      } else {
                        const Snackbar = SnackBar(
                          content: Text("ไม่สำเร็จ",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20)),
                          duration: Duration(seconds: 1),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(Snackbar);
                      }
                    } else {
                      const Snackbar = SnackBar(
                        content: Text("ไม่สำเร็จ",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20)),
                        duration: Duration(seconds: 1),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(Snackbar);
                    }
                  }
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 20),
            child: InkWell(
              child: Container(
                alignment: Alignment.bottomRight,
                child: Text(
                  "ประวัติการเติมเงิน",
                  style: TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 0, 26, 255)),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        HistoryTopUP(widget.customerID, widget.RabbitC),
                  ),
                );
              },
            ),
          )
        ]),
      );
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
            "เติมเงิน",
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
