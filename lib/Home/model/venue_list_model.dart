
class VenueListModel {
  int? id;
  String? name;
  String? address;
  double? kilometres;
  String? logo;
  double? rating;
  List<String>? sports;
  int? favourite;
  Price? price;

  VenueListModel({
    this.id,
    this.name,
    this.address,
    this.kilometres,
    this.logo,
    this.rating,
    this.sports,
    this.favourite,
    this.price,
  });

  factory VenueListModel.fromJson(Map<String, dynamic> json) => VenueListModel(
    id: json["id"],
    name: json["name"],
    address: json["address"],
    kilometres: json["kilometres"] != null ? json["kilometres"].toDouble() : null,
    logo: json["logo"],
    rating: json["rating"] != null ?  json["rating"].toDouble() : null,
    sports: List<String>.from(json["sports"].map((x) => x)),
    favourite: json["favourite"],
    price: Price.fromJson(json["price"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "address": address,
    "kilometres": kilometres,
    "logo": logo,
    "rating": rating,
    "sports": List<dynamic>.from(sports!.map((x) => x)),
    "favourite": favourite,
    "price": price!.toJson(),
  };
}

class Price {
  int? football;
  int? cricket;
  int? volleyball;
  int? badminton;
  int? tableTennis;
  int? tennis;
  int? basketball;
  int? hockey;
  int? squash;
  int? boxing;
  int? ultimateFrisbee;
  int? swimming;
  int? beachVolleyball;
  int? golf;
  int? archery;
  int? adventureSports;
  int? rockClimbing;

  Price({
    this.football,
    this.cricket,
    this.volleyball,
    this.badminton,
    this.tableTennis,
    this.tennis,
    this.basketball,
    this.hockey,
    this.squash,
    this.boxing,
    this.ultimateFrisbee,
    this.swimming,
    this.beachVolleyball,
    this.golf,
    this.archery,
    this.adventureSports,
    this.rockClimbing,
  });

  factory Price.fromJson(Map<String, dynamic> json) => Price(
    football: json["Football"],
    cricket: json["Cricket"],
    volleyball: json["Volleyball"],
    badminton: json["Badminton"],
    tableTennis: json["Table Tennis"],
    tennis: json["Tennis"],
    basketball: json["Basketball"],
    hockey: json["Hockey"],
    squash: json["Squash"],
    boxing: json["Boxing"],
    ultimateFrisbee: json["Ultimate Frisbee"],
    swimming: json["Swimming"],
    beachVolleyball: json["Beach Volleyball"],
    golf: json["Golf"],
    archery: json["Archery"],
    adventureSports: json["Adventure Sports"],
    rockClimbing: json["Rock Climbing"],
  );

  Map<String, dynamic> toJson() => {
    "Football": football,
    "Cricket": cricket,
    "Volleyball": volleyball,
    "Badminton": badminton,
    "Table Tennis": tableTennis,
    "Tennis": tennis,
    "Basketball": basketball,
    "Hockey": hockey,
    "Squash": squash,
    "Boxing": boxing,
    "Ultimate Frisbee": ultimateFrisbee,
    "Swimming": swimming,
    "Beach Volleyball": beachVolleyball,
    "Golf": golf,
    "Archery": archery,
    "Adventure Sports": adventureSports,
    "Rock Climbing": rockClimbing,
  };
}
