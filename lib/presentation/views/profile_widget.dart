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
    final String? userName =
        Get.find<ProfileController>().cachedUserProfile?.fullName;
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
        leading: MyBackButton(
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Icon(
                Icons.account_circle,
                size: 120,
                color: ColorManager.greyA8,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Edit Profile',
              style: nunitoBold.copyWith(
                fontSize: 24,
                color: ColorManager.black,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
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
            ),
            const SizedBox(height: 20),
            TextFormField(
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
            ),
            const SizedBox(height: 20),
            TextFormField(
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
            ),
            const SizedBox(height: 20),
            TextFormField(
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
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final isValid = _validateFields();
                if (!isValid) return;

                final data = <String, dynamic>{};

                if (_nameController.text.isNotEmpty) {
                  data['Full_Name'] = _nameController.text;
                }
                if (_oldPasswordController.text.isNotEmpty &&
                    _newPasswordController.text.isNotEmpty) {
                  data['OldPassword'] = _oldPasswordController.text;
                  data['NewPassword'] = _newPasswordController.text;
                }

                final success = await Get.find<ProfileController>().editUser(
                    data, Get.find<ProfileController>().cachedUserProfile!.iD!);

                if (success) {
                  Get.back();
                  MyFlashBar.showSuccess(
                    'Success',
                    'Profile updated successfully',
                  ).show(Get.context!);
                }
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  bool _validateFields() {
    if (_nameController.text.isEmpty &&
        (_oldPasswordController.text.isEmpty ||
            _newPasswordController.text.isEmpty ||
            _confirmNewPasswordController.text.isEmpty)) {
      MyFlashBar.showError(
              'Validation Error', 'Please fill in at least one field')
          .show(Get.context!);
      return false;
    } else if (_newPasswordController.text !=
        _confirmNewPasswordController.text) {
      MyFlashBar.showError('Validation Error', 'New passwords do not match')
          .show(Get.context!);
      return false;
    }
    return true;
  }
}
