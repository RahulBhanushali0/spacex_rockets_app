import '../../domain/entities/rocket.dart';
class RocketModel {
  Diameter? height;
  Diameter? diameter;
  Mass? mass;
  FirstStage? firstStage;
  SecondStage? secondStage;
  Engines? engines;
  LandingLegs? landingLegs;
  List<PayloadWeight>? payloadWeights;
  List<String>? flickrImages;
  String? name;
  String? type;
  bool? active;
  int? stages;
  int? boosters;
  double? costPerLaunch;
  double? successRatePct;
  DateTime? firstFlight;
  String? country;
  String? company;
  String? wikipedia;
  String? description;
  String? id;

  RocketModel({
    this.height,
    this.diameter,
    this.mass,
    this.firstStage,
    this.secondStage,
    this.engines,
    this.landingLegs,
    this.payloadWeights,
    this.flickrImages,
    this.name,
    this.type,
    this.active,
    this.stages,
    this.boosters,
    this.costPerLaunch,
    this.successRatePct,
    this.firstFlight,
    this.country,
    this.company,
    this.wikipedia,
    this.description,
    this.id,
  });

  factory RocketModel.fromJson(Map<String, dynamic> json) => RocketModel(
    height: json["height"] == null ? null : Diameter.fromJson(json["height"]),
    diameter: json["diameter"] == null ? null : Diameter.fromJson(json["diameter"]),
    mass: json["mass"] == null ? null : Mass.fromJson(json["mass"]),
    firstStage: json["first_stage"] == null ? null : FirstStage.fromJson(json["first_stage"]),
    secondStage: json["second_stage"] == null ? null : SecondStage.fromJson(json["second_stage"]),
    engines: json["engines"] == null ? null : Engines.fromJson(json["engines"]),
    landingLegs: json["landing_legs"] == null ? null : LandingLegs.fromJson(json["landing_legs"]),
    payloadWeights: json["payload_weights"] == null ? [] : List<PayloadWeight>.from(json["payload_weights"]!.map((x) => PayloadWeight.fromJson(x))),
    flickrImages: json["flickr_images"] == null ? [] : List<String>.from(json["flickr_images"]!.map((x) => x)),
    name: json["name"],
    type: json["type"],
    active: json["active"],
    stages: json["stages"],
    boosters: json["boosters"],
    costPerLaunch: json["cost_per_launch"]?.toDouble(),
    successRatePct: json["success_rate_pct"]?.toDouble(),
    firstFlight: json["first_flight"] != null ? DateTime.parse(json["first_flight"]) : null,
    country: json["country"],
    company: json["company"],
    wikipedia: json["wikipedia"],
    description: json["description"],
    id: json["id"],
  );

  Rocket toEntity() {
    return Rocket(
      height: height,
      diameter: diameter,
      mass: mass,
      firstStage: firstStage,
      secondStage: secondStage,
      engines: engines,
      landingLegs: landingLegs,
      payloadWeights: payloadWeights,
      flickrImages: flickrImages,
      name: name,
      type: type,
      active: active,
      stages: stages,
      boosters: boosters,
      costPerLaunch: costPerLaunch,
      successRatePct: successRatePct,
      firstFlight: firstFlight,
      country: country,
      company: company,
      wikipedia: wikipedia,
      description: description,
      id: id,
    );
  }
}