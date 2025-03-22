class FilterPayload {
  int? status;
  String? title;

  FilterPayload({this.status, this.title});

  FilterPayload.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    title = json["title"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["title"] = title;
    return _data;
  }

  FilterPayload copyWith({
    int? status,
    String? title,
  }) =>
      FilterPayload(
        status: status ?? this.status,
        title: title ?? this.title,
      );
}
