import 'package:base/core/cubit/athu_cubit/athu_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../manager/font_manager.dart';
import '../../manager/image_manager.dart';
import '../../manager/space_manger.dart';
import '../../utils/get_dimension.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textField.dart';
import '../../widgets/resgister_screen_widgets/or_with_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController proffessionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
       listener: (context, state) {
            if (state is AuthSuccess) {
             ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('login success')),
              );
              Get.toNamed('/Home');
            } else if (state is AuthFailure) {
              print(state.message);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  SizedBox(
                    height: screenHeight(context) * 0.12,
                  ),
                  appSpaces.spaceForHeight30,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Login',
                        style: appFont.f22wBoldBlack,
                      ),
                      appSpaces.spaceForHeight30,
                      CustomTextField(
                         trailIcon: Icons.person_2_outlined,
                        controller: emailController,
                        radius: 5,
                        height: 10,
                        floatingTitle: "Email Id",
                        hint: "Enter Email Id",
                        validator: (email) {
                           if (email == null ) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;}
                      ),
                      appSpaces.spaceForHeight20,
                      CustomTextField(
                        maxline: 1,
                        controller: passwordController,
                        trailIcon: Icons.person_2_outlined,
                        isPassword: true,
                        radius: 5,
                        height: 10,
                        floatingTitle: "Password",
                        hint: "Enter Your Password",
                        validator: (password) {
                          if (password == null || password.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;}
                      ),
                      appSpaces.spaceForHeight20,
                      CustomButton(
                          buttonWidth: double.infinity,
                          onTap: () {
                             if (formKey.currentState!.validate()) {
                            context.read<AuthCubit>().login(email: emailController.text, password: passwordController.text);
                             };
                          },
                          title: Center(child: Text("Login",style: appFont.f16w400White,))),
                      appSpaces.spaceForHeight30,
                      const OrContinueWith(),
                      appSpaces.spaceForHeight30,
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
                            "doesn't have an Account ? ",
                            style: appFont.f14w400Black,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed('/Register');
                            },
                            child: Text(
                              'Register',
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
