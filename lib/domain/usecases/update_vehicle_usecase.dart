import 'dart:async';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:movement_reminder/domain/entities/reminder.dart';
import 'package:movement_reminder/domain/repositories/reminder_repository.dart';

class UpdateReminderUsecase extends UseCase<void, Reminder> {
  UpdateReminderUsecase(this._reminderRepository);
  final ReminderRepository _reminderRepository;

  @override
  Future<Stream<void>> buildUseCaseStream(Reminder? params) async {
    final StreamController<void> controller = StreamController();
    try {
      await _reminderRepository.updateReminder(params!);
      controller.add(null);
      logger.finest('UpdateReminderUsecase successful.');
      controller.close();
    } catch (e, stacktrace) {
      logger.severe('UpdateReminderUsecase unsuccessful.', e, stacktrace);
      controller.addError(e);
      controller.close();
    }
    return controller.stream;
  }
}
