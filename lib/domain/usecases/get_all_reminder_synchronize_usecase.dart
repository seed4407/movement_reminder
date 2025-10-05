import 'dart:async';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:movement_reminder/domain/entities/reminder.dart';
import 'package:movement_reminder/domain/repositories/reminder_repository.dart';

class GetAllReminderSynchronizeUsecase extends UseCase<void, void> {
  GetAllReminderSynchronizeUsecase(this._syncRepository);
  final ReminderRemoteSync _syncRepository;

  @override
  Future<Stream<void>> buildUseCaseStream(_) async {
    final StreamController<void> controller = StreamController();
    try {
      await _syncRepository.getAllReminderSynchronize();
      controller.add(null);
      logger.finest('GetAllReminderSynchronizeUsecase successful.');
      controller.close();
    } catch (e, stacktrace) {
      logger.severe(
        'GetAllReminderSynchronizeUsecase unsuccessful.',
        e,
        stacktrace,
      );
      controller.addError(e);
      controller.close();
    }
    return controller.stream;
  }
}
