import 'dart:async';
import 'package:movement_reminder/domain/entities/reminder.dart';

abstract class ReminderRepository {
  Future<void> createdReminder(Reminder reminder);
  Future<List<Reminder>> getAllReminder();
  Future<void> updateReminder(Reminder reminder);
  Future<void> deleteReminder(String id);
}

abstract class ReminderRemoteSync {
  Future<void> getAllReminderSynchronize();
}
