import 'dart:async';
import 'package:movement_reminder/app/pages/home/home_presenter.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:movement_reminder/domain/entities/reminder.dart';
import 'package:movement_reminder/domain/repositories/reminder_repository.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeController extends Controller {
  HomeController(ReminderRepository reminderRepository)
    : _presenter = HomePresenter(reminderRepository) {
    getAllReminder();
    requestNotificationPermission();
  }

  final HomePresenter _presenter;

  bool isLoading = false;

  String orderedFor = "Fecha";
  String filterFor = "Todos";
  late String daysText;
  final List<String> days = [
    "Lun.",
    "Mar.",
    "Mie.",
    "Jue.",
    "Vie.",
    "Sab.",
    "Dom.",
  ];

  List<Reminder> reminders = [];

  void changeOrdered(String ordered) {
    orderedFor = ordered;
    refreshUI();
  }

  void changeFilter(String filter) {
    filterFor = filter;
    refreshUI();
  }

  void generateDays(List<bool> daysSelect) {
    daysText = List.generate(
      days.length,
      (i) => daysSelect[i] ? days[i] : null,
    ).whereType<String>().join(", ");
  }

  void onComplete(Reminder reminder) async {
    print("object");
    await updateReminder(
      Reminder(
        id: reminder.id,
        title: reminder.title,
        description: reminder.description,
        hour: reminder.hour,
        frequency: reminder.frequency,
        frequencyText: reminder.frequencyText,
        state: "Completado",
        daysSelect: reminder.daysSelect,
        idsNotification: reminder.idsNotification,
      ),
    );
  }

  void onOmitted(Reminder reminder) async {
    await updateReminder(
      Reminder(
        id: reminder.id,
        title: reminder.title,
        description: reminder.description,
        hour: reminder.hour,
        frequency: reminder.frequency,
        frequencyText: reminder.frequencyText,
        state: "Omitido",
        daysSelect: reminder.daysSelect,
        idsNotification: reminder.idsNotification,
      ),
    );
  }

  @override
  void onInitState() {
    super.onInitState();
  }

  @override
  void initListeners() {
    _presenter.updateReminderOnNext = () {};

    _presenter.updateReminderOnComplete = () {
      refreshUI();
    };

    _presenter.updateReminderOnError = (dynamic error) {
      refreshUI();
    };

    _presenter.deleteReminderOnNext = () {};

    _presenter.deleteReminderOnComplete = () {
      refreshUI();
    };

    _presenter.deleteReminderOnError = (dynamic error) {
      refreshUI();
    };

    _presenter.createdReminderOnNext = () {};

    _presenter.createdReminderOnComplete = () {
      refreshUI();
    };

    _presenter.createdReminderOnError = (dynamic error) {
      refreshUI();
    };

    _presenter.getAllReminderOnNext = (List<Reminder> remindersObtained) {
      reminders = remindersObtained;
      refreshUI();
    };

    _presenter.getAllReminderOnComplete = () {
      refreshUI();
    };

    _presenter.getAllReminderOnError = (dynamic error) {
      refreshUI();
    };
  }

  Future<void> updateReminder(Reminder reminder) async {
    await _presenter.updateReminder(reminder);
    refreshUI();
  }

  Future<void> deleteReminder(String id) async {
    await _presenter.deleteReminder(id);
    refreshUI();
  }

  Future<void> createdReminder(Reminder reminder) async {
    await _presenter.createdReminder(reminder);
    refreshUI();
  }

  Future<void> getAllReminder() async {
    await _presenter.getAllReminder();
    refreshUI();
  }

  Future<void> requestNotificationPermission() async {
    PermissionStatus status = await Permission.notification.request();

    if (status.isGranted) {
      print("Permiso concedido");
    } else if (status.isDenied) {
      print("Permiso denegado");
    } else if (status.isPermanentlyDenied) {
      print("Permiso denegado permanentemente, abre ajustes");
      openAppSettings();
    }
  }

  @override
  void onDisposed() {
    super.onDisposed();
  }
}
