class HistoryRabbits {
  final String transRabbitID;
  final String shopName;
  final String rabbitID;
  final int amount;
  final int discount;
  final int total;

  final DateTime date;
  HistoryRabbits({
    required this.transRabbitID,
    required this.shopName,
    required this.rabbitID,
    required this.amount,
    required this.discount,
    required this.total,
    required this.date,
  });
  HistoryRabbits.fromJson(parsedJson)
      : transRabbitID = parsedJson['transRabbitID'],
        shopName = parsedJson['shopName'],
        rabbitID = parsedJson['rabbitID'],
        amount = parsedJson['amount'],
        discount = parsedJson['discount'],
        total = parsedJson['total'],
        date = DateTime.parse(parsedJson['timeStamp']);
}
