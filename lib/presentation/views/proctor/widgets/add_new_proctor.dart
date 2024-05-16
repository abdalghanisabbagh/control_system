import 'package:control_system/presentation/resource_manager/ReusableWidget/elevated_back_button.dart';
import 'package:control_system/presentation/resource_manager/index.dart';
import 'package:flutter/material.dart';

class AddNewProctor extends StatelessWidget {
  const AddNewProctor({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        // key: proctorcontroller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 450,
              child: TextFormField(
                // controller: proctorcontroller.usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: 450,
              child:
                  // GetBuilder<Proctor_controller>(
                  //   builder: (context) {
                  //     return
                  TextFormField(
                // controller: proctorcontroller.passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      // proctorcontroller.showPass
                      //     ? Icons.visibility
                      //     :
                      Icons.visibility_off,
                      color: ColorManager.glodenColor,
                    ),
                    onPressed: () {
                      // proctorcontroller.showPass =
                      //     !proctorcontroller.showPass;
                      // proctorcontroller.update();
                    },
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
                // obscureText: proctorcontroller.showPass,
                //   );
                // },
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: 450,
              child: TextFormField(
                // controller: proctorcontroller.confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      // proctorcontroller.showPass
                      //     ? Icons.visibility
                      //:
                      Icons.visibility_off,
                      color: ColorManager.glodenColor,
                    ),
                    onPressed: () {
                      // proctorcontroller.showPass =
                      //     !proctorcontroller.showPass;
                      // proctorcontroller.update();
                    },
                  ),
                ),
                // validator: (value) {
                //   if (value!.isEmpty) {
                //     return 'Please enter a Confirm password';
                //   } else if (value !=
                //       proctorcontroller.passwordController.text) {
                //     return 'password not match';
                //   } else {
                //     return null;
                //   }
                // },
                // obscureText: proctorcontroller.showPass,
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: 450,
              child: TextFormField(
                // controller: proctorcontroller.nisIdController,
                decoration: InputDecoration(
                  labelText: 'NIS ID',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a NIS ID';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 16.0),
            /*    SizedBox(
              width: 450,
              child: TextFormField(
                controller: proctorcontroller.nationController,
                decoration: InputDecoration(
                  labelText: 'National Id',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a National Id';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 16.0),
        
            GetBuilder<Proctor_controller>(builder: (context) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Text('Floor Manager :'),
                      Switch(
                          value: proctorcontroller.isFloorManager,
                          activeColor: ColorManager.glodenColor,
                          onChanged: (newValue) {
                            proctorcontroller.isFloorManager = newValue;
                            proctorcontroller.update();
                          }),
                    ],
                  ),
                  if (proctorcontroller.isFloorManager)
                    SizedBox(
                      width: 450,
                      child: DropdownSearch<String>(
                        items: proctorcontroller.mission.roomType,
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: ColorManager.glodenColor),
                                  borderRadius: BorderRadius.circular(10)),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: ColorManager.glodenColor),
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: "Select Stage",
                              hintStyle: AppTextStyle.nunitoRegular.copyWith(
                                  fontSize: 16, color: ColorManager.black)),
                        ),
                        onChanged: (value) {
                          proctorcontroller.roomTypePrincepl = value;
                        },
                      ),
                    ),
                ],
              );
            }),
            */
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    //  proctorcontroller.submitForm,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.glodenColor),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(11),
                        ),
                        color: ColorManager.glodenColor,
                      ),
                      child: Center(
                        child: Text(
                          "Create Proctor",
                          style: nunitoRegular.copyWith(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                const Expanded(
                  child: ElevatedBackButton(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
