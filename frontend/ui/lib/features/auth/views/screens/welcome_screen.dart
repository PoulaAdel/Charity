library welcome;

import '../../../../utils/ui/ui_utils.dart';
import 'package:flutter/material.dart';
import '../../../../utils/localization/changelocal.dart';
import 'package:get/get.dart';

// component

// binding
part '../../bindings/welcome_binding.dart';

// controller
part '../../controllers/welcome_controller.dart';

// models

class WelcomeScreen extends GetView<TrasnlationController> {
  WelcomeScreen({Key? key}) : super(key: key);

  final WelcomeController welcomeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: welcomeController.scaffoldKey,
      body: ResponsiveBuilder(
        mobileBuilder: (context, constraints) {
          return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Center(
              child: Text("1".tr),
            ),
          ]);
        },
        tabletBuilder: (context, constraints) {
          return SingleChildScrollView(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: (constraints.maxWidth < 950) ? 6 : 9,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text("1".tr),
                        ),
                      ]),
                ),
              ],
            ),
          );
        },
        desktopBuilder: (context, constraints) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 9,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  primary: false,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text("1".tr),
                        ),
                      ]),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
