import 'dart:convert';

import 'package:movement_reminder/app/pages/splash/splash_controller.dart';
import 'package:movement_reminder/data/models/reminder_model.dart';
import 'package:movement_reminder/data/repositories/local/reminder_local_data_repository.dart';
import 'package:movement_reminder/data/repositories/remote/reminder_remote_data_repository.dart';
import 'package:movement_reminder/domain/entities/reminder.dart';
import 'package:movement_reminder/domain/repositories/reminder_repository.dart';
import 'package:logging/logging.dart';
import 'package:movement_reminder/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const _uuid = Uuid();

class ReminderMasterDataRepository
    implements ReminderRepository, ReminderRemoteSync {
  factory ReminderMasterDataRepository() => _instance;

  // Constructors
  ReminderMasterDataRepository._internal()
    : _logger = Logger('ReminderRemoteDataRepository');
  static final ReminderMasterDataRepository _instance =
      ReminderMasterDataRepository._internal();
  Logger _logger;

  final ReminderRemoteDataRepository remote = ReminderRemoteDataRepository();
  final ReminderLocalDataRepository local = ReminderLocalDataRepository();

  @override
  Future<void> createdReminder(Reminder reminder) async {
    final String newId = _uuid.v4();

    List<int> days = reminder.daysSelect
        .asMap()
        .entries
        .where((entry) => entry.value)
        .map((entry) => entry.key + 1)
        .toList();

    final Reminder reminderWithId;
    List<int> idsNotification = [];
    if (reminder.frequencyText == "Semanal") {
      for (var day in days) {
        idsNotification.add(newId.hashCode.abs() + day);
      }

      NotificationService().showNotificationsForMultipleDays(
        id: newId,
        title: reminder.title,
        body: reminder.description,
        days: days,
        hour: reminder.hour.hour,
        minute: reminder.hour.minute,
        idsNotification: idsNotification,
      );
      reminderWithId = reminder.copyWith(
        id: newId,
        idsNotification: idsNotification,
      );
    } else if (reminder.frequencyText == "Único") {
      for (var day in days) {
        idsNotification.add(newId.hashCode.abs() + day);
      }

      NotificationService().showNotificationsForMultipleDaysUnique(
        id: newId,
        title: reminder.title,
        body: reminder.description,
        days: days,
        hour: reminder.hour.hour,
        minute: reminder.hour.minute,
        idsNotification: idsNotification,
      );
      reminderWithId = reminder.copyWith(
        id: newId,
        idsNotification: idsNotification,
      );
    } else {
      idsNotification.add(newId.hashCode.abs());
      NotificationService().showNotificationsDaily(
        idReminder: newId,
        id: newId.hashCode.abs(),
        title: reminder.title,
        body: reminder.description,
        hour: reminder.hour.hour,
        minute: reminder.hour.minute,
      );

      reminderWithId = reminder.copyWith(id: newId);
    }

    await local.createdReminder(reminderWithId);
    await remote.createdReminder(reminderWithId);
  }

  @override
  Future<List<Reminder>> getAllReminder() async {
    return await local.getAllReminder();
  }

  @override
  Future<void> getAllReminderSynchronize() async {
    List<Reminder> synReminders = await remote.getAllReminder();

    final prefs = await SharedPreferences.getInstance();

    final List<ReminderModel> synReminderModels = synReminders
        .map((reminder) => ReminderModel.fromEntity(reminder))
        .toList();

    final String encoded = jsonEncode(
      synReminderModels.map((r) => r.toJson()).toList(),
    );

    await prefs.setString('reminders', encoded);
  }

  @override
  Future<void> updateReminder(Reminder reminder) async {
    for (int id in reminder.idsNotification!) {
      NotificationService().cancelNotificationById(id);
    }

    List<int> days = reminder.daysSelect
        .asMap()
        .entries
        .where((entry) => entry.value)
        .map((entry) => entry.key + 1)
        .toList();

    List<int> idsNotification = [];
    if (reminder.frequencyText == "Semanal") {
      for (var day in days) {
        idsNotification.add(reminder.id.hashCode.abs() + day);
      }

      NotificationService().showNotificationsForMultipleDays(
        id: reminder.id!,
        title: reminder.title,
        body: reminder.description,
        days: days,
        hour: reminder.hour.hour,
        minute: reminder.hour.minute,
        idsNotification: idsNotification,
      );
    } else if (reminder.frequencyText == "Único") {
      for (var day in days) {
        idsNotification.add(reminder.id.hashCode.abs() + day);
      }

      NotificationService().showNotificationsForMultipleDaysUnique(
        id: reminder.id!,
        title: reminder.title,
        body: reminder.description,
        days: days,
        hour: reminder.hour.hour,
        minute: reminder.hour.minute,
        idsNotification: idsNotification,
      );
    } else {
      idsNotification.add(reminder.id.hashCode.abs());
      NotificationService().showNotificationsDaily(
        idReminder: reminder.id!,
        id: reminder.id.hashCode.abs(),
        title: reminder.title,
        body: reminder.description,
        hour: reminder.hour.hour,
        minute: reminder.hour.minute,
      );
    }

    await local.updateReminder(reminder);
    await remote.updateReminder(reminder);
  }

  @override
  Future<void> deleteReminder(String id) async {
    await local.deleteReminder(id);
    await remote.deleteReminder(id);
  }
}
