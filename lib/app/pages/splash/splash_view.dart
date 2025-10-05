// import 'package:personal_diary/data/repositories/local/data_local_home.dart';
// import 'package:personal_diary/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:movement_reminder/app/pages/splash/splash_controller.dart';
import 'package:movement_reminder/data/repositories/reminder_master_data_repository.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:movement_reminder/theme_notifier.dart';
import 'package:provider/provider.dart';

class SplashPage extends CleanView {
  const SplashPage({Key? key}) : super(key: key);

  @override
  SplashPageView createState() => SplashPageView();
}

class SplashPageView extends CleanViewState<SplashPage, SplashController> {
  SplashPageView() : super(SplashController(ReminderMasterDataRepository()));

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget get view => ControlledWidgetBuilder<SplashController>(
    builder: (BuildContext context, SplashController controller) {
      final size = MediaQuery.of(context).size;
      final themeNotifier = Provider.of<ThemeNotifier>(context);
      return Scaffold(
        key: globalKey,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logo.png', width: size.width * 0.65),
              SizedBox(height: size.height * 0.04),
              Text(
                "Vida activa",
                style: TextStyle(
                  fontSize: size.width * 0.09,
                  fontFamily: "Roboto_BoldC",
                ),
              ),
              SizedBox(height: size.height * 0.04),
              // SizedBox(
              //   width: size.width * 0.15,
              //   height: size.width * 0.15,
              //   child: controller.isLoading
              //       ? CircularProgressIndicator(strokeWidth: 10)
              //       : SvgPicture.asset(
              //           'assets/check.svg',
              //           width: size.width * 0.3,
              //           height: size.height * 0.3,
              //         ),
              // ),
            ],
          ),
        ),
      );
    },
  );
}
