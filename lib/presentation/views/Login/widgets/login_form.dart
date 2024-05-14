import 'package:control_system/domain/controllers/auth_controller.dart';
import 'package:control_system/domain/indices/index.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/my_text_form_field.dart';
import 'package:control_system/presentation/resource_manager/assets_manager.dart';
import 'package:control_system/presentation/resource_manager/color_manager.dart';
import 'package:control_system/presentation/resource_manager/routes/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class LoginForm extends GetView<AuthController> {
  LoginForm({super.key});

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Center(
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          height: size.height *
              (size.height > 770
                  ? 0.7
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
                            title: "Email",
                            suffixIcon: Icon(
                              Icons.mail_outline,
                              color: ColorManager.glodenColor,
                            ),
                          ),
                          MytextFormFiled(
                            obscureText: controller.showPass,
                            controller: passwordController,
                            title: "Password",
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.showPass
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: ColorManager.glodenColor,
                              ),
                              onPressed: () {
                                controller.setShowPass();
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          Obx(
                            () => Column(
                              children: [
                                controller.isLoading.value
                                    ? const CircularProgressIndicator()
                                    : SizedBox(
                                        width: double.infinity,
                                        height: 50,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            await controller.login(
                                              emailController.text,
                                              passwordController.text,
                                            );

                                            !context.mounted
                                                ? null
                                                : context.goNamed(
                                                    AppRoutesNamesAndPaths
                                                        .schoolsScreenName,
                                                  );
                                          },
                                          child: const Text("Login"),
                                        ),
                                      ),
                              ],
                            ),
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
    );
  }
}
