
import 'package:base/presentation/add_task/add_task.dart';
import 'package:base/presentation/home_screen/home.dart';
import 'package:base/presentation/register_screen/register_screen.dart';
import 'package:get/get.dart';


import '../presentation/login_screen/login_screen.dart';


List<GetPage<dynamic>> appRoute() {
  return [
    GetPage(
      name: "/Register",
      page: () => const RegisterScreen(),
    ),
    GetPage(
      name: "/",
      page: () => const  LoginScreen(),
    ),
   GetPage(
      name: "/AddTask",
      page: () =>   AddTask(
        task: Get.arguments?['task'] ?? null,
      ),
    ),
    GetPage(
      name: "/Home",
      page: () =>  Home(),
    ),
  ];
}
