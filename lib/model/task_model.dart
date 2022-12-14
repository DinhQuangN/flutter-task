// To parse this JSON data, do
//
//     final task = taskFromJson(jsonString);

import 'dart:convert';

List<Task> taskFromJson(String str) =>
    List<Task>.from(json.decode(str).map((x) => Task.fromJson(x)));

String taskToJson(List<Task> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Task {
  Task({
    required this.id,
    required this.titleTask,
    required this.iconTask,
    required this.colorTask,
    required this.createdAt,
    required this.updatedAt,
    this.listItem,
  });

  int id;
  String titleTask;
  String iconTask;
  String colorTask;
  DateTime createdAt;
  DateTime updatedAt;
  List<ListItem>? listItem;

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["id"],
        titleTask: json["title_task"],
        iconTask: json["icon_task"],
        colorTask: json["color_task"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        listItem: List<ListItem>.from(
            json["list_item"].map((x) => ListItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title_task": titleTask,
        "icon_task": iconTask,
        "color_task": colorTask,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "list_item": List<dynamic>.from(listItem!.map((x) => x.toJson())),
      };
}

List<ListItem> taskItemFromJson(String str) =>
    List<ListItem>.from(json.decode(str).map((x) => ListItem.fromJson(x)));

class ListItem {
  ListItem({
    required this.id,
    required this.titleItem,
    required this.doneItem,
    required this.listTaskId,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String titleItem;
  int doneItem;
  int listTaskId;
  DateTime createdAt;
  DateTime updatedAt;

  factory ListItem.fromJson(Map<String, dynamic> json) => ListItem(
        id: json["id"],
        titleItem: json["title_item"],
        doneItem: json["done_item"],
        listTaskId: json["list_task_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title_item": titleItem,
        "done_item": doneItem,
        "list_task_id": listTaskId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
