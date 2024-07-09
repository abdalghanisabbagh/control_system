import 'package:control_system/Data/Models/subject/subject_res_model.dart';
import 'package:control_system/presentation/resource_manager/ReusableWidget/elevated_edit_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/controllers/subject_controller.dart';
import '../../../resource_manager/ReusableWidget/elevated_back_button.dart';
import '../../../resource_manager/ReusableWidget/my_snak_bar.dart';
import '../../../resource_manager/color_manager.dart';
import '../../../resource_manager/styles_manager.dart';

class EditSubjectWidget extends StatelessWidget {
  const EditSubjectWidget({
    super.key,
    required this.subject,
  });

  final SubjectResModel subject;

  @override
  Widget build(BuildContext context) {
    TextEditingController subjectNameController = TextEditingController()
      ..text = subject.name ?? "";

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Edit Subject",
          style: nunitoRegular.copyWith(
            color: ColorManager.bgSideMenu,
            fontSize: 25,
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        TextFormField(
          cursorColor: ColorManager.bgSideMenu,
          style: nunitoRegular.copyWith(
              fontSize: 14, color: ColorManager.bgSideMenu),
          decoration: InputDecoration(
            hintText: "Subject name",
            hintStyle: nunitoRegular.copyWith(
                fontSize: 14, color: ColorManager.bgSideMenu),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          controller: subjectNameController,
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Text(
              "InExam  ",
              style: nunitoRegular.copyWith(
                  fontSize: 14, color: ColorManager.bgSideMenu),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        GetBuilder<SubjectsController>(
          builder: (controller) {
            return controller.addLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Row(
                    children: [
                      const Expanded(
                        child: ElevatedBackButton(),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: ElevatedEditButton(
                          onPressed: () async {
                            await controller
                                .editSubject(
                                    id: subject.iD!,
                                    name: subjectNameController.text)
                                .then(
                              (value) {
                                value
                                    ? {
                                        context.pop(),
                                        MyFlashBar.showSuccess(
                                                'The Subject Has Been Updated Successfully',
                                                'Success')
                                            .show(context)
                                      }
                                    : MyFlashBar.showError(
                                            'Something went wrong', 'Error')
                                        .show(context);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  );
          },
        )
      ],
    );
  }
}
