class CalCulatePrice {
  final int amount;
  final int discount;
  final int total;
  final int balance;
  CalCulatePrice({
    required this.amount,
    required this.discount,
    required this.total,
    required this.balance,
  });

  factory CalCulatePrice.fromJson(Map<String, dynamic> parsedJson) {
    var price = CalCulatePrice(
      amount: parsedJson['amount'],
      discount: parsedJson['discount'],
      total: parsedJson['total'],
      balance: parsedJson['balance'],
    );
    return price;
  }
}
