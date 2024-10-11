library auth_register;

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../shared/constants/app_constants.dart';

import '../../../../config/routes/app_pages.dart';
import '../../../../database/models/app_models.dart';
import '../../../../utils/services/authetication_services.dart';

// binding
part '../../bindings/register_binding.dart';

// controller
part '../../controllers/register_controller.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final RegisterController controller = Get.find();

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
              'Sign up',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Form(
              // autovalidateMode: AutovalidateMode.onUserInteraction,
              key: controller.signupFormKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller._usernameController,
                          validator: (value) =>
                              value.toString().trim().isNotEmpty
                                  ? null
                                  : "Please enter unique username",
                          maxLines: 1,
                          decoration: InputDecoration(
                            errorStyle: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.yellow,
                            ),
                            hintText: 'Username',
                            prefixIcon: const Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: kSpacing,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: controller._phoneController,
                          keyboardType: TextInputType.phone,
                          validator: (value) => value.toString().length == 11
                              ? null
                              : "Please enter a valid Phone Number",
                          maxLines: 1,
                          decoration: InputDecoration(
                            errorStyle: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.yellow,
                            ),
                            hintText: 'Phone',
                            prefixIcon: const Icon(Icons.phone),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: kSpacing,
                  ),
                  TextFormField(
                    controller: controller._emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => EmailValidator.validate(value!)
                        ? null
                        : "Please enter a valid email",
                    maxLines: 1,
                    decoration: InputDecoration(
                      errorStyle: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.yellow,
                      ),
                      hintText: 'Enter your email',
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
                    controller: controller._passwordController,
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
                  ),
                  const SizedBox(
                    height: kSpacing,
                  ),
                  ElevatedButton(
                    onPressed: () => controller.register(),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                    ),
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: kSpacing,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already registered?'),
                      TextButton(
                        onPressed: () {
                          Get.offAllNamed(Routes.login);
                        },
                        child: const Text(
                          'Sign in',
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
