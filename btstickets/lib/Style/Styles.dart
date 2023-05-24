import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HeadStyles extends StatefulWidget {
  HeadStyles(this.Name, {Key? key}) : super(key: key);
  final Name;

  @override
  State<HeadStyles> createState() => _HeadStyles();
}

class _HeadStyles extends State<HeadStyles> {
  final String Name = "";
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
          Text(
            Name,
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
