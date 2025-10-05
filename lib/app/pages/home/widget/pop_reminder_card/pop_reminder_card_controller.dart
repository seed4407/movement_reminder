import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:movement_reminder/app/pages/home/widget/pop_reminder_card/pop_reminder_card_presenter.dart';
import 'package:movement_reminder/domain/entities/reminder.dart';
import 'package:movement_reminder/domain/repositories/reminder_repository.dart';

class PopReminderCardController extends Controller {
  Reminder? selectReminder;

  PopReminderCardController(
    this.selectReminder,
    ReminderRepository reminderRepository,
  ) : _presenter = PopReminderCardPresenter(reminderRepository) {
    initReminder(selectReminder);
  }

  final PopReminderCardPresenter _presenter;

  bool isLoading = false;

  late String id;
  late String title;
  late String description;
  late TimeOfDay hour;
  late String frequency;
  late String frequencyText;
  late String state;
  late List<bool> daysSelect;
  late List<int> idsNotification;
  late bool edit;

  void selectFrequency(String ordered) {
    frequency = ordered;
    refreshUI();
  }

  void selectDays(int day) {
    daysSelect[day] = !daysSelect[day];
    refreshUI();
  }

  void initReminder(Reminder? reminder) {
    if (reminder == null) {
      title = "";
      description = "";
      hour = TimeOfDay.now();
      frequency = "";
      frequencyText = "";
      state = "Pendiente";
      daysSelect = [false, false, false, false, false, false, false];
      idsNotification = [];
      edit = false;
    } else {
      id = reminder.id!;
      title = reminder.title;
      description = reminder.description;
      hour = reminder.hour;
      frequency = reminder.frequency;
      frequencyText = reminder.frequencyText;
      state = "Pendiente";
      daysSelect = reminder.daysSelect;
      idsNotification = reminder.idsNotification!;
      edit = true;
    }
    refreshUI();
  }

  void updateFrequencyText() {
    if (frequency == "Único") {
      frequencyText = "Único";
    } else if (daysSelect.contains(false)) {
      frequencyText = "Semanal";
    } else {
      frequencyText = "Diario";
    }
    refreshUI();
  }

  void updateDescriptionValue(String value) {
    description = value;
    refreshUI();
  }

  void updateTitleValue(String value) {
    title = value;
    refreshUI();
  }

  void selectTime(TimeOfDay newTime) {
    hour = newTime;
    refreshUI();
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

  @override
  void onDisposed() {
    super.onDisposed();
  }
}
