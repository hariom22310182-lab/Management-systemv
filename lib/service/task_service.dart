import 'dart:convert';
import 'package:managementt/model/task.dart';
import 'package:managementt/service/api_service.dart';

class TaskService {
  final ApiService _api = ApiService();

  Future<void> addTask(Task task) async {
    await _api.post('/tasks/add', body: task.toJson());
  }

  Future<Task> getTaskById(String id) async {
    final response = await _api.get('/tasks/id/$id');
    if (response.statusCode == 200) {
      return Task.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get task');
    }
  }

  Future<List<Task>> getAllTask() async {
    final response = await _api.get('/tasks/AllTasks');
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => Task.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<List<Task>> getTaskByOwner(String id) async {
    final response = await _api.get('/tasks/member/$id');
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => Task.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch tasks for owner');
    }
  }

  Future<void> updateTask(String id, Task newTask) async {
    await _api.put('/tasks/update/$id', body: newTask.toJson());
  }

  Future<void> deleteTask(String id) async {
    await _api.delete('/tasks/delete/$id');
  }
}
