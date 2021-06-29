
class DiagnosedCase {
  int id;
  DateTime diagnosisDate;
  int duration;
  DateTime expirationDate;
  int status;
  double locationLat;
  double locationLng;
  int identity;
  int institution;
  int introducer;
  String region;
  String subregion;
  String city;

  DiagnosedCase({
      this.id,
      this.diagnosisDate,
      this.duration,
      this.expirationDate,
      this.status,
      this.locationLat,
      this.locationLng,
      this.identity,
      this.institution,
      this.introducer,
      this.region,
      this.subregion,
      this.city
  });

  factory DiagnosedCase.fromJson(Map<String, dynamic> json) {
    return DiagnosedCase(
        id: json['id'] as int,
        diagnosisDate: DateTime.parse(json['diagnosisDate'] as String),
        duration: json['duration'] as int,
        expirationDate: DateTime.parse(json['expirationDate'] as String),
        identity: json['identity'] as int,
        institution: json['institution'] as int,
        introducer: json['introducer'] as int,
        locationLat: json['locationLat'] as double,
        locationLng: json['locationLng'] as double,
        status: json['status'] as int,
        region: json['region'] as String,
        subregion: json['subregion'] as String,
        city: json['city'] as String
    );
  }
}