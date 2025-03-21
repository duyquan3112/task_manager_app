class TaskModel {
  int? id;
  String? title;
  String? description;
  int? status;
  String? dueDate;
  String? createdAt;
  String? updatedAt;

  TaskModel({
    this.id,
    this.title,
    this.description,
    this.status,
    this.dueDate,
    this.createdAt,
    this.updatedAt,
  });

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    description = json["description"];
    status = json["status"];
    dueDate = json["due_date"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["title"] = title;
    _data["description"] = description;
    _data["status"] = status;
    _data["due_date"] = dueDate;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    return _data;
  }

  TaskModel copyWith({
    int? id,
    String? title,
    String? description,
    int? status,
    String? dueDate,
    String? createdAt,
    String? updatedAt,
  }) =>
      TaskModel(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        status: status ?? this.status,
        dueDate: dueDate ?? this.dueDate,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
}
