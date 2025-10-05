import 'package:movement_reminder/app/pages/home/home_controller.dart';
// import 'package:personal_diary/data/repositories/local/data_local_home.dart';
// import 'package:personal_diary/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:movement_reminder/app/pages/home/widget/pop_reminder_card/pop_reminder_card_view.dart';
import 'package:movement_reminder/data/repositories/reminder_master_data_repository.dart';
import 'package:movement_reminder/theme_default.dart';
import 'package:movement_reminder/theme_notifier.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movement_reminder/app/pages/home/widget/reminder_card.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends CleanView {
  const HomePage({Key? key}) : super(key: key);

  // final User user;

  @override
  HomePageView createState() => HomePageView();
}

class HomePageView extends CleanViewState<HomePage, HomeController> {
  HomePageView() : super(HomeController(ReminderMasterDataRepository()));

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget get view => ControlledWidgetBuilder<HomeController>(
    builder: (BuildContext context, HomeController controller) {
      final size = MediaQuery.of(context).size;
      final themeNotifier = Provider.of<ThemeNotifier>(context);
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: size.height * 0.1,
          title: Text(
            "Vida activa",
            style: TextStyle(
              fontSize: size.width * 0.1,
              fontFamily: "Roboto_BoldC",
            ),
          ),
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu, size: size.width * 0.1),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ),
        drawer: Drawer(
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? UICustomDarkColors.background
              : UICustomLightColors.background,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                height: size.height * 0.15,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? UICustomDarkColors.secondary
                        : UICustomLightColors.secondary,
                  ),
                  child: Text(
                    "Menú",
                    style: TextStyle(
                      fontSize: size.width * 0.1,
                      fontFamily: "Roboto_BoldC",
                    ),
                  ),
                ),
              ),

              ListTile(
                leading: Icon(Icons.settings, size: size.width * 0.1),
                title: Text(
                  "Configuración",
                  style: TextStyle(
                    fontSize: size.width * 0.07,
                    fontFamily: "Roboto_BoldC",
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  print("Ir a Configuración");
                },
              ),
              ListTile(
                leading: Icon(Icons.logout, size: size.width * 0.1),
                title: Text(
                  "Cerrar sesión",
                  style: TextStyle(
                    fontSize: size.width * 0.07,
                    fontFamily: "Roboto_BoldC",
                  ),
                ),
                onTap: () {
                  print("Cerrar sesión");
                },
              ),
              SizedBox(height: size.height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/sun.svg',
                    width: size.width * 0.06,
                    height: size.height * 0.06,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).brightness == Brightness.dark
                          ? UICustomDarkColors.primary
                          : UICustomLightColors.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.06,
                    ),
                    child: Transform.scale(
                      scale: 1.3,
                      child: Switch(
                        value: themeNotifier.isDarkMode,
                        onChanged: (bool newValue) {
                          themeNotifier.toggleTheme();
                        },
                      ),
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/moon.svg',
                    width: size.width * 0.06,
                    height: size.height * 0.06,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).brightness == Brightness.dark
                          ? UICustomDarkColors.primary
                          : UICustomLightColors.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: SizedBox(
          width: size.width * 0.2,
          height: size.height * 0.1,
          child: FloatingActionButton(
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (context) => PopReminderCardPage(),
              );
              controller.getAllReminder();
            },
            child: Icon(Icons.add, size: size.width * 0.13),
          ),
        ),
        body: Padding(
          padding: EdgeInsetsGeometry.symmetric(
            horizontal: size.width * 0.03,
            vertical: size.height * 0.03,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Recordatorios",
                      style: TextStyle(
                        fontSize: size.width * 0.08,
                        fontFamily: "Roboto_BoldC",
                      ),
                    ),
                  ],
                ),
                Divider(thickness: 3, indent: 0, endIndent: 0),
                SizedBox(height: size.height * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    PopupMenuButton<String>(
                      onSelected: (value) {
                        controller.changeFilter(value);
                      },
                      offset: Offset(0, size.height * 0.07),
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                            PopupMenuItem<String>(
                              value: 'Todos',
                              child: Text(
                                'Todos',
                                style: TextStyle(
                                  fontSize: size.width * 0.05,
                                  fontFamily: "Roboto_BoldC",
                                ),
                              ),
                            ),
                            PopupMenuItem<String>(
                              value: 'Completado',
                              child: Text(
                                'Completado',
                                style: TextStyle(
                                  fontSize: size.width * 0.05,
                                  fontFamily: "Roboto_BoldC",
                                ),
                              ),
                            ),
                            PopupMenuItem<String>(
                              value: 'Pendiente',
                              child: Text(
                                'Pendiente',
                                style: TextStyle(
                                  fontSize: size.width * 0.05,
                                  fontFamily: "Roboto_BoldC",
                                ),
                              ),
                            ),
                            PopupMenuItem<String>(
                              value: 'Omitido',
                              child: Text(
                                'Omitido',
                                style: TextStyle(
                                  fontSize: size.width * 0.05,
                                  fontFamily: "Roboto_BoldC",
                                ),
                              ),
                            ),
                          ],
                      child: Container(
                        height: size.height * 0.06,
                        width: size.width * 0.43,
                        child: ElevatedButton(
                          onPressed: null,
                          style: ElevatedButton.styleFrom(
                            disabledForegroundColor:
                                Theme.of(context).brightness == Brightness.dark
                                ? UICustomDarkColors.primary
                                : UICustomLightColors.primary,
                            disabledBackgroundColor:
                                Theme.of(context).brightness == Brightness.dark
                                ? UICustomDarkColors.background
                                : UICustomLightColors.background,
                            backgroundColor:
                                Theme.of(context).brightness == Brightness.dark
                                ? UICustomDarkColors.background
                                : UICustomLightColors.background,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: BorderSide(
                                color:
                                    Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? UICustomDarkColors.secondary
                                    : UICustomLightColors.secondary,
                                width: 4,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.filter_alt, size: size.width * 0.07),
                              Text(
                                controller.filterFor == ""
                                    ? "Filtrar"
                                    : controller.filterFor,
                                style: TextStyle(
                                  fontSize: size.width * 0.045,
                                  fontFamily: "Roboto_BoldC",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.02),
                ...(controller.filterFor == "Todos"
                        ? controller.reminders
                        : controller.reminders
                              .where((r) => r.state == controller.filterFor)
                              .toList())
                    .map((reminder) {
                      controller.generateDays(reminder.daysSelect);
                      return ReminderCard(
                        title: reminder.title,
                        description: reminder.description,
                        hour: reminder.hour,
                        frequency: reminder.frequency,
                        frequencyText: reminder.frequencyText,
                        daySelectText: controller.daysText,
                        state: reminder.state,
                        onEdit: () async {
                          await showDialog(
                            context: context,
                            builder: (context) =>
                                PopReminderCardPage(reminder: reminder),
                          );
                          controller.getAllReminder();
                        },
                        onComplete: () async {
                          controller.onComplete(reminder);
                          controller.getAllReminder();
                        },
                        onOmitted: () async {
                          controller.onOmitted(reminder);
                          controller.getAllReminder();
                        },
                        onDelete: () async {
                          controller.deleteReminder(reminder.id!);
                          controller.getAllReminder();
                        },
                      );
                    })
                    .toList(),
                SizedBox(height: size.height * 0.1),
              ],
            ),
          ),
        ),
      );
    },
  );
}
