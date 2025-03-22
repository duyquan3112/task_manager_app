class TaskModel {
  int? id;
  String? title;
  String? description;
  int? status;
  String? dueDate;
  String? createdDate;
  String? updatedDate;

  TaskModel({
    this.id,
    this.title,
    this.description,
    this.status,
    this.dueDate,
    this.createdDate,
    this.updatedDate,
  });

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    description = json["description"];
    status = json["status"];
    dueDate = json["due_date"];
    createdDate = json["created_date"];
    updatedDate = json["updated_date"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["title"] = title;
    _data["description"] = description;
    _data["status"] = status;
    _data["due_date"] = dueDate;
    _data["created_date"] = createdDate;
    _data["updated_date"] = updatedDate;
    return _data;
  }

  TaskModel copyWith({
    int? id,
    String? title,
    String? description,
    int? status,
    String? dueDate,
    String? createdDate,
    String? updatedDate,
  }) =>
      TaskModel(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        status: status ?? this.status,
        dueDate: dueDate ?? this.dueDate,
        createdDate: createdDate ?? this.createdDate,
        updatedDate: updatedDate ?? this.updatedDate,
      );
}
