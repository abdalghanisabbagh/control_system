import 'package:custom_theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteMissionWidget extends StatelessWidget {
  final double? curve;

  const DeleteMissionWidget({super.key, required this.curve});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: IconButton(
              alignment: AlignmentDirectional.topEnd,
              color: Colors.black,
              icon: const Icon(Icons.close),
              onPressed: () {
                Get.back();
              },
            ),
          ),
          Text(
            "Delete Mission",
            style: nunitoBold.copyWith(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          Text(
            "Are You Sure ?",
            style: nunitoRegular.copyWith(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(11),
                      ),
                      color: ColorManager.bgSideMenu,
                    ),
                    child: Center(
                      child: Text(
                        "No",
                        style: nunitoRegular.copyWith(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(11),
                      ),
                      color: ColorManager.glodenColor,
                    ),
                    child: Center(
                      child: Text(
                        "Yes",
                        style: nunitoRegular.copyWith(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
