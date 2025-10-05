import 'dart:ffi';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:movement_reminder/domain/entities/reminder.dart';
import 'package:movement_reminder/domain/repositories/reminder_repository.dart';
import 'package:movement_reminder/domain/usecases/get_all_reminder_synchronize_usecase.dart';
import 'package:movement_reminder/domain/usecases/get_all_reminder_usecase.dart';

class SplashPresenter extends Presenter {
  SplashPresenter(ReminderRemoteSync reminderRemoteSyncRepository)
    : _getAllReminderSynchronizeUsecase = GetAllReminderSynchronizeUsecase(
        reminderRemoteSyncRepository,
      );

  Function? getAllReminderSynchronizeOnNext;
  Function? getAllReminderSynchronizeOnComplete;
  Function? getAllReminderSynchronizeOnError;
  final GetAllReminderSynchronizeUsecase _getAllReminderSynchronizeUsecase;

  Future<void> getAllReminderSynchronize() async {
    _getAllReminderSynchronizeUsecase.execute(
      _GetAllReminderSynchronizeUsecaseObserver(this),
    );
  }

  @override
  void dispose() {
    _getAllReminderSynchronizeUsecase.dispose();
  }
}

class _GetAllReminderSynchronizeUsecaseObserver implements Observer<void> {
  _GetAllReminderSynchronizeUsecaseObserver(this._presenter);
  final SplashPresenter _presenter;

  @override
  void onNext(void _) {
    _presenter.getAllReminderSynchronizeOnNext!();
  }

  @override
  void onComplete() {
    _presenter.getAllReminderSynchronizeOnComplete!();
  }

  @override
  void onError(dynamic error) {
    _presenter.getAllReminderSynchronizeOnError!(error);
  }
}
