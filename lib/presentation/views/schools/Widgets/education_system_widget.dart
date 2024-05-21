import 'package:control_system/presentation/resource_manager/color_manager.dart';
import 'package:flutter/material.dart';

class EducationSystemWidget extends StatelessWidget {
  const EducationSystemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 20,
                    offset: const Offset(2, 15), // changes position of shadow
                  ),
                ],
                color: ColorManager.ligthBlue,
                borderRadius: BorderRadius.circular(10)),
            width: double.infinity,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 15,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      // controller.updateSelectedGrade(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorManager.bgSideMenu,
                      ),
                      padding: const EdgeInsets.all(10),
                      child: const Row(
                        children: [
                          Text("fghjkl"
                              // controller.grades[index].name,
                              // style: AppTextStyle.nunitoRegular.copyWith(
                              //   color: AppColor.white,
                              ),

                          // const Spacer(),
                          // IconButton(
                          //     onPressed: () {},
                          //     icon: Icon(
                          //       Icons.edit,
                          //       color: AppColor.white,
                          //     )),
                          // IconButton(
                          //     onPressed: () {},
                          //     icon: Icon(
                          //       Icons.delete,
                          //       color: AppColor.white,
                          //     ))
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
