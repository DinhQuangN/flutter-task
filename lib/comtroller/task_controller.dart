import 'dart:convert';

import 'package:flutter/cupertino.dart';
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
  final doingTodos = <ListItem>[].obs;
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
      if (status != 0) {
        doneTodos.add(todo);
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

  Future<void> createItemTask(Map<String, dynamic> data) async {
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

  Future<void> addItemTodo(String title, int id) async {
    Map<String, dynamic> data = {
      'title_item': title,
      'list_task_id': id,
      'done_item': 0
    };
    print(ListItem.fromJson(data));
    // var response = await TaskProvider().postTask('createItem', data);
    // var res = jsonDecode(response);
    // changeTask(res['data']['list_item']);
    // if (res['message'] != 'success') {
    //   clearTextEditingController();
    //   showSnackBar('Error ', 'Todo item already exist ', Colors.red);
    // } else {
    //   showSnackBar('Success', 'Todo item add success', Colors.green);
    // }

    // editingController.clear();
  }

  Future<void> doneTodo() async {}
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
