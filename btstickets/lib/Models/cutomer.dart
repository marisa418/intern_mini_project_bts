class Customer {
  final String cusID;
  final String Fname;
  final String Lname;
  var rabbitCardID;

  final String rabbitPass;

  Customer({
    required this.cusID,
    required this.Fname,
    required this.Lname,
    required this.rabbitCardID,
    required this.rabbitPass,
  });

  factory Customer.fromJson(Map<String, dynamic> parsedJson) {
    var pRes = Customer(
      cusID: parsedJson['cusID'],
      Fname: parsedJson['cusName'],
      Lname: parsedJson['cusLastName'],
      rabbitCardID: parsedJson['rabbitCardID'] == null
          ? "isEmpaty"
          : parsedJson['rabbitCardID'],
      rabbitPass: parsedJson['rabbitCardPass'] == null
          ? "isEmpaty"
          : parsedJson['rabbitCardPass'],
    );
    return pRes;
  }
}
