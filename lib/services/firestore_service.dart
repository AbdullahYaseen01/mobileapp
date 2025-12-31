import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:study_planner/models/task_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get current user ID
  String? get userId => _auth.currentUser?.uid;

  // Collection reference
  CollectionReference get _tasksCollection =>
      _firestore.collection('tasks');

  // Create a new task
  Future<String> createTask(Task task) async {
    try {
      if (userId == null) throw Exception('User not authenticated');
      
      DocumentReference docRef = await _tasksCollection.add(task.toMap());
      return docRef.id;
    } catch (e) {
      throw Exception('Failed to create task: $e');
    }
  }

  // Get all tasks for current user
  Stream<List<Task>> getTasks() {
    if (userId == null) {
      return Stream.value([]);
    }

    return _tasksCollection
        .where('userId', isEqualTo: userId)
        .orderBy('dateTime', descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Task.fromMap(doc.data() as Map<String, dynamic>, doc.id))
            .toList());
  }

  // Get tasks by date range
  Stream<List<Task>> getTasksByDateRange(DateTime start, DateTime end) {
    if (userId == null) {
      return Stream.value([]);
    }

    return _tasksCollection
        .where('userId', isEqualTo: userId)
        .where('dateTime', isGreaterThanOrEqualTo: start)
        .where('dateTime', isLessThanOrEqualTo: end)
        .orderBy('dateTime', descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Task.fromMap(doc.data() as Map<String, dynamic>, doc.id))
            .toList());
  }

  // Update task
  Future<void> updateTask(String taskId, Task task) async {
    try {
      if (userId == null) throw Exception('User not authenticated');
      
      await _tasksCollection.doc(taskId).update(task.toMap());
    } catch (e) {
      throw Exception('Failed to update task: $e');
    }
  }

  // Delete task
  Future<void> deleteTask(String taskId) async {
    try {
      if (userId == null) throw Exception('User not authenticated');
      
      await _tasksCollection.doc(taskId).delete();
    } catch (e) {
      throw Exception('Failed to delete task: $e');
    }
  }

  // Toggle task completion
  Future<void> toggleTaskCompletion(String taskId, bool isCompleted) async {
    try {
      if (userId == null) throw Exception('User not authenticated');
      
      await _tasksCollection.doc(taskId).update({'isCompleted': isCompleted});
    } catch (e) {
      throw Exception('Failed to update task: $e');
    }
  }
}


