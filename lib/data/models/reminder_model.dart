import 'package:flutter/material.dart';
import 'package:movement_reminder/domain/entities/reminder.dart';

class ReminderModel extends Reminder {
  ReminderModel({
    String? id,
    required String title,
    required String description,
    required TimeOfDay hour,
    required String frequency,
    required String frequencyText,
    required String state,
    required List<bool> daysSelect,
    List<int>? idsNotification,
  }) : super(
         id: id,
         title: title,
         description: description,
         hour: hour,
         frequency: frequency,
         frequencyText: frequencyText,
         state: state,
         daysSelect: daysSelect,
         idsNotification: idsNotification,
       );

  factory ReminderModel.fromEntity(Reminder entity) {
    return ReminderModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      hour: entity.hour,
      frequency: entity.frequency,
      frequencyText: entity.frequencyText,
      state: entity.state,
      daysSelect: entity.daysSelect,
      idsNotification: entity.idsNotification,
    );
  }

  Reminder toEntity() {
    return this;
  }

  factory ReminderModel.fromJson(Map<String, dynamic> json) {
    final String timeString = json['hour'] as String;
    final List<String> parts = timeString.split(':');
    final int hour = int.parse(parts[0]);
    final int minute = int.parse(parts[1]);

    // Manejo de 'idsNotification'
    final List? rawIds = json['idsNotification'] as List?;
    final List<int> safeIds = (rawIds ?? []).cast<int>();

    return ReminderModel(
      id: json['id'] as String?,
      title: json['title'] as String,
      description: json['description'] as String,
      hour: TimeOfDay(hour: hour, minute: minute),
      frequency: json['frequency'] as String,
      frequencyText: json['frequencyText'] as String,
      state: json['state'] as String,
      daysSelect: (json['daysSelect'] as List).cast<bool>(),
      // Usamos 'safeIds' que es List<int> o una lista vacía
      idsNotification: safeIds.isNotEmpty ? safeIds : null,
    );
  }

  Map<String, dynamic> toJson() {
    final String formattedHour =
        '${hour.hour.toString().padLeft(2, '0')}:${hour.minute.toString().padLeft(2, '0')}';

    return {
      'id': id,
      'title': title,
      'description': description,
      'hour': formattedHour,
      'frequency': frequency,
      'frequencyText': frequencyText,
      'state': state,
      'daysSelect': daysSelect,
      'idsNotification': idsNotification,
    };
  }
}
