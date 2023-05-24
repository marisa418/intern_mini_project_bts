class history {
  final String transID;
  final String cusID;
  final String stationStart;
  final String startName;
  final String stationEnd;
  final String endName;
  final int amount;
  final int discount;
  final int total;
  final int numberTicket;
  final DateTime date;
  history({
    required this.transID,
    required this.cusID,
    required this.stationStart,
    required this.startName,
    required this.stationEnd,
    required this.endName,
    required this.amount,
    required this.discount,
    required this.total,
    required this.numberTicket,
    required this.date,
  });
  history.fromJson(parsedJson)
      : transID = parsedJson['transID'],
        cusID = parsedJson['cusID'],
        stationStart = parsedJson['stationStart'],
        startName = parsedJson['startName'],
        stationEnd = parsedJson['stationEnd'],
        endName = parsedJson['endName'],
        amount = parsedJson['amount'],
        discount = parsedJson['discount'],
        total = parsedJson['total'],
        numberTicket = parsedJson['numberTicket'],
        date = DateTime.parse(parsedJson['timeStamp']);
}
