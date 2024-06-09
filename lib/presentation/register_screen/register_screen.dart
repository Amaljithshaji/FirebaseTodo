import 'package:base/core/cubit/athu_cubit/athu_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../../manager/font_manager.dart';
import '../../manager/image_manager.dart';
import '../../manager/space_manger.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_textField.dart';
import '../../widgets/resgister_screen_widgets/or_with_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController proffessionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Form(
          key: formKey,
          child: BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
               if (state is AuthSuccess) {
             ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Register success')),
              );
              Get.toNamed('/Home');
            } else if (state is AuthFailure) {
              print(state.message);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
            },
            child: ListView(
              children: [
                appSpaces.spaceForHeight20,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Register',
                      style: appFont.f22wBoldBlack,
                    ),
                    appSpaces.spaceForHeight20,
                    CustomTextField(
                      controller: nameController,
                      trailIcon: Icons.person_2_outlined,
                      radius: 5,
                      height: 5,
                      floatingTitle: "Name",
                      hint: "Enter Name",
                      validator: (name) {
                        if (name.toString() == "") {
                          return "Please Enter Name";
                        }
                        return null;
                      },
                    ),
                    appSpaces.spaceForHeight15,
                    CustomTextField(
                      controller: emailController,
                      trailIcon: Icons.email_outlined,
                      radius: 5,
                      height: 5,
                      floatingTitle: "Email",
                      hint: "Enter Mail Id",
                      validator: (email) {
                        if (email.toString() == "") {
                          return "Please Enter Email";
                        }
                        return null;
                      },
                    ),
                    appSpaces.spaceForHeight15,
                    CustomTextField(
                      controller: mobileController,
                      trailIcon: Icons.call_outlined,
                      radius: 5,
                      height: 5,
                      floatingTitle: "Mobile Number",
                      hint: "Enter Mobile Number",
                      validator: (mobile) {
                        if (mobile.toString() == "") {
                          return "Please Enter Mobile Number";
                        }
                        return null;
                      },
                    ),
                    appSpaces.spaceForHeight15,
                    CustomTextField(
                      maxline: 1,
                      controller: passwordController,
                      isPassword: true,
                      trailIcon: Icons.person_2_outlined,
                      radius: 5,
                      height: 5,
                      floatingTitle: "Password",
                      hint: "Enter Password",
                      validator: (password) {
                        if (password == null || password.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                    appSpaces.spaceForHeight20,
                    CustomButton(
                        buttonWidth: double.infinity,
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            final controller =
                                BlocProvider.of<AuthCubit>(context);
                            controller.register(
                                email: emailController.text,
                                password: passwordController.text,
                                phoneNumber: mobileController.text,
                                userName: nameController.text);
                          }
                          ;
                        },
                        title: Center(
                            child: Text(
                          "Register",
                          style: appFont.f16w400White,
                        ))),
                    appSpaces.spaceForHeight10,
                    const OrContinueWith(),
                    appSpaces.spaceForHeight20,
                     Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(appImages.google),
                                ),
                              ),
                            ),
                            appSpaces.spaceForWidth20,
                            const Text("Continue with Google")
                          ],
                        ),
                      ),
                    appSpaces.spaceForHeight30,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: appFont.f14w400Black,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed('/Login');
                          },
                          child: Text(
                            'Login',
                            style: appFont.f14w600PrimaryDark,
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  handleRegistration() {
    final isValid = formKey.currentState?.validate();
    if (isValid != null && isValid == true) {
      Get.toNamed("/OTPScreen");
    }
    formKey.currentState?.save();
  }
}
