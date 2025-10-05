import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:movement_reminder/domain/entities/reminder.dart';
import 'package:movement_reminder/domain/repositories/reminder_repository.dart';
import 'package:movement_reminder/domain/usecases/created_reminder_card_usecase.dart';
import 'package:movement_reminder/domain/usecases/delete_reminder_card_usecase.dart';
import 'package:movement_reminder/domain/usecases/get_all_reminder_usecase.dart';
import 'package:movement_reminder/domain/usecases/update_vehicle_usecase.dart';

class PopReminderCardPresenter extends Presenter {
  PopReminderCardPresenter(ReminderRepository reminderRepository)
    : _updateReminderUsecase = UpdateReminderUsecase(reminderRepository),
      _deleteReminderUsecase = DeleteReminderUsecase(reminderRepository),
      _createdReminderUseCase = CreatedReminderUseCase(reminderRepository),
      _getAllReminderUseCase = GetAllReminderUsecase(reminderRepository);

  Function? updateReminderOnNext;
  Function? updateReminderOnComplete;
  Function? updateReminderOnError;
  final UpdateReminderUsecase _updateReminderUsecase;

  Function? deleteReminderOnNext;
  Function? deleteReminderOnComplete;
  Function? deleteReminderOnError;
  final DeleteReminderUsecase _deleteReminderUsecase;

  Function? createdReminderOnNext;
  Function? createdReminderOnComplete;
  Function? createdReminderOnError;
  final CreatedReminderUseCase _createdReminderUseCase;

  Function? getAllReminderOnNext;
  Function? getAllReminderOnComplete;
  Function? getAllReminderOnError;
  final GetAllReminderUsecase _getAllReminderUseCase;

  Future<void> updateReminder(Reminder reminder) async {
    _updateReminderUsecase.execute(
      _UpdateReminderUsecaseObserver(this),
      reminder,
    );
  }

  Future<void> deleteReminder(String id) async {
    _deleteReminderUsecase.execute(_DeleteReminderUsecaseObserver(this), id);
  }

  Future<void> createdReminder(Reminder reminder) async {
    _createdReminderUseCase.execute(
      _CreatedReminderUseCaseObserver(this),
      reminder,
    );
  }

  Future<void> getAllReminder() async {
    _getAllReminderUseCase.execute(_GetAllReminderUsecaseObserver(this));
  }

  @override
  void dispose() {
    _updateReminderUsecase.dispose();
    _deleteReminderUsecase.dispose();
    _createdReminderUseCase.dispose();
    _getAllReminderUseCase.dispose();
  }
}

class _UpdateReminderUsecaseObserver implements Observer<void> {
  _UpdateReminderUsecaseObserver(this._presenter);
  final PopReminderCardPresenter _presenter;

  @override
  void onNext(void _) {
    _presenter.updateReminderOnNext!();
  }

  @override
  void onComplete() {
    _presenter.updateReminderOnComplete!();
  }

  @override
  void onError(dynamic error) {
    _presenter.updateReminderOnError!(error);
  }
}

class _DeleteReminderUsecaseObserver implements Observer<void> {
  _DeleteReminderUsecaseObserver(this._presenter);
  final PopReminderCardPresenter _presenter;

  @override
  void onNext(void _) {
    _presenter.deleteReminderOnNext!();
  }

  @override
  void onComplete() {
    _presenter.deleteReminderOnComplete!();
  }

  @override
  void onError(dynamic error) {
    _presenter.deleteReminderOnError!(error);
  }
}

class _CreatedReminderUseCaseObserver implements Observer<void> {
  _CreatedReminderUseCaseObserver(this._presenter);
  final PopReminderCardPresenter _presenter;

  @override
  void onNext(void _) {
    _presenter.createdReminderOnNext!();
  }

  @override
  void onComplete() {
    _presenter.createdReminderOnComplete!();
  }

  @override
  void onError(dynamic error) {
    _presenter.createdReminderOnError!(error);
  }
}

class _GetAllReminderUsecaseObserver implements Observer<List<Reminder>> {
  _GetAllReminderUsecaseObserver(this._presenter);
  final PopReminderCardPresenter _presenter;

  @override
  void onNext(List<Reminder>? reminders) {
    _presenter.getAllReminderOnNext!(reminders);
  }

  @override
  void onComplete() {
    _presenter.getAllReminderOnComplete!();
  }

  @override
  void onError(dynamic error) {
    _presenter.getAllReminderOnError!(error);
  }
}
