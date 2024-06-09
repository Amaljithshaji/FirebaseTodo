import 'package:base/presentation/completed_task/completed_task.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/controller/home_controller.dart';
import '../../manager/color_manager.dart';
import '../../manager/font_manager.dart';
import 'home_screen.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const HomeScreen(),
      const CompletedTask()
      
    ];
    return Obx(
      () => Scaffold(
        body: pages[homeController.currentIndex.value],
        bottomNavigationBar: BottomNavigationBar(
            unselectedLabelStyle: appFont.f14w400Grey,
            selectedLabelStyle: appFont.f14w600Brand,
            elevation: 10,
            showUnselectedLabels: true,
            unselectedItemColor: Colors.grey,
            selectedItemColor: appColors.brandDark,
            currentIndex: homeController.currentIndex.value,
            onTap: (value) {
              homeController.onChangedIndex(value);
            },
            items: List.generate(2, (index) {
              return BottomNavigationBarItem(
                  icon: Icon(
                    bottomBarIcons[index],
                    size: 29,
                  ),
                  label: labels[index]);
            })),
      ),
    );
  }
}

List<IconData> bottomBarIcons = [
  Icons.menu,
  Icons.check,
  
];
List<String> labels = ['Home','Completed Task',];
