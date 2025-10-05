import 'dart:async';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:movement_reminder/domain/entities/reminder.dart';
import 'package:movement_reminder/domain/repositories/reminder_repository.dart';

class GetAllReminderUsecase extends UseCase<List<Reminder>?, void> {
  GetAllReminderUsecase(this._reminderRepository);
  final ReminderRepository _reminderRepository;

  @override
  Future<Stream<List<Reminder>?>> buildUseCaseStream(_) async {
    final StreamController<List<Reminder>?> controller = StreamController();
    try {
      final List<Reminder>? reminders = await _reminderRepository
          .getAllReminder();
      controller.add(reminders);
      logger.finest('GetAllReminderUsecase successful.');
      controller.close();
    } catch (e, stacktrace) {
      logger.severe('GetAllReminderUsecase unsuccessful.', e, stacktrace);
      controller.addError(e);
      controller.close();
    }
    return controller.stream;
  }
}
