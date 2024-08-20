import 'package:control_system/presentation/resource_manager/ReusableWidget/my_snak_bar.dart';
import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/controllers/controllers.dart';
import '../resource_manager/ReusableWidget/my_back_button.dart';

class ProfileWidget extends GetView<ProfileController> {
  ProfileWidget({super.key});

  final _nameController = TextEditingController();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();

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
        leading: MyBackButton(onPressed: () => Get.back()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            _buildSaveButton(profileController),
          ],
        ),
      ),
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

  Widget _buildOldPasswordField() {
    return TextFormField(
      controller: _oldPasswordController,
      obscureText: true,
      decoration: const InputDecoration(
        labelText: 'Old Password',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.lock),
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

  Widget _buildNewPasswordField() {
    return TextFormField(
      controller: _newPasswordController,
      obscureText: true,
      decoration: const InputDecoration(
        labelText: 'New Password',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.lock),
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

  Widget _buildConfirmNewPasswordField() {
    return TextFormField(
      controller: _confirmNewPasswordController,
      obscureText: true,
      decoration: const InputDecoration(
        labelText: 'Confirm New Password',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.lock),
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
            MyFlashBar.showSuccess(
              'Success',
              'Profile updated successfully',
            ).show(Get.key.currentContext!);
            Get.back();
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
