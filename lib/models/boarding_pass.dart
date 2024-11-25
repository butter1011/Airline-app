class BoardingPass {
  final String departureAirportCode;
  final String departureTime;
  final String arrivalAirportCode;

  final String arrivalTime;
  final String classOfTravel;
  final String airlineCode;
  final String flightNumber;
  final String visitStatus;

  const BoardingPass({
    this.departureAirportCode = '',
    this.departureTime = '',
    this.arrivalAirportCode = '',
    this.arrivalTime = '',
    this.classOfTravel = '',
    this.airlineCode = '',
    this.flightNumber = '',
    this.visitStatus = '',
  });

  BoardingPass copyWith({
    String? departureAirportCode,
    String? departureTime,
    String? arrivalAirportCode,
    String? arrivalTime,
    String? classOfTravel,
    String? airlineCode,
    String? flightNumber,
    String? visitStatus,
  }) {
    return BoardingPass(
      departureAirportCode: departureAirportCode ?? this.departureAirportCode,
      departureTime: departureTime ?? this.departureTime,
      arrivalAirportCode: arrivalAirportCode ?? this.arrivalAirportCode,
      arrivalTime: arrivalTime ?? this.arrivalTime,
      classOfTravel: classOfTravel ?? this.classOfTravel,
      airlineCode: airlineCode ?? this.airlineCode,
      flightNumber: flightNumber ?? this.flightNumber,
      visitStatus: visitStatus ?? this.visitStatus,
    );
  }
}
