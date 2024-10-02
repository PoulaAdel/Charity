part of app_models;

const String checkTable = "check";

class CheckFields {
  static const String pk = "pk";
  static const String supply = "supply";
  static const String sponsor = "sponsor";
  static const String receiver = "receiver";
  static const String createdAt = "created_at";
  static const String updatedAt = "updated_at";
  static const List<String> values = [
    pk,
    supply,
    sponsor,
    receiver,
    createdAt,
    updatedAt,
  ];
}

class Check {
  int pk;
  final int supply;
  final int sponsor;
  final int receiver; //person table
  final DateTime createdAt;
  final DateTime? updatedAt;

  Check({
    this.pk = 0,
    required this.supply,
    required this.sponsor,
    required this.receiver,
    required this.createdAt,
    this.updatedAt,
  });

  factory Check.fromJson(Map<String, dynamic> json) => Check(
        pk: json["pk"] as int,
        supply: json["supply"] as int,
        sponsor: json["sponsor"] as int,
        receiver: json["receiver"] as int,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: (json["updated_at"] != null)
            ? DateTime.parse(json["updated_at"])
            : null,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "pk": pk,
        "supply": supply,
        "sponsor": sponsor,
        "receiver": receiver,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
