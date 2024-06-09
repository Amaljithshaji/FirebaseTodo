import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Task {
  final String? id;
  final String title;
  final String description;
  final DateTime deadlineDate;
  final TimeOfDay deadlineTime;
  final Duration expectedDuration;
  final bool isComplete;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.deadlineDate,
    required this.deadlineTime,
    required this.expectedDuration,
    this.isComplete = false,
  });

  factory Task.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>?;

    if (data == null) {
      throw Exception("Data is null");
    }

    Timestamp? timestamp = data['deadlineDate'] as Timestamp?;
    DateTime deadlineDate = timestamp?.toDate() ?? DateTime.now();

    String deadlineTimeString = data['deadlineTime'] ?? '00:00';
    List<String> timeParts = deadlineTimeString.split(':');
    TimeOfDay deadlineTime = TimeOfDay(
      hour: int.parse(timeParts[0]),
      minute: int.parse(timeParts[1]),
    );

    return Task(
      id: snapshot.id,
      title: data['title'] ?? 'No Title',
      description: data['description'] ?? 'No Description',
      deadlineDate: deadlineDate,
      deadlineTime: deadlineTime,
      expectedDuration: Duration(hours: data['expectedDuration'] ?? 0),
      isComplete: data['isComplete'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'deadlineDate': Timestamp.fromDate(deadlineDate),
      'deadlineTime': '${deadlineTime.hour}:${deadlineTime.minute.toString().padLeft(2, '0')}',
      'expectedDuration': expectedDuration.inHours,
      'isComplete': isComplete,
    };
  }

  Task copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? deadlineDate,
    TimeOfDay? deadlineTime,
    Duration? expectedDuration,
    bool? isComplete,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      deadlineDate: deadlineDate ?? this.deadlineDate,
      deadlineTime: deadlineTime ?? this.deadlineTime,
      expectedDuration: expectedDuration ?? this.expectedDuration,
      isComplete: isComplete ?? this.isComplete,
    );
  }
}
