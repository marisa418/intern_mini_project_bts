class RabbitCard {
  final String rabbitID;
  final String rabbitLv;
  final int rabbitMoney;
  RabbitCard({
    required this.rabbitID,
    required this.rabbitLv,
    required this.rabbitMoney,
  });

  factory RabbitCard.fromJson(Map<String, dynamic> parsedJson) {
    var pRes = RabbitCard(
      rabbitID: parsedJson['rabbitID'],
      rabbitLv: parsedJson['rabbitLv'],
      rabbitMoney: parsedJson['rabbitMoney'],
    );
    return pRes;
  }
}
