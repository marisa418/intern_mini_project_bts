class Station {
  final String stationID;
  final String stationName;
  final int stationIndex;

  Station(
      {required this.stationID,
      required this.stationName,
      required this.stationIndex});
  Station.fromJson(parsedJson)
      : stationID = parsedJson['stationID'],
        stationName = parsedJson['stationName'],
        stationIndex = parsedJson['stationIndex'];
}
