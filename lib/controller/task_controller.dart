import 'package:get/get.dart';
import 'package:managementt/model/task.dart';
import 'package:managementt/service/task_service.dart';

class TaskController extends GetxController {
  final TaskService _taskService = TaskService();

  var tasks = <Task>[].obs;
  var ownerTask = <Task>[].obs;
  String? ownerId;
  var isLoading = false.obs;

  @override
  void onInit() {
    getAllTask();
    super.onInit();
    if (ownerId != null) {
      getTaskByOwner(ownerId!);
    }
  }

  Future<void> addTask(Task task) async {
    isLoading.value = true;
    try {
      await _taskService.addTask(task);
      await getAllTask();
    } catch (e) {
      Get.snackbar('Error', 'Failed to add task: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getAllTask() async {
    isLoading.value = true;
    try {
      tasks.value = await _taskService.getAllTask();
    } catch (e) {
      print("Error fetching tasks: $e"); // you'll see the real error here
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateTask(String id, Task newTask) async {
    isLoading.value = true;
    try {
      await _taskService.updateTask(id, newTask);
      await getAllTask();
    } catch (e) {
      Get.snackbar('Error', 'Failed to update task: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getTaskByOwner(String id) async {
    isLoading.value = true;
    try {
      ownerTask.value = await _taskService.getTaskByOwner(id);
    } catch (e) {
      print('TaskController: Failed to fetch owner tasks — $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<Task> getTaskById(String id) async {
    isLoading.value = true;
    try {
      return await _taskService.getTaskById(id);
    } catch (e) {
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> removeTask(String id) async {
    try {
      await _taskService.deleteTask(id);
      await getAllTask();
    } catch (e) {
      Get.snackbar('Error', 'Failed to remove task: $e');
    }
  }
}
