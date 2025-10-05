import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:movement_reminder/app/pages/splash/splash_controller.dart';
import 'package:movement_reminder/data/repositories/reminder_master_data_repository.dart';

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
            ],
          ),
        ),
      );
    },
  );
}
