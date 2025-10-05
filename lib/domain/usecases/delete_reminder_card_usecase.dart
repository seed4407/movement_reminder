import 'dart:async';
import 'package:movement_reminder/domain/repositories/reminder_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class DeleteReminderUsecase extends UseCase<void, String> {
  final ReminderRepository _reminderCardRepository;

  DeleteReminderUsecase(this._reminderCardRepository);

  @override
  Future<Stream<void>> buildUseCaseStream(String? params) async {
    final StreamController<void> controller = StreamController();
    try {
      await _reminderCardRepository.deleteReminder(params!);
      controller.add(null);
      logger.finest('DeleteReminderCardUsecase successful.');
      controller.close();
    } catch (e, stacktrace) {
      logger.severe('DeleteReminderCardUsecase unsuccessful.', e, stacktrace);
      controller.addError(e);
      controller.close();
    }
    return controller.stream;
  }
}
