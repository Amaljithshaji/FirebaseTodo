import 'package:base/utils/get_primarySwatch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'core/cubit/athu_cubit/athu_cubit.dart';
import 'core/cubit/notification_cubit/notification_cubit.dart';
import 'core/cubit/task_cubit/task_cubit.dart';
import 'manager/color_manager.dart';
import 'manager/route_manager.dart';
import 'presentation/home_screen/home.dart';
import 'utils/local_notification.dart';

final navigatorKey = GlobalKey<NavigatorState>();
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await LocalNotifications.init();
  tz.initializeTimeZones();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => NotificationCubit(flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin),
        ),
      ],
      child: Builder(
        builder: (context) {
          return BlocBuilder<AuthCubit, AuthState>(
            builder: (context, authState) {
              if (authState is AuthSuccess) {
                final userId = authState.user.uid;
                return MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => TaskCubit(
                        userId: userId,
                        notificationCubit: context.read<NotificationCubit>(),
                      ),
                    ),
                  ],
                  child: GetMaterialApp(
                    title: 'Todo',
                    debugShowCheckedModeBanner: false,
                    theme: ThemeData(
                      primarySwatch: getMaterialColor(appColors.brandDark),
                      colorScheme: ColorScheme.fromSeed(seedColor: appColors.brandDark),
                      bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.white),
                      useMaterial3: true,
                    ),
                    getPages: appRoute(),
                    initialRoute: '/',
                  ),
                );
              } return GetMaterialApp(
                title: 'Todo',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primarySwatch: getMaterialColor(appColors.brandDark),
                  colorScheme: ColorScheme.fromSeed(seedColor: appColors.brandDark),
                  bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.white),
                  useMaterial3: true,
                ),
                getPages: appRoute(),
                initialRoute: '/',
              );
            },
          );
        },
      ),
    );
  }
}
