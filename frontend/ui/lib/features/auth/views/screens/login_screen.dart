library auth_login;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/routes/app_pages.dart';

// component
import '../../../../database/models/app_models.dart';
import '../../../../utils/services/authetication_services.dart';

// binding
part '../../bindings/login_binding.dart';

// controller
part '../../controllers/login_controller.dart';

// models

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final LoginController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Sign in',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Form(
              key: controller.loginFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.controllerID,
                    validator: (value) => controller.usernameExists(value!)
                        ? null
                        : "No Users Found!",
                    maxLines: 1,
                    decoration: InputDecoration(
                      errorStyle: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.yellow,
                      ),
                      hintText: 'Enter your username or phone',
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: controller.controllerPWD,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    maxLines: 1,
                    obscureText: true,
                    decoration: InputDecoration(
                      errorStyle: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.yellow,
                      ),
                      prefixIcon: const Icon(Icons.lock),
                      hintText: 'Enter your password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onEditingComplete: () {
                      if (controller.loginFormKey.currentState!.validate()) {
                        controller.loginCheck();
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (controller.loginFormKey.currentState!.validate()) {
                        controller.loginCheck();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                    ),
                    child: const Text(
                      'Sign in',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Not registered yet?'),
                      TextButton(
                        onPressed: () {
                          Get.offAllNamed(Routes.register);
                        },
                        child: const Text(
                          'Create an account',
                          style: TextStyle(
                            color: Colors.yellow,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
