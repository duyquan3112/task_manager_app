class FilterModel {
  int? id;
  String? value;

  FilterModel({this.id, this.value});

  FilterModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    value = json["value"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["value"] = value;
    return _data;
  }

  FilterModel copyWith({
    int? id,
    String? value,
  }) =>
      FilterModel(
        id: id ?? this.id,
        value: value ?? this.value,
      );
}
