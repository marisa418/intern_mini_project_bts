import 'package:btstickets/page/about.dart';
import 'package:btstickets/page/history.dart';
import 'package:btstickets/page/tikkets.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  MainPage(this.customerID, this.RabbitC, this.RabbitP, {Key? key})
      : super(key: key);
  final String customerID;
  final String RabbitC;
  final String RabbitP;
  @override
  State<MainPage> createState() => _mainpage();
}

class _mainpage extends State<MainPage> {
  late String thispage = "BuyTikkets";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 675,
            color: Color.fromARGB(255, 107, 108, 107),
            child: ChackPage(
                thispage, widget.customerID, widget.RabbitC, widget.RabbitP),
          ),
          SizedBox(
            height: 80,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        thispage = "BuyTikkets";
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: thispage == "BuyTikkets"
                              ? const BorderSide(
                                  color: Color.fromARGB(255, 0, 0, 250),
                                  width: 3.0,
                                )
                              : const BorderSide(
                                  color: Colors.white, width: 3.0),
                        ),
                      ),
                      child: Column(
                        children: const [
                          Icon(
                            Icons.airplane_ticket_outlined,
                            size: 50,
                          ),
                          Text(
                            "ซื้อตัว",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        thispage = "History";
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: thispage == "History"
                              ? const BorderSide(
                                  color: Color.fromARGB(255, 0, 0, 250),
                                  width: 3.0,
                                )
                              : const BorderSide(
                                  color: Colors.white, width: 3.0),
                        ),
                      ),
                      child: Column(
                        children: const [
                          Icon(
                            Icons.airplane_ticket_outlined,
                            size: 50,
                          ),
                          Text(
                            "ประวัติ",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Expanded(
                //   child: GestureDetector(
                //     onTap: () {
                //       setState(() {
                //         thispage = "RabbitCard";
                //       });
                //     },
                //     child: Container(
                //       decoration: BoxDecoration(
                //         border: Border(
                //           top: thispage == "RabbitCard"
                //               ? const BorderSide(
                //                   color: Color.fromARGB(255, 0, 0, 250),
                //                   width: 3.0,
                //                 )
                //               : const BorderSide(
                //                   color: Colors.white, width: 3.0),
                //         ),
                //       ),
                //       child: Column(
                //         children: const [
                //           Icon(
                //             Icons.airplane_ticket_outlined,
                //             size: 50,
                //           ),
                //           Text(
                //             "บัตรแรบบิท",
                //             style: TextStyle(fontSize: 16),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        thispage = "AboutMe";
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: thispage == "AboutMe"
                              ? const BorderSide(
                                  color: Color.fromARGB(255, 0, 0, 250),
                                  width: 3.0,
                                )
                              : const BorderSide(
                                  color: Colors.white, width: 3.0),
                        ),
                      ),
                      child: Column(
                        children: const [
                          Icon(
                            Icons.airplane_ticket_outlined,
                            size: 50,
                          ),
                          Text(
                            "ฉัน",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChackPage extends StatefulWidget {
  ChackPage(this.thispage, this.customerID, this.RabbitC, this.RabbitP,
      {Key? key})
      : super(key: key);
  final String thispage;
  final String customerID;
  final String RabbitC;
  final String RabbitP;

  @override
  State<ChackPage> createState() => Page();
}

class Page extends State<ChackPage> {
  final CustomerIDController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (widget.thispage == "BuyTikkets") {
      return Container(
          child: Tickets(widget.customerID, widget.RabbitC, widget.RabbitP));
    }
    if (widget.thispage == "History") {
      return Container(child: History(widget.customerID));
    }
    // if (widget.thispage == "RabbitCard") {
    //   return Container(
    //       child: Rabbit(widget.customerID, widget.RabbitC, widget.RabbitP));
    // }
    if (widget.thispage == "AboutMe") {
      return Container(
          child: AboutMe(widget.customerID, widget.RabbitC, widget.RabbitP));
    }
    return Container();
  }
}
