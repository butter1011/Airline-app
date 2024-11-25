class BoardingPass {

  final String departureAirport;
  final String departureCountryCode;
  final String departureTime;

  final String arrivalAirport;
  final String arrivalCountryCode;
  final String arrivalTime;
  final String classOfTravel;
  final String airline;
  final String flightNumber;
  final String visitStatus;

  const BoardingPass({

    this.departureAirport = '',
    this.departureCountryCode = '',
    this.departureTime = '',

    this.arrivalAirport = '',
    this.arrivalCountryCode = '',
    this.arrivalTime = '',
    this.classOfTravel = '',
    this.airline = '',
    this.flightNumber = '',
    this.visitStatus = '',
  });

  BoardingPass copyWith({

    String? departureAirport,
    String? departureCountryCode,
    String? departureTime,

    String? arrivalAirport,
    String? arrivalCountryCode,
    String? arrivalTime,
    String? classOfTravel,
    String? airline,
    String? flightNumber,
    String? visitStatus,
  }) {
    return BoardingPass(
   
      departureAirport: departureAirport ?? this.departureAirport,
      departureCountryCode: departureCountryCode ?? this.departureCountryCode,
      departureTime: departureTime ?? this.departureTime,
 
      arrivalAirport: arrivalAirport ?? this.arrivalAirport,
      arrivalCountryCode: arrivalCountryCode ?? this.arrivalCountryCode,
      arrivalTime: arrivalTime ?? this.arrivalTime,
      classOfTravel: classOfTravel ?? this.classOfTravel,
      airline: airline ?? this.airline,
      flightNumber: flightNumber ?? this.flightNumber,
      visitStatus: visitStatus ?? this.visitStatus,
    );
  }
}
