class HistoryTopUp {
  final String transRabbitID;
  final String rabbitID;
  final int rabbitTopUp;
  final String topUpFrom;
  final DateTime date;
  HistoryTopUp({
    required this.transRabbitID,
    required this.rabbitID,
    required this.rabbitTopUp,
    required this.topUpFrom,
    required this.date,
  });
  HistoryTopUp.fromJson(parsedJson)
      : transRabbitID = parsedJson['transRabbitID'],
        rabbitID = parsedJson['rabbitID'],
        rabbitTopUp = parsedJson['rabbitTopUp'],
        topUpFrom = parsedJson['topUpFrom'],
        date = DateTime.parse(parsedJson['timeStamp']);
}
