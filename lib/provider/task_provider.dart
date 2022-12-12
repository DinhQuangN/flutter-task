import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:task_app/model/task_model.dart';

class TaskProvider {
  var baseUrl = 'http://10.0.2.2:8000/api/';
  Future<List<Task>> getTask(var url) async {
    try {
      var response = await http.get(Uri.parse(baseUrl + url));
      return taskFromJson(response.body);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<dynamic> postTask(var url, Map data) async {
    try {
      var response = await http.post(Uri.parse(baseUrl + url),
          body: jsonEncode(data), headers: _setHeaders());
      return response.body;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<dynamic> deleteTask(var url, String id) async {
    try {
      var response =
          await http.get(Uri.parse(baseUrl + url + id), headers: _setHeaders());
      return response.body;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  _setHeaders() =>
      {'Content-type': 'application/json', 'Accept': 'application/json'};
}
