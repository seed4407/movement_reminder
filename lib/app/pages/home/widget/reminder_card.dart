import 'package:flutter/material.dart';
import 'package:movement_reminder/theme_default.dart';

class ReminderCard extends StatelessWidget {
  final String title;
  final String description;
  final TimeOfDay hour;
  final String frequency;
  final String frequencyText;
  final String state;
  final String daySelectText;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onOmitted;
  final VoidCallback onComplete;

  const ReminderCard({
    super.key,
    required this.title,
    required this.description,
    required this.hour,
    required this.frequency,
    required this.frequencyText,
    required this.state,
    required this.daySelectText,
    required this.onEdit,
    required this.onDelete,
    required this.onOmitted,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ExpansionTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: size.width * 0.08,
          fontFamily: "Roboto_BoldC",
        ),
      ),

      subtitle: Text(
        state,
        style: TextStyle(
          fontSize: size.width * 0.05,
          fontFamily: "Roboto_BoldC",
        ),
      ),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.01),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      daySelectText,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: size.width * 0.05,
                        fontFamily: "Roboto_BoldC",
                      ),
                    ),
                  ),
                  SizedBox(width: size.width * 0.03),
                  Text(
                    '${hour.hour.toString().padLeft(2, '0')}:${hour.minute.toString().padLeft(2, '0')}',
                    style: TextStyle(
                      fontSize: size.width * 0.05,
                      fontFamily: "Roboto_BoldC",
                    ),
                  ),
                ],
              ),
              Text(
                frequencyText,
                style: TextStyle(
                  fontSize: size.width * 0.05,
                  fontFamily: "Roboto_BoldC",
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Text(
                description,
                style: TextStyle(
                  fontSize: size.width * 0.05,
                  fontFamily: "Roboto_BoldC",
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: size.height * 0.03),
              Row(
                children: [
                  Container(
                    height: size.height * 0.06,
                    width: size.width * 0.3,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).brightness == Brightness.dark
                            ? UICustomDarkColors.background
                            : UICustomLightColors.background,
                        padding: EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                ? UICustomDarkColors.secondary
                                : UICustomLightColors.secondary,
                            width: 4,
                          ),
                        ),
                      ),
                      onPressed: () {
                        onComplete();
                      },
                      child: Text(
                        "Completado",
                        style: TextStyle(
                          fontSize: size.width * 0.05,
                          fontFamily: "Roboto_BoldC",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: size.width * 0.03),
                  Container(
                    height: size.height * 0.06,
                    width: size.width * 0.3,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).brightness == Brightness.dark
                            ? UICustomDarkColors.background
                            : UICustomLightColors.background,
                        padding: EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                ? UICustomDarkColors.secondary
                                : UICustomLightColors.secondary,
                            width: 4,
                          ),
                        ),
                      ),
                      onPressed: () {
                        onOmitted();
                      },
                      child: Text(
                        "Omitir",
                        style: TextStyle(
                          fontSize: size.width * 0.05,
                          fontFamily: "Roboto_BoldC",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.03),
              Row(
                children: [
                  Container(
                    height: size.height * 0.06,
                    // width: size.width * 0.3,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).brightness == Brightness.dark
                            ? UICustomDarkColors.background
                            : UICustomLightColors.background,
                        padding: EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                ? UICustomDarkColors.secondary
                                : UICustomLightColors.secondary,
                            width: 4,
                          ),
                        ),
                      ),
                      onPressed: () {
                        onEdit();
                      },
                      child: Icon(
                        Icons.mode_edit_rounded,
                        size: size.width * 0.08,
                      ),
                    ),
                  ),
                  SizedBox(width: size.width * 0.03),
                  Container(
                    height: size.height * 0.06,
                    // width: size.width * 0.3,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).brightness == Brightness.dark
                            ? UICustomDarkColors.background
                            : UICustomLightColors.background,
                        padding: EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                ? UICustomDarkColors.secondary
                                : UICustomLightColors.secondary,
                            width: 4,
                          ),
                        ),
                      ),
                      onPressed: () {
                        onDelete();
                      },
                      child: Icon(Icons.close, size: size.width * 0.08),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.03),
            ],
          ),
        ),
      ],
    );
  }
}
