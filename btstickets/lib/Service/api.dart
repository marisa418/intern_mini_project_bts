import 'dart:convert';

import 'package:btstickets/Models/history_topUP.dart';
import 'package:btstickets/Models/station.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

// Login
Future<http.Response> getCustomer(String cusID) {
  return http.post(
    Uri.parse('http://192.168.86.80:50001/bts/api/v1/main/getCustomerInfo'),
    //  Uri.parse('http://192.168.1.107:50001/bts/api/v1/main/getCustomerInfo'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'cusID': cusID,
    }),
  );
}

// Buy Tikkets
Future<http.Response> SendAmountToRabbit(
    String rabbitID, String rabbitPass, String amount) {
  return http.post(
    Uri.parse('http://192.168.86.80:50001/bts/api/v1/rabbit/rabbitPay'),
    // Uri.parse('http://192.168.1.107:50001/bts/api/v1/rabbit/rabbitPay'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'rabbitID': rabbitID,
      'rabbitPass': rabbitPass,
      'amount': amount,
      'rabbitShopIDReceive': "SHOP111111"
    }),
  );
}

Future<http.Response> BuyTikkets(
    String cusID, String from, String to, String numberTicket) {
  return http.post(
    Uri.parse('http://192.168.86.80:50001/bts/api/v1/main/buyTicket'),
    // Uri.parse('http://192.168.1.107:50001/bts/api/v1/main/buyTicket'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'cusID': cusID,
      'from': from,
      'to': to,
      'numberTicket': numberTicket
    }),
  );
}

Future<http.Response> CallPriceHaveRabbit(
    String custom, String stationStart, String stationEnd, String NumTik) {
  return http.post(Uri.parse(
      'http://192.168.86.80:50001/bts/api/v1/main/btsMoneyCalculation?cusID=' +
          custom +
          '&from=' +
          stationStart +
          '&to=' +
          stationEnd +
          '&numberTicket=' +
          NumTik.toString()));
  // return http.post(Uri.parse(
  //     'http://192.168.1.107:50001/bts/api/v1/main/btsMoneyCalculation?cusID=' +
  //         custom +
  //         '&from=' +
  //         stationStart +
  //         '&to=' +
  //         stationEnd +
  //         '&numberTicket=' +
  //         NumTik.toString()));
}

Future<http.Response> CallPrice(
    String stationStart, String stationEnd, String NumTik) {
  return http.post(Uri.parse(
      'http://192.168.86.80:50001/bts/api/v1/main/calTravel?from=' +
          stationStart +
          '&to=' +
          stationEnd +
          '&numberTicket=' +
          NumTik));
  // return http.post(Uri.parse(
  //     'http://192.168.1.107:50001/bts/api/v1/main/calTravel?from=' +
  // stationStart +
  // '&to=' +
  // stationEnd +
  // '&numberTicket=' +
  // NumTik));
}

//RegisterRabbit
Future<http.Response> RegisterRabbit(
    String rabbitPin,
    String rabbitName,
    String rabbitLastName,
    String dayOfBirth,
    String monthOfBirth,
    String yearOfBirth) {
  return http.post(
    Uri.parse('http://192.168.86.80:50001/bts/api/v1/rabbit/registerRabbit'),
    // Uri.parse('http://192.168.1.107:50001/bts/api/v1/rabbit/registerRabbit'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'rabbitPin': rabbitPin,
      'rabbitName': rabbitName,
      'rabbitLastName': rabbitLastName,
      'dayOfBirth': dayOfBirth,
      'monthOfBirth': monthOfBirth,
      'yearOfBirth': yearOfBirth
    }),
  );
}

Future<http.Response> AddCard(
  String cusID,
  String rabbitID,
  String rabbitPass,
) {
  return http.post(
    Uri.parse('http://192.168.86.80:50001/bts/api/v1/main/addRabbitCard'),
    // Uri.parse('http://192.168.1.107:50001/bts/api/v1/main/addRabbitCard'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'cusID': cusID,
      'rabbitID': rabbitID,
      'rabbitPass': rabbitPass,
    }),
  );
}

Future<http.Response> AddTopUP(
  String rabbitID,
  String rabbitPass,
  String rabbitTopUp,
  String topUpFrom,
) {
  return http.post(
    Uri.parse('http://192.168.86.80:50001/bts/api/v1/rabbit/rabbitTopUp'),
    // Uri.parse('http://192.168.1.107:50001/bts/api/v1/rabbit/rabbitTopUp'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'rabbitID': rabbitID,
      'rabbitPass': rabbitPass,
      'rabbitTopUp': rabbitTopUp,
      'topUpFrom': topUpFrom
    }),
  );
}

Future<http.Response> TopUpMasterCard(
  String atmID,
  String pin,
  String amount,
) {
  return http.post(
    Uri.parse('http://192.168.86.71:50001/bank/api/v1/ATM/account/chargeATM'),
    // Uri.parse('http://192.168.1.107:50001/bts/api/v1/rabbit/rabbitTopUp'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'atmID': atmID,
      'pin': pin,
      'toAccountNumber': "2243574734",
      'amount': amount,
    }),
  );
}
