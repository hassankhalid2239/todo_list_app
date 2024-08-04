class TaskModel {
  int? id;
  String? title;
  String? description;
  String? isCompleted;
  String? date;
  String? dueDate;

  TaskModel(
      {this.id,
      this.title,
      this.description,
      this.isCompleted,
      this.date,
      this.dueDate});

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    isCompleted = json['isCompleted'];
    date = json['date'];
    dueDate = json['dueDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['isCompleted'] = isCompleted;
    data['date'] = date;
    data['dueDate'] = dueDate;
    return data;
  }
}
