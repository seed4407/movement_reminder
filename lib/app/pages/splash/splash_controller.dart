import 'dart:async';
import 'package:movement_reminder/app/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter/widgets.dart';
import 'package:movement_reminder/app/pages/splash/splash_presenter.dart';
import 'package:movement_reminder/domain/entities/reminder.dart';
import 'package:movement_reminder/domain/repositories/reminder_repository.dart';

class SplashController extends Controller {
  SplashController(ReminderRemoteSync reminderRemoteSyncRepository)
    : _presenter = SplashPresenter(reminderRemoteSyncRepository) {
    getAllReminderSynchronize();
    startLoadingTemporario(Duration(seconds: 2));
  }

  final SplashPresenter _presenter;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<Reminder> reminders = [];

  void startLoadingTemporario(Duration duration) {
    _isLoading = true;
    refreshUI();

    Future.delayed(duration, () {
      _isLoading = false;
      refreshUI();
    });
  }

  void onFinish() {
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(getContext(), Pages.home);
    });
  }

  @override
  void onInitState() {
    super.onInitState();
    onFinish();
  }

  @override
  void initListeners() {
    _presenter.getAllReminderSynchronizeOnNext = () {};

    _presenter.getAllReminderSynchronizeOnComplete = () {
      refreshUI();
    };

    _presenter.getAllReminderSynchronizeOnError = (dynamic error) {
      refreshUI();
    };
  }

  Future<void> getAllReminderSynchronize() async {
    await _presenter.getAllReminderSynchronize();
    refreshUI();
  }

  @override
  void onDisposed() {
    super.onDisposed();
  }
}
