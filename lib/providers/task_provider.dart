import 'package:flutter/foundation.dart';
import 'package:study_planner/models/task_model.dart';
import 'package:study_planner/services/firestore_service.dart';
import 'package:study_planner/services/notification_service.dart';
import 'package:study_planner/utils/constants.dart';

class TaskProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  List<Task> _tasks = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Task> get tasks => _tasks;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Get today's tasks
  List<Task> get todayTasks {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final todayEnd = DateTime(now.year, now.month, now.day, 23, 59, 59);
    
    return _tasks.where((task) {
      return task.dateTime.isAfter(todayStart.subtract(const Duration(days: 1))) &&
             task.dateTime.isBefore(todayEnd.add(const Duration(days: 1)));
    }).toList();
  }

  // Get completed tasks count
  int get completedTasksCount => _tasks.where((task) => task.isCompleted).length;

  // Get pending tasks count
  int get pendingTasksCount => _tasks.where((task) => !task.isCompleted).length;

  // Get total tasks count
  int get totalTasksCount => _tasks.length;

  // Initialize tasks stream
  void initializeTasks() {
    _firestoreService.getTasks().listen(
      (tasks) {
        _tasks = tasks;
        _isLoading = false;
        _errorMessage = null;
        notifyListeners();
      },
      onError: (error) {
        _errorMessage = error.toString();
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  // Create task
  Future<bool> createTask(Task task) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      await _firestoreService.createTask(task);
      
      // Schedule notification for the task
      final notificationService = NotificationService();
      final taskIdHash = task.id.hashCode;
      await notificationService.scheduleTaskNotification(
        id: taskIdHash,
        title: '${task.subject}: ${task.title}',
        body: task.notes.isNotEmpty 
            ? task.notes 
            : 'Your study task is starting soon!',
        scheduledDate: task.dateTime,
        minutesBefore: AppConstants.notificationReminderMinutes,
      );
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Update task
  Future<bool> updateTask(String taskId, Task task) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      await _firestoreService.updateTask(taskId, task);
      
      // Cancel old notification and schedule new one
      final notificationService = NotificationService();
      final taskIdHash = taskId.hashCode;
      await notificationService.cancelNotification(taskIdHash);
      
      await notificationService.scheduleTaskNotification(
        id: taskIdHash,
        title: '${task.subject}: ${task.title}',
        body: task.notes.isNotEmpty 
            ? task.notes 
            : 'Your study task is starting soon!',
        scheduledDate: task.dateTime,
        minutesBefore: AppConstants.notificationReminderMinutes,
      );
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Delete task
  Future<bool> deleteTask(String taskId) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      await _firestoreService.deleteTask(taskId);
      
      // Cancel notification for deleted task
      final notificationService = NotificationService();
      final taskIdHash = taskId.hashCode;
      await notificationService.cancelNotification(taskIdHash);
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Toggle task completion
  Future<bool> toggleTaskCompletion(String taskId, bool isCompleted) async {
    try {
      await _firestoreService.toggleTaskCompletion(taskId, isCompleted);
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}

