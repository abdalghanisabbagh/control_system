import 'package:custom_theme/lib.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:universal_html/html.dart';

import '../../../../domain/controllers/controllers.dart';
import '../../Data/Models/user/login_response/user_profile_model.dart';
import '../resource_manager/ReusableWidget/loading_indicators.dart';
import '../resource_manager/ReusableWidget/my_back_button.dart';
import '../resource_manager/ReusableWidget/my_snack_bar.dart';

class ProfileWidget extends GetView<ProfileController> {
  final _confirmNewPasswordController = TextEditingController();

  final _nameController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _oldPasswordController = TextEditingController();
  ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();
    final String? userName = profileController.cachedUserProfile?.fullName;
    _nameController.text = userName ?? '';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.primary,
        title: Text(
          'Profile',
          style: nunitoBold.copyWith(
            color: ColorManager.white,
            fontSize: 20,
          ),
        ),
        leading: const MyBackButton(
          color: ColorManager.white,
        ),
      ),
      body: Center(
        child: SizedBox(
          width: Get.width * 0.5,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: GetBuilder<ProfileController>(
              builder: (_) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildProfileIcon(),
                    const SizedBox(height: 20),
                    _buildEditProfileTitle(),
                    const SizedBox(height: 20),
                    _buildNameField(),
                    const SizedBox(height: 20),
                    _buildOldPasswordField(),
                    const SizedBox(height: 20),
                    _buildNewPasswordField(),
                    const SizedBox(height: 20),
                    _buildConfirmNewPasswordField(),
                    const SizedBox(height: 20),
                    controller.isLoadingEditUser
                        ? SizedBox(
                            width: 50,
                            height: 50,
                            child: FittedBox(
                              child: LoadingIndicators.getLoadingIndicator(),
                            ),
                          )
                        : _buildSaveButton(profileController),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildConfirmNewPasswordField() {
    return TextFormField(
      controller: _confirmNewPasswordController,
      obscureText: controller.showPassword,
      decoration: InputDecoration(
        labelText: 'Confirm New Password',
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          onPressed: () {
            controller.showPassword = !controller.showPassword;
            controller.update();
          },
          icon: controller.showPassword
              ? const Icon(Icons.visibility)
              : const Icon(Icons.visibility_off),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please confirm your new password';
        }
        if (value != _newPasswordController.text) {
          return 'Passwords do not match';
        }
        return null;
      },
    );
  }

  Widget _buildEditProfileTitle() {
    return Text(
      'Edit Profile',
      style: nunitoBold.copyWith(
        fontSize: 24,
        color: ColorManager.black,
      ),
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      controller: _nameController,
      decoration: const InputDecoration(
        labelText: 'Name',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.person),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your name';
        }
        return null;
      },
    );
  }

  Widget _buildNewPasswordField() {
    return TextFormField(
      controller: _newPasswordController,
      obscureText: controller.showPassword,
      decoration: InputDecoration(
        labelText: 'New Password',
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          onPressed: () {
            controller.showPassword = !controller.showPassword;
            controller.update();
          },
          icon: controller.showPassword
              ? const Icon(Icons.visibility)
              : const Icon(Icons.visibility_off),
        ),
      ),
      validator: (value) {
        if (_confirmNewPasswordController.text.isNotEmpty) {
          if (value == null || value.isEmpty) {
            return 'Please enter your new password';
          }
        }
        return null;
      },
    );
  }

  Widget _buildOldPasswordField() {
    return TextFormField(
      controller: _oldPasswordController,
      obscureText: controller.showOldPassword,
      decoration: InputDecoration(
        labelText: 'Old Password',
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          onPressed: () {
            controller.showOldPassword = !controller.showOldPassword;
            controller.update();
          },
          icon: controller.showOldPassword
              ? const Icon(Icons.visibility)
              : const Icon(Icons.visibility_off),
        ),
      ),
      validator: (value) {
        if (_newPasswordController.text.isNotEmpty ||
            _confirmNewPasswordController.text.isNotEmpty) {
          if (value == null || value.isEmpty) {
            return 'Please enter your old password';
          }
        }
        return null;
      },
    );
  }

  Widget _buildProfileIcon() {
    return const Center(
      child: Icon(
        Icons.account_circle,
        size: 120,
        color: ColorManager.greyA8,
      ),
    );
  }

  Widget _buildSaveButton(ProfileController profileController) {
    return ElevatedButton(
      onPressed: () async {
        if (_validateFields()) {
          final data = <String, dynamic>{};

          if (_nameController.text.isNotEmpty) {
            data['Full_Name'] = _nameController.text;
          }
          if (_oldPasswordController.text.isNotEmpty &&
              _newPasswordController.text.isNotEmpty) {
            data['OldPassword'] = _oldPasswordController.text;
            data['NewPassword'] = _newPasswordController.text;
          }

          final success = await profileController.editUser(
              data, profileController.cachedUserProfile!.iD!);

          if (success) {
            UserProfileModel userProfile = profileController.cachedUserProfile!
              ..fullName = _nameController.text;
            profileController.saveProfileToHiveBox(userProfile);
            MyFlashBar.showSuccess(
              'Success',
              'Profile updated successfully',
            ).show(Get.key.currentContext!);
            await Future.delayed(const Duration(milliseconds: 1000));
            kIsWeb ? window.history.back() : Get.key.currentContext!.pop();
          }
        }
      },
      child: const Text('Save Changes'),
    );
  }

  bool _validateFields() {
    if (_nameController.text.isEmpty &&
        (_oldPasswordController.text.isEmpty ||
            _newPasswordController.text.isEmpty ||
            _confirmNewPasswordController.text.isEmpty)) {
      MyFlashBar.showError(
              'Validation Error', 'Please fill in at least one field')
          .show(Get.key.currentContext!);
      return false;
    } else if (_newPasswordController.text !=
        _confirmNewPasswordController.text) {
      MyFlashBar.showError('Validation Error', 'New passwords do not match')
          .show(Get.key.currentContext!);
      return false;
    }
    return true;
  }
}
