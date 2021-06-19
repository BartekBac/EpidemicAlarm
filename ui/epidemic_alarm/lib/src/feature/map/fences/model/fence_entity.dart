import 'package:latlong/latlong.dart';

class Fence {
  String id;
  String name;
  String parentId;
  int diagnosedCasesCount;

  Fence({this.id, this.name, this.parentId, this.diagnosedCasesCount});

  factory Fence.fromJson(Map<String, dynamic> json) {
    return Fence(
        id: json['id'] as String,
        name: json['name'] as String,
        parentId: json['parentId'] as String,
        diagnosedCasesCount: 0
    );
  }
}