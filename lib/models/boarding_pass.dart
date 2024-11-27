class BoardingPass {
  final String id;
  final String name;
  final String departureAirportCode;
  final String departureTime;
  final String arrivalAirportCode;

  final String arrivalTime;
  final String classOfTravel;
  final String airlineCode;
  final String flightNumber;
  final String visitStatus;
  final bool isFlightReviewed;
  final bool isDepartureAirportReviewed;
  final bool isArrivalAirportReviewed;

  BoardingPass({
    this.id = '',
    this.name = '',
    this.departureAirportCode = '',
    this.departureTime = '',
    this.arrivalAirportCode = '',
    this.arrivalTime = '',
    this.classOfTravel = '',
    this.airlineCode = '',
    this.flightNumber = '',
    this.visitStatus = '',
    this.isFlightReviewed = false,
    this.isDepartureAirportReviewed = false,
    this.isArrivalAirportReviewed = false,
  });

  BoardingPass copyWith({
    String? id,
    String? name,
    String? departureAirportCode,
    String? departureTime,
    String? arrivalAirportCode,
    String? arrivalTime,
    String? classOfTravel,
    String? airlineCode,
    String? flightNumber,
    String? visitStatus,
    bool? isFlightReviewed,
    bool? isDepartureAirportReviewed,
    bool? isArrivalAirportReviewed,
  }) {
    return BoardingPass(
      id: id ?? this.id,
      name: name ?? this.name,
      departureAirportCode: departureAirportCode ?? this.departureAirportCode,
      departureTime: departureTime ?? this.departureTime,
      arrivalAirportCode: arrivalAirportCode ?? this.arrivalAirportCode,
      arrivalTime: arrivalTime ?? this.arrivalTime,
      classOfTravel: classOfTravel ?? this.classOfTravel,
      airlineCode: airlineCode ?? this.airlineCode,
      flightNumber: flightNumber ?? this.flightNumber,
      visitStatus: visitStatus ?? this.visitStatus,
      isFlightReviewed: isFlightReviewed ?? this.isFlightReviewed,
      isDepartureAirportReviewed:
          isDepartureAirportReviewed ?? this.isDepartureAirportReviewed,
      isArrivalAirportReviewed:
          isArrivalAirportReviewed ?? this.isArrivalAirportReviewed,
    );
  }

  factory BoardingPass.fromJson(Map<String, dynamic> json) {
    return BoardingPass(
      id:json['_id'] ?? '',
      name: json['name'] ?? '',
      departureAirportCode: json['departureAirportCode'] ?? '',
      departureTime: json['departureTime'] ?? '',
      arrivalAirportCode: json['arrivalAirportCode'] ?? '',
      arrivalTime: json['arrivalTime'] ?? '',
      classOfTravel: json['classOfTravel'] ?? '',
      airlineCode: json['airlineCode'] ?? '',
      flightNumber: json['flightNumber'] ?? '',
      visitStatus: json['visitStatus'] ?? '',
      isFlightReviewed: json['isFlightReviewed'] ?? false,
      isDepartureAirportReviewed: json['isDepartureAirportReviewed'] ?? false,
      isArrivalAirportReviewed: json['isArrivalAirportReviewed'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'departureAirportCode': departureAirportCode,
      'departureTime': departureTime,
      'arrivalAirportCode': arrivalAirportCode,
      'arrivalTime': arrivalTime,
      'classOfTravel': classOfTravel,
      'airlineCode': airlineCode,
      'flightNumber': flightNumber,
      'visitStatus': visitStatus,
      'isFlightReviewed': isFlightReviewed,
      'isDepartureAirportReviewed': isDepartureAirportReviewed,
      'isArrivalAirportReviewed': isArrivalAirportReviewed,
    };
  }
}
