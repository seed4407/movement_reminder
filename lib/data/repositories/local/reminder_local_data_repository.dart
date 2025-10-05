import 'dart:convert';

import 'package:logging/logging.dart';
import 'package:movement_reminder/data/models/reminder_model.dart';
import 'package:movement_reminder/domain/entities/reminder.dart';
import 'package:movement_reminder/domain/repositories/reminder_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReminderLocalDataRepository implements ReminderRepository {
  factory ReminderLocalDataRepository() => _instance;

  // Constructors
  ReminderLocalDataRepository._internal()
    : _logger = Logger('ReminderLocalDataRepository');
  static final ReminderLocalDataRepository _instance =
      ReminderLocalDataRepository._internal();
  Logger _logger;

  @override
  Future<void> createdReminder(Reminder reminder) async {
    final prefs = await SharedPreferences.getInstance();

    final String? remindersJson = prefs.getString('reminders');
    List<ReminderModel> reminders = [];

    if (remindersJson != null) {
      final List decoded = jsonDecode(remindersJson);
      reminders = decoded.map((e) => ReminderModel.fromJson(e)).toList();
    }

    final ReminderModel reminderModel = ReminderModel.fromEntity(reminder);

    reminders.add(reminderModel);

    final String encoded = jsonEncode(
      reminders.map((r) => r.toJson()).toList(),
    );
    await prefs.setString('reminders', encoded);
  }

  @override
  Future<List<Reminder>> getAllReminder() async {
    final prefs = await SharedPreferences.getInstance();
    final String? remindersJson = prefs.getString('reminders');

    if (remindersJson == null) {
      return [];
    }

    final List decoded = jsonDecode(remindersJson);
    final reminders = decoded.map((e) => ReminderModel.fromJson(e)).toList();

    return reminders.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> updateReminder(Reminder reminder) async {
    final prefs = await SharedPreferences.getInstance();

    final String? remindersJson = prefs.getString('reminders');
    List<ReminderModel> reminders = [];

    if (remindersJson != null) {
      final List decoded = jsonDecode(remindersJson);
      reminders = decoded.map((e) => ReminderModel.fromJson(e)).toList();
    }

    final ReminderModel updatedReminderModel = ReminderModel.fromEntity(
      reminder,
    );

    final int indexToUpdate = reminders.indexWhere(
      (r) => r.id == updatedReminderModel.id,
    );

    reminders[indexToUpdate] = updatedReminderModel;

    final String encoded = jsonEncode(
      reminders.map((r) => r.toJson()).toList(),
    );

    await prefs.setString('reminders', encoded);
  }

  @override
  Future<void> deleteReminder(String id) async {
    final prefs = await SharedPreferences.getInstance();

    final String? remindersJson = prefs.getString('reminders');
    List<ReminderModel> reminders = [];

    if (remindersJson != null) {
      final List decoded = jsonDecode(remindersJson);
      reminders = decoded.map((e) => ReminderModel.fromJson(e)).toList();
    }

    reminders.removeWhere((r) => r.id == id);

    final String encoded = jsonEncode(
      reminders.map((r) => r.toJson()).toList(),
    );

    await prefs.setString('reminders', encoded);
  }
}
