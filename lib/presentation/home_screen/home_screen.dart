import 'package:base/core/cubit/task_cubit/task_cubit.dart';
import 'package:base/core/model/task_model.dart';
import 'package:base/manager/color_manager.dart';
import 'package:base/manager/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import '../../core/cubit/athu_cubit/athu_cubit.dart';
import '../../widgets/detail_card.dart';
import '../../widgets/home_screen_widgets/task_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<TaskCubit>().fetchTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Todo',
          style: appFont.f20w500white,
        ),
        backgroundColor: appColors.brandDark,
        actions: [
          IconButton(
              onPressed: () {
                final logout = BlocProvider.of<AuthCubit>(context);
                logout.logout();
                Get.toNamed('/');
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              )),
          SizedBox(
            width: 10,
          )
        ],
      ),
      backgroundColor: appColors.brandLite,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/AddTask');
        },
        backgroundColor: appColors.brandDark,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: BlocListener<TaskCubit, TaskState>(
        listener: (context, state) {
          if (state is TaskSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is TaskFailure) {
            print(state.message);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: BlocBuilder<TaskCubit, TaskState>(
          builder: (context, state) {
            if (state is TaskLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is TasksLoaded) {
              return ListView(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                children: [
                  ResponsiveGridList(
                      listViewBuilderOptions: ListViewBuilderOptions(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics()),
                      minItemWidth: 70,
                      maxItemsPerRow: 1,
                      verticalGridSpacing: 18,
                      horizontalGridSpacing: 10,
                      children:
                          List.generate(state.incompleteTasks.length, (index) {
                        final data = state.incompleteTasks[index];

                        final id = data.id;
                        final title = data.title;

                        return InkWell(
                            onTap: () {
                              showBottom(task: data, index: index.toString());
                            },
                            child: TaskCard(
                              delete: () {
                                context
                                    .read<TaskCubit>()
                                    .deleteTask(id ?? index.toString());
                              },
                              status: () {
                                context.read<TaskCubit>().toggleTaskCompletion(
                                    taskId: id ?? index.toString(),
                                    isComplete: true,
                                    task: data);
                              },
                              update: () {
                                Get.toNamed('/AddTask',
                                    arguments: {'task': data});
                              },
                              title: title,
                            ));
                      }))
                ],
              );
            } else if (state is TaskFailure) {
              return Center(
                child: Text(state.message),
              );
            }
            return Center(
              child: Text(
                'No Complete tasks',
                style: appFont.f22wBoldBlack,
              ),
            );
          },
        ),
      ),
    );
  }

  showBottom({required Task task, required String index}) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return DetailCard(
          task: task,
          index: index,
        );
      },
    );
  }
}
