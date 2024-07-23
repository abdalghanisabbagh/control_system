import 'package:control_system/presentation/resource_manager/constants/app_constatnts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../domain/controllers/auth_controller.dart';
import '../../../resource_manager/ReusableWidget/loading_indicators.dart';
import '../../../resource_manager/ReusableWidget/my_snak_bar.dart';
import '../../../resource_manager/ReusableWidget/my_text_form_field.dart';
import '../../../resource_manager/assets_manager.dart';
import '../../../resource_manager/color_manager.dart';
import '../../../resource_manager/validations.dart';

class LoginForm extends GetView<AuthController> {
  LoginForm({super.key});

  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return KeyboardListener(
      onKeyEvent: (value) {
        if (value.logicalKey == LogicalKeyboardKey.enter) {
          _login(
            controller.login,
            emailController.text,
            passwordController.text,
            formKey,
            context,
          );
        }
      },
      focusNode: FocusNode()..requestFocus(),
      child: Center(
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            height: size.height *
                (size.height > 770
                    ? 0.8
                    : size.height > 670
                        ? 0.7
                        : 0.9),
            width: 500,
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: GetBuilder<AuthController>(
                    init: AuthController(),
                    builder: (controller) {
                      return Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Control System",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Image.asset(
                              AssetsManager.assetsLogosNisLogo,
                              fit: BoxFit.fill,
                              height: 160,
                              width: 160,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              "LOG IN",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[700],
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                              width: 30,
                              child: Divider(
                                color: ColorManager.bgSideMenu,
                                thickness: 2,
                              ),
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            MytextFormFiled(
                              controller: emailController,
                              myValidation: Validations.requiredValidator,
                              title: "Email",
                              suffixIcon: Icon(
                                Icons.mail_outline,
                                color: ColorManager.glodenColor,
                              ),
                            ),
                            GetBuilder<AuthController>(
                              builder: (_) {
                                return MytextFormFiled(
                                  obscureText: controller.showPass,
                                  controller: passwordController,
                                  myValidation: Validations.requiredValidator,
                                  enableBorderColor: ColorManager.grey,
                                  title: "Password",
                                  suffixIcon: GetBuilder<AuthController>(
                                    id: 'pass_icon',
                                    builder: (_) {
                                      return IntrinsicHeight(
                                        child: IntrinsicWidth(
                                          child: IconButton(
                                            icon: AnimatedSwitcher(
                                              duration:
                                                  AppConstants.mediumDuration,
                                              transitionBuilder:
                                                  (child, animation) {
                                                final rotateAnimation =
                                                    Tween<double>(
                                                            begin: 0.0,
                                                            end: 1.0)
                                                        .animate(animation);
                                                final reverseAnimation =
                                                    Tween<double>(
                                                            begin: 1.0,
                                                            end: 0.0)
                                                        .animate(animation);
                                                return RotationTransition(
                                                  turns: controller.showPass
                                                      ? rotateAnimation
                                                      : reverseAnimation,
                                                  child: FadeTransition(
                                                    opacity: animation,
                                                    child: child,
                                                  ),
                                                );
                                              },
                                              layoutBuilder: (currentChild,
                                                  previousChildren) {
                                                return Stack(
                                                  fit: StackFit.loose,
                                                  children: [
                                                    // Show the current child.
                                                    if (currentChild != null)
                                                      Positioned.fill(
                                                        child: Align(
                                                          alignment: Alignment
                                                              .topRight,
                                                          child: currentChild,
                                                        ),
                                                      ),
                                                    // Show the previous children in a stack.
                                                    ...previousChildren.map(
                                                      (child) {
                                                        return Positioned.fill(
                                                          child: Align(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child:
                                                                IgnorePointer(
                                                                    child:
                                                                        child),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                              switchInCurve: Curves.easeOutExpo,
                                              switchOutCurve: Curves.easeInExpo,
                                              child: controller.showPass
                                                  ? Icon(
                                                      key: const ValueKey(1),
                                                      Icons.visibility,
                                                      color: ColorManager
                                                          .glodenColor,
                                                    )
                                                  : Icon(
                                                      key: const ValueKey(2),
                                                      Icons.visibility_off,
                                                      color: ColorManager
                                                          .glodenColor,
                                                    ),
                                            ),
                                            onPressed: () {
                                              controller.setShowPass();
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            GetBuilder<AuthController>(
                              id: 'login_btn',
                              builder: (_) {
                                return controller.isLoading
                                    ? SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: FittedBox(
                                          child: LoadingIndicators
                                              .getLoadingIndicator(),
                                        ),
                                      )
                                    : SizedBox(
                                        width: double.infinity,
                                        height: 50,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            _login(
                                              controller.login,
                                              emailController.text,
                                              passwordController.text,
                                              formKey,
                                              context,
                                            );
                                          },
                                          child: const Text("Login"),
                                        ),
                                      );
                              },
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void _login(
    Future<bool> Function(String email, String password) login,
    String username,
    String password,
    GlobalKey<FormState> formKey,
    BuildContext context) async {
  if (formKey.currentState!.validate()) {
    login(
      username,
      password,
    ).then(
      (value) {
        value
            ? {
                MyFlashBar.showSuccess(
                        'You have been logged in successfully', 'Success')
                    .show(context)
              }
            : null;
      },
    );
  }
}
