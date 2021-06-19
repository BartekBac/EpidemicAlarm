class RegionUnit {
  String id;
  String name;
  String parentId;
  int level;
  String kind;
  bool hasDescription;


  RegionUnit({this.id, this.name, this.parentId, this.level, this.kind,
      this.hasDescription});

  factory RegionUnit.fromJson(Map<String, dynamic> json) {
    return RegionUnit(
        id: json['id'] as String,
        name: json['name'] as String,
        parentId: json['parentId'] as String,
        hasDescription: json['hasDescription'] as bool,
        kind: json['kind'] as String,
        level: json['level'] as int
    );
  }
}