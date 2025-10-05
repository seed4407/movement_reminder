import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:movement_reminder/app/pages/home/widget/pop_reminder_card/pop_reminder_card_controller.dart';
import 'package:movement_reminder/data/repositories/reminder_master_data_repository.dart';
import 'package:movement_reminder/domain/entities/reminder.dart';
import 'package:movement_reminder/theme_default.dart';
import 'package:movement_reminder/app/pages/home/widget/pop_reminder_card/pop_reminder_card_presenter.dart';

class PopReminderCardPage extends CleanView {
  final Reminder? reminder;

  const PopReminderCardPage({Key? key, this.reminder}) : super(key: key);

  @override
  PopReminderCardView createState() => PopReminderCardView(reminder);
}

class PopReminderCardView
    extends CleanViewState<PopReminderCardPage, PopReminderCardController> {
  PopReminderCardView(Reminder? reminder)
    : super(
        PopReminderCardController(reminder, ReminderMasterDataRepository()),
      );

  @override
  Widget get view => ControlledWidgetBuilder<PopReminderCardController>(
    builder: (BuildContext context, PopReminderCardController controller) {
      final size = MediaQuery.of(context).size;

      final List<String> days = [
        "Lun.",
        "Mar.",
        "Mie.",
        "Jue.",
        "Vie.",
        "Sab.",
        "Dom.",
      ];
      final List<String> frequencys = ["Único", "Periódico"];

      return AlertDialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? UICustomDarkColors.background
            : UICustomLightColors.background,
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.015),
              Text(
                "Titulo",
                style: TextStyle(
                  fontSize: size.width * 0.07,
                  fontFamily: "Roboto_BoldC",
                ),
              ),
              TextFormField(
                initialValue: controller.title,
                decoration: InputDecoration(
                  hintText: "Ingresa titulo del recordatorio",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? UICustomDarkColors.secondary
                          : UICustomLightColors.secondary,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Este campo es obligatorio";
                  }
                  return null;
                },
                onChanged: (value) {
                  controller.updateTitleValue(value);
                },
              ),
              SizedBox(height: size.height * 0.015),
              Text(
                "Descripción",
                style: TextStyle(
                  fontSize: size.width * 0.07,
                  fontFamily: "Roboto_BoldC",
                ),
              ),
              TextFormField(
                maxLines: 5,
                initialValue: controller.description,
                decoration: InputDecoration(
                  hintText: "Ingresa descripción del recordatorio",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? UICustomDarkColors.secondary
                          : UICustomLightColors.secondary,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Este campo es obligatorio";
                  }
                  return null;
                },
                onChanged: (value) {
                  controller.updateDescriptionValue(value);
                },
              ),
              SizedBox(height: size.height * 0.015),
              Text(
                "Frecuencia",
                style: TextStyle(
                  fontSize: size.width * 0.07,
                  fontFamily: "Roboto_BoldC",
                ),
              ),
              Wrap(
                spacing: 6.0,
                runSpacing: 6.0,
                children: frequencys.asMap().entries.map((freque) {
                  return Container(
                    height: size.height * 0.05,
                    width: size.width * 0.3,
                    child: ElevatedButton(
                      onPressed: () => controller.selectFrequency(freque.value),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: controller.frequency == freque.value
                            ? Theme.of(context).brightness == Brightness.dark
                                  ? UICustomLightColors.background
                                  : UICustomDarkColors.background
                            : Theme.of(context).brightness == Brightness.dark
                            ? UICustomDarkColors.background
                            : UICustomLightColors.background,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                ? UICustomDarkColors.primary
                                : UICustomLightColors.primary,
                            width: 1,
                          ),
                        ),
                      ),
                      child: Text(
                        freque.value,
                        style: TextStyle(
                          fontSize: size.width * 0.038,
                          fontFamily: "Roboto_BoldC",
                          color: controller.frequency == freque.value
                              ? Theme.of(context).brightness == Brightness.dark
                                    ? UICustomLightColors.primary
                                    : UICustomDarkColors.primary
                              : Theme.of(context).brightness == Brightness.dark
                              ? UICustomDarkColors.primary
                              : UICustomLightColors.primary,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: size.height * 0.015),
              Text(
                "Días",
                style: TextStyle(
                  fontSize: size.width * 0.07,
                  fontFamily: "Roboto_BoldC",
                ),
              ),
              Wrap(
                spacing: 6.0,
                runSpacing: 6.0,
                children: days.asMap().entries.map((day) {
                  return Container(
                    height: size.height * 0.05,
                    width: size.width * 0.21,
                    child: ElevatedButton(
                      onPressed: () => controller.selectDays(day.key),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: controller.daysSelect[day.key]
                            ? Theme.of(context).brightness == Brightness.dark
                                  ? UICustomLightColors.background
                                  : UICustomDarkColors.background
                            : Theme.of(context).brightness == Brightness.dark
                            ? UICustomDarkColors.background
                            : UICustomLightColors.background,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                ? UICustomDarkColors.primary
                                : UICustomLightColors.primary,
                            width: 1,
                          ),
                        ),
                      ),
                      child: Text(
                        day.value,
                        style: TextStyle(
                          fontSize: size.width * 0.038,
                          fontFamily: "Roboto_BoldC",
                          color: controller.daysSelect[day.key]
                              ? Theme.of(context).brightness == Brightness.dark
                                    ? UICustomLightColors.primary
                                    : UICustomDarkColors.primary
                              : Theme.of(context).brightness == Brightness.dark
                              ? UICustomDarkColors.primary
                              : UICustomLightColors.primary,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: size.height * 0.015),
              Text(
                "Hora",
                style: TextStyle(
                  fontSize: size.width * 0.07,
                  fontFamily: "Roboto_BoldC",
                ),
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final TimeOfDay? picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (picked != null) {
                        controller.selectTime(picked);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.dark
                          ? UICustomDarkColors.background
                          : UICustomLightColors.background,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? UICustomDarkColors.primary
                              : UICustomLightColors.primary,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Text("Seleccionar hora"),
                  ),
                  SizedBox(width: size.width * 0.07),
                  Text(
                    "${controller.hour.hour.toString().padLeft(2, '0')}:${controller.hour.minute.toString().padLeft(2, '0')}",
                    style: TextStyle(
                      fontSize: size.width * 0.07,
                      fontFamily: "Roboto_BoldC",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: size.height * 0.06,
                width: size.width * 0.3,
                child: ElevatedButton(
                  onPressed: () => {Navigator.pop(context)},
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).brightness == Brightness.dark
                        ? UICustomDarkColors.background
                        : UICustomLightColors.background,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? UICustomDarkColors.primary
                            : UICustomLightColors.primary,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Text(
                    "Cancelar",
                    style: TextStyle(
                      fontSize: size.width * 0.045,
                      fontFamily: "Roboto_BoldC",
                    ),
                  ),
                ),
              ),
              Container(
                height: size.height * 0.06,
                width: size.width * 0.3,
                child: ElevatedButton(
                  onPressed: () => {
                    if (controller.title != "" &&
                        controller.description != "" &&
                        controller.frequency != "" &&
                        controller.daysSelect.contains(true) &&
                        !controller.edit)
                      {
                        controller.updateFrequencyText(),
                        controller.createdReminder(
                          Reminder(
                            title: controller.title,
                            description: controller.description,
                            hour: controller.hour,
                            frequency: controller.frequency,
                            frequencyText: controller.frequencyText,
                            state: controller.state,
                            daysSelect: controller.daysSelect,
                            idsNotification: controller.idsNotification,
                          ),
                        ),
                        Navigator.pop(context),
                      },
                    if (controller.title != "" &&
                        controller.description != "" &&
                        controller.frequency != "" &&
                        controller.daysSelect.contains(true) &&
                        controller.edit)
                      {
                        controller.updateFrequencyText(),
                        controller.updateReminder(
                          Reminder(
                            id: controller.id,
                            title: controller.title,
                            description: controller.description,
                            hour: controller.hour,
                            frequency: controller.frequency,
                            frequencyText: controller.frequencyText,
                            state: controller.state,
                            daysSelect: controller.daysSelect,
                            idsNotification: controller.idsNotification,
                          ),
                        ),
                        Navigator.pop(context),
                      },
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).brightness == Brightness.dark
                        ? UICustomDarkColors.background
                        : UICustomLightColors.background,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? UICustomDarkColors.primary
                            : UICustomLightColors.primary,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Text(
                    "Guardar",
                    style: TextStyle(
                      fontSize: size.width * 0.045,
                      fontFamily: "Roboto_BoldC",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
