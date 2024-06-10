import 'package:base/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../core/cubit/task_cubit/task_cubit.dart';
import '../core/model/task_model.dart';
import '../manager/color_manager.dart';
import '../manager/font_manager.dart';
import '../utils/get_dimension.dart';

class DetailCard extends StatelessWidget {
  const DetailCard({super.key, required this.task, required this.index});
  final Task task;
  final String index;

  @override
  Widget build(BuildContext context) {
    final deadlineDate = DateFormat('yyyy-MM-dd').format(task.deadlineDate);
    String formatTimeOfDay(TimeOfDay timeOfDay) {
      final now = DateTime.now();
      final dt = DateTime(
          now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
      final format =
          MaterialLocalizations.of(context).formatTimeOfDay(timeOfDay);
      return format;
    }

    final duration = task.expectedDuration.inHours.toString();
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: appColors.brandLite,
      ),
      width: double.infinity,
      height: screenHeight(context) * 0.90,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Text(
            task.title,
            style: appFont.f22wBoldBlack,
          )),
          Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: appFont.f18w400Black,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    task.description,
                    style: appFont.f16w400Black,
                  )
                ],
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Deadline Date:',
                style: appFont.f18w400Black,
              ),
              Text(deadlineDate, style: appFont.f18w400Black),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Deadline Time:',
                style: appFont.f18w400Black,
              ),
              Text(formatTimeOfDay(task.deadlineTime),
                  style: appFont.f18w400Black),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Expected Task Duration :',
                style: appFont.f18w400Black,
              ),
              Text("$duration hour", style: appFont.f18w400Black),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Task Status :',
                style: appFont.f18w400Black,
              ),
              Text(task.isComplete == false ? 'Incomplete' : 'Completed',
                  style: appFont.f18w400Black),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton(
                  buttonHeight: 10,
                  buttonWidth: screenWidth(context) * 0.25,
                  onTap: () {
                    Get.toNamed('/AddTask', arguments: {'task': task});
                  },
                  title: Icon(
                    Icons.edit,
                    color: Colors.white,
                  )),
              CustomButton(
                  buttonHeight: 10,
                  buttonWidth: screenWidth(context) * 0.25,
                  onTap: () {
                    context.read<TaskCubit>().deleteTask(task.id ?? index);
                    Get.back();
                  },
                  title: Icon(
                    Icons.delete,
                    color: Colors.white,
                  )),
              CustomButton(
                  buttonHeight: 10,
                  buttonWidth: screenWidth(context) * 0.25,
                  onTap: () {
                    context.read<TaskCubit>().toggleTaskCompletion(
                        taskId: task.id ?? index,
                        isComplete: task.isComplete == false ? true : false,
                        task: task);
                    Get.back();
                  },
                  title: Icon(
                    Icons.check_circle_rounded,
                    color: Colors.white,
                  ))
            ],
          ),
          CustomButton(
              buttonWidth: screenWidth(context),
              buttonHeight: 10,
              onTap: () {
                Get.back();
              },
              title: Center(
                  child: Text(
                'Cancel',
                style: appFont.f16w400White,
              )))
        ],
      ),
    );
  }
}
