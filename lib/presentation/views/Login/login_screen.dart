import 'package:carousel_slider/carousel_slider.dart';
import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/controllers/auth_controller.dart';
import 'widgets/login_form.dart';
import 'widgets/select_school_form.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Opacity(
              opacity: .5,
              child: CarouselSlider(
                items: [
                  Image.asset(
                    width: size.width,
                    height: size.height,
                    AssetsManager.assetsImagesNis1,
                    fit: BoxFit.fill,
                  ),
                  Image.asset(
                    width: size.width,
                    height: size.height,
                    AssetsManager.assetsImagesNis2,
                    fit: BoxFit.fill,
                  ),
                  Image.asset(
                    width: size.width,
                    height: size.height,
                    AssetsManager.assetsImagesNis3,
                    fit: BoxFit.fill,
                  )
                ],
                options: CarouselOptions(
                  height: size.height,
                  viewportFraction: 1.0,
                  autoPlayInterval: const Duration(seconds: 3),
                  enlargeCenterPage: false,
                  scrollPhysics: const NeverScrollableScrollPhysics(),
                  autoPlay: true,
                  reverse: false,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text(
                  "Welcome",
                  style: nunitoBoldStyle(
                    color: ColorManager.primary,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(
                      Icons.copyright,
                      color: ColorManager.primary,
                      size: 24,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Copyright 2024",
                      style: nunitoBoldStyle().copyWith(
                        fontSize: 22,
                        color: ColorManager.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(
                size.height > 770
                    ? 64
                    : size.height > 670
                        ? 32
                        : 16,
              ),
              child: GetBuilder<AuthController>(
                builder: (_) =>
                    controller.isLogin ? const SelectSchoolForm() : LoginForm(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
