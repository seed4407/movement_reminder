import 'package:flutter/material.dart';

class Reminder {
  final String? id;
  final String title;
  final String description;
  final TimeOfDay hour;
  final String frequency;
  final String frequencyText;
  final String state;
  final List<bool> daysSelect;
  final List<int>? idsNotification;

  Reminder({
    this.id,
    required this.title,
    required this.description,
    required this.hour,
    required this.frequency,
    required this.frequencyText,
    required this.state,
    required this.daysSelect,
    this.idsNotification,
  });

  Reminder copyWith({
    String? id,
    String? title,
    String? description,
    TimeOfDay? hour,
    String? frequency,
    String? frequencyText,
    String? state,
    List<bool>? daysSelect,
    List<int>? idsNotification,
  }) {
    return Reminder(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      hour: hour ?? this.hour,
      frequency: frequency ?? this.frequency,
      frequencyText: frequencyText ?? this.frequencyText,
      state: state ?? this.state,
      daysSelect: daysSelect ?? this.daysSelect,
      idsNotification: idsNotification ?? this.idsNotification,
    );
  }
}
