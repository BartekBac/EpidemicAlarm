
class RegionUnit {
  String id;
  String name;
  String parentId;
  int diagnosedCasesCount;

  RegionUnit({this.id, this.name, this.parentId, this.diagnosedCasesCount});


  factory RegionUnit.fromJson(Map<String, dynamic> json) {
    return RegionUnit(
        id: json['id'] as String,
        name: json['name'] as String,
        parentId: json['parentId'] as String,
        diagnosedCasesCount: 0
    );
  }
}