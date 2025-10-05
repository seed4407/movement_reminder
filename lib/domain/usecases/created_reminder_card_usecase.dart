import 'dart:async';
import 'package:movement_reminder/domain/entities/reminder.dart';
import 'package:movement_reminder/domain/repositories/reminder_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class CreatedReminderUseCase extends UseCase<void, Reminder> {
  final ReminderRepository _reminderCardRepository;

  CreatedReminderUseCase(this._reminderCardRepository);

  @override
  Future<Stream<void>> buildUseCaseStream(Reminder? params) async {
    final StreamController<void> controller = StreamController();
    try {
      await _reminderCardRepository.createdReminder(params!);
      controller.add(null);
      logger.finest('CreatedReminderCardUseCase successful.');
      controller.close();
    } catch (e, stacktrace) {
      logger.severe('CreatedReminderCardUseCase unsuccessful.', e, stacktrace);
      controller.addError(e);
      controller.close();
    }
    return controller.stream;
  }
}
