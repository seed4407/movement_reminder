import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:movement_reminder/data/models/reminder_model.dart';
import 'package:movement_reminder/domain/entities/reminder.dart';
import 'package:movement_reminder/domain/repositories/reminder_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReminderRemoteDataRepository implements ReminderRepository {
  factory ReminderRemoteDataRepository() => _instance;

  final _firestore = FirebaseFirestore.instance;

  // Constructors
  ReminderRemoteDataRepository._internal()
    : _logger = Logger('ReminderRemoteDataRepository');
  static final ReminderRemoteDataRepository _instance =
      ReminderRemoteDataRepository._internal();
  Logger _logger;

  @override
  Future<void> createdReminder(Reminder reminder) async {
    final ReminderModel reminderModel = ReminderModel.fromEntity(reminder);

    await _firestore
        .collection('reminders')
        .doc(reminder.id)
        .set(reminderModel.toJson());
  }

  @override
  Future<List<Reminder>> getAllReminder() async {
    final snapshot = await _firestore.collection('reminders').get();

    final List<ReminderModel> reminderModels = snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;

      return ReminderModel.fromJson(data);
    }).toList();

    return reminderModels.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> updateReminder(Reminder reminder) async {
    final ReminderModel reminderModel = ReminderModel.fromEntity(reminder);
    final Map<String, dynamic> dataToUpdate = reminderModel.toJson();

    await _firestore
        .collection('reminders')
        .doc(reminder.id)
        .update(dataToUpdate);
  }

  @override
  Future<void> deleteReminder(String id) async {
    await _firestore.collection('reminders').doc(id).delete();
  }
}
