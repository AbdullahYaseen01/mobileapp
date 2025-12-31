import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String id;
  final String userId;
  final String subject;
  final String title;
  final String notes;
  final DateTime dateTime;
  final bool isCompleted;
  final DateTime createdAt;

  Task({
    required this.id,
    required this.userId,
    required this.subject,
    required this.title,
    required this.notes,
    required this.dateTime,
    this.isCompleted = false,
    required this.createdAt,
  });

  // Convert Task to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'subject': subject,
      'title': title,
      'notes': notes,
      'dateTime': Timestamp.fromDate(dateTime),
      'isCompleted': isCompleted,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  // Create Task from Firestore Map
  factory Task.fromMap(Map<String, dynamic> map, String id) {
    return Task(
      id: id,
      userId: map['userId'] as String,
      subject: map['subject'] as String,
      title: map['title'] as String,
      notes: map['notes'] as String? ?? '',
      dateTime: (map['dateTime'] as Timestamp).toDate(),
      isCompleted: map['isCompleted'] as bool? ?? false,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  // Create a copy with updated fields
  Task copyWith({
    String? id,
    String? userId,
    String? subject,
    String? title,
    String? notes,
    DateTime? dateTime,
    bool? isCompleted,
    DateTime? createdAt,
  }) {
    return Task(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      subject: subject ?? this.subject,
      title: title ?? this.title,
      notes: notes ?? this.notes,
      dateTime: dateTime ?? this.dateTime,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}


