import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/model/task_model.dart';
import 'package:task_app/provider/task_provider.dart';

class TaskController extends GetxController {
  ScrollController scrollController = ScrollController();
  List<Task> listTask = [];
  List<Task> get listTasks => listTask;
  final chipIndex = 0.obs;
  final isLoading = false.obs;
  final deleting = false.obs;
  final task = Rx<Task?>(null);
  final doingTodos = <dynamic>[].obs;
  final doneTodos = <ListItem>[].obs;
  late TextEditingController editingController;

  @override
  void onInit() async {
    super.onInit();
    getListTask();
    editingController = TextEditingController();
  }

  void changeChipIndex(int value) {
    chipIndex.value = value;
  }

  void changeDeleting(bool value) {
    deleting.value = value;
  }

  void changeTask(Task? select) {
    task.value = select;
  }

  void changeTodos(List<ListItem> select) {
    doingTodos.clear();
    doneTodos.clear();
    for (int i = 0; i < select.length; i++) {
      var todo = select[i];
      var status = todo.doneItem;
      print('status ${status}');
      if (status == 0) {
        doneTodos.add(todo);
        print(doneTodos);
      } else {
        doingTodos.add(todo);
      }
    }
  }

  showSnackBar(String title, String message, Color backgroundColor) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: backgroundColor,
        colorText: Colors.white);
  }

  Future<void> getListTask() async {
    try {
      isLoading(true);
      var response = await TaskProvider().getTask('getList');
      if (response is List<Task>) {
        listTask = [];
        listTask.addAll(response);
        isLoading(false);
      }
    } catch (e) {
      isLoading(false);
      showSnackBar("Exception", e.toString(), Colors.red);
    }
  }

  Future<void> createListTask(Map data) async {
    try {
      var response = await TaskProvider().postTask('createList', data);
      var res = jsonDecode(response);
      if (res['message'] == 'success') {
        clearTextEditingController();
        showSnackBar('Add Task', 'Task Added', Colors.green);
        getListTask();
      }
    } catch (e) {
      isLoading(false);
      showSnackBar("Exception", e.toString(), Colors.red);
    }
  }

  Future<void> createItemTask(Map data) async {
    try {
      var response = await TaskProvider().postTask('createItem', data);
      var res = jsonDecode(response);
      if (res['message'] == 'success') {
        clearTextEditingController();
        showSnackBar('Add Task', 'Task Added', Colors.green);
        changeTask(null);
        getListTask();
      }
    } catch (e) {
      isLoading(false);
      showSnackBar("Exception", e.toString(), Colors.red);
    }
  }

  Future<void> deleteListTask(Task task, String id) async {
    try {
      listTask.remove(task);
      isLoading(true);
      var response = await TaskProvider().deleteTask('deleteList/', id);
      if (response != null) {
        isLoading(false);
      }
    } catch (e) {
      isLoading(false);
      showSnackBar("Exception", e.toString(), Colors.red);
    }
  }

  bool addItemTodo(String title, int id) {
    var todo = {'titleItem': title, 'listTaskId': id, 'doneItem': false};
    if (doingTodos
        .any((element) => mapEquals<String, dynamic>(todo, element))) {
      return false;
    }
    var doneTodo = {'titleItem': title, 'listTaskId': id, 'doneItem': true};
    if (doneTodos
        .any((element) => mapEquals<String, dynamic>(doneTodo, element))) {
      return false;
    }
    doingTodos.add(todo);
    print(doingTodos);
    editingController.clear();

    return true;
  }

  void clearTextEditingController() {
    editingController.clear();
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
    editingController.dispose();
  }
}
