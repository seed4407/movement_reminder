import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:movement_reminder/app/pages.dart';
import 'package:movement_reminder/app/pages/splash/splash_controller.dart';
import 'package:movement_reminder/data/models/reminder_model.dart';
import 'package:movement_reminder/data/repositories/reminder_master_data_repository.dart';
import 'package:movement_reminder/domain/entities/reminder.dart';
import 'package:movement_reminder/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

@pragma('vm:entry-point') // Anotación esencial para que Flutter la reconozca
void notificationTapBackground(NotificationResponse notificationResponse) {
  // Este código se ejecuta cuando el usuario interactúa con la notificación
  // y la aplicación está cerrada o en segundo plano.
  print('✅ Acción de fondo recibida: ${notificationResponse.actionId}');

  // NOTA: Si necesitas acceder a lógica de negocio aquí, usa una función
  // estática o un patrón de localizador de servicios (como GetIt).
}

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('America/Santiago'));
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@drawable/logo_notification');

    final InitializationSettings settings = InitializationSettings(
      android: androidSettings,
    );

    void handleNotificationAction(String actionId, String? payload) async {
      try {
        final reminders = FirebaseFirestore.instance.collection('reminders');
        await reminders.doc(payload).update({'estado': "Completado"});

        final prefs = await SharedPreferences.getInstance();
        final String? remindersJson = prefs.getString('reminders');

        List<ReminderModel> remindersShare = [];
        if (remindersJson != null) {
          final List decoded = jsonDecode(remindersJson);
          remindersShare = decoded
              .map((e) => ReminderModel.fromJson(e))
              .toList();
        }

        final int indexToUpdate = remindersShare.indexWhere(
          (r) => r.id == payload,
        );

        if (indexToUpdate != -1) {
          final Reminder updatedReminder = remindersShare[indexToUpdate]
              .toEntity()
              .copyWith(state: "Completado");

          final ReminderModel updatedReminderModel = ReminderModel.fromEntity(
            updatedReminder,
          );

          remindersShare[indexToUpdate] = updatedReminderModel;

          final String encoded = jsonEncode(
            remindersShare.map((r) => r.toJson()).toList(),
          );

          await prefs.setString('reminders', encoded);
        }
      } catch (e, stack) {
        print('Error al manejar acción de notificación: $e');
        print(stack);
      } finally {
        // 3️⃣ Solo después de que todo terminó, navega
        navigatorKey.currentState?.pushNamedAndRemoveUntil(
          Pages.home,
          (route) => false,
        );
      }
    }

    await flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        if (response.actionId != null) {
          // Ejecuta la lógica aquí mismo o llama a un método de la instancia
          handleNotificationAction(response.actionId!, response.payload);
        }
        // Si toca el cuerpo, puedes manejar la navegación aquí (response.actionId == null)
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }

  static const List<AndroidNotificationAction> actionsList = [
    AndroidNotificationAction(
      'action_stop',
      'Completado',
      showsUserInterface: true,
    ),
  ];

  Future<List<int>> showNotificationsForMultipleDays({
    required String id,
    required String title,
    required String body,
    required List<int> days,
    required int hour,
    required int minute,
    required List<int> idsNotification,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      '0',
      'MultipleDays',
      channelDescription: 'Notificaciones semanales',
      importance: Importance.max,
      priority: Priority.high,
      actions: actionsList,
    );

    const platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
    );

    final now = tz.TZDateTime.now(tz.local);
    int index = 0;
    for (var day in days) {
      tz.TZDateTime scheduledDate = tz.TZDateTime(
        tz.local,
        now.year,
        now.month,
        now.day,
        hour,
        minute,
      );

      // Ajusta al próximo día correcto
      while (scheduledDate.weekday != day || scheduledDate.isBefore(now)) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }

      await flutterLocalNotificationsPlugin.zonedSchedule(
        idsNotification[index],
        title,
        body,
        scheduledDate,
        platformDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
        payload: id,
      );
      index++;
    }
    return idsNotification;
  }

  Future<void> showNotificationsForMultipleDaysUnique({
    required String id,
    required String title,
    required String body,
    required List<int> days,
    required int hour,
    required int minute,
    required List<int> idsNotification,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      '1',
      'MultipleDaysUnique',
      channelDescription: 'Notificaciones semanales unica',
      importance: Importance.max,
      priority: Priority.high,
      actions: actionsList,
    );

    const platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
    );

    final now = tz.TZDateTime.now(tz.local);

    int index = 0;
    for (var day in days) {
      // Calcula la próxima fecha para este día
      tz.TZDateTime scheduledDate = tz.TZDateTime(
        tz.local,
        now.year,
        now.month,
        now.day,
        hour,
        minute,
      );

      // Ajusta al próximo día correcto
      while (scheduledDate.weekday != day || scheduledDate.isBefore(now)) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }

      await flutterLocalNotificationsPlugin.zonedSchedule(
        idsNotification[index],
        title,
        body,
        scheduledDate,
        platformDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        payload: id,
      );
      index++;
    }
  }

  Future<void> showNotificationsDaily({
    required String idReminder,
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      '2',
      'Daily',
      channelDescription: 'Notificacion diaria',
      importance: Importance.max,
      priority: Priority.high,
      actions: actionsList,
    );

    const platformDetails = NotificationDetails(android: androidDetails);

    final now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      platformDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: idReminder,
    );
  }

  Future<void> cancelNotificationById(int notificationId) async {
    await flutterLocalNotificationsPlugin.cancel(notificationId);
  }
}
