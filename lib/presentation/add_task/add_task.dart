import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:base/core/cubit/task_cubit/task_cubit.dart';
import 'package:base/core/model/task_model.dart';
import 'package:base/manager/color_manager.dart';
import 'package:base/manager/font_manager.dart';
import 'package:base/manager/space_manger.dart';
import 'package:base/utils/get_dimension.dart';
import 'package:base/widgets/custom_button.dart';
import 'package:base/widgets/custom_textField.dart';

class AddTask extends StatefulWidget {
  final Task? task;

  const AddTask({Key? key, this.task}) : super(key: key);

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController desController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late final FlutterLocalNotificationsPlugin _local;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
     _local = FlutterLocalNotificationsPlugin();
    _initializeLocalNotifications();
    if (widget.task != null) {
      dateController.text = DateFormat('yyyy-MM-dd').format(widget.task!.deadlineDate);
      titleController.text = widget.task!.title;
      desController.text = widget.task!.description;
      durationController.text = widget.task!.expectedDuration.inHours.toString();
      timeController.text = widget.task!.deadlineTime.format(context);
    }
  }

  Future<void> _initializeLocalNotifications() async {
    final AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings("@mipmap/ic_launcher");
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await _local.initialize(initializationSettings);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        timeController.text = selectedTime.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task', style: appFont.f20w500white),
        backgroundColor: appColors.brandDark,
      ),
      backgroundColor: appColors.brandLite,
      body: BlocListener<TaskCubit, TaskState>(
        listener: (context, state) {
          if (state is TaskSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Task Added')));
            Get.toNamed('/Home');
          } else if (state is TaskFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            print(state.message);
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                appSpaces.spaceForHeight20,
                CustomTextField(
                  controller: titleController,
                  floatingTitle: 'Title',
                  hint: 'Title',
                  validator: (value) => value!.isEmpty ? 'Please enter title' : null,
                ),
                appSpaces.spaceForHeight20,
                CustomTextField(
                  controller: desController,
                  floatingTitle: 'Description',
                  hint: 'Description',
                  maxline: 5,
                  validator: (value) => value!.isEmpty ? 'Please enter description' : null,
                ),
                appSpaces.spaceForHeight20,
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: AbsorbPointer(
                    child: CustomTextField(
                      controller: dateController,
                      floatingTitle: 'Deadline Date',
                      hint: 'Deadline Date',
                      validator: (value) => value!.isEmpty ? 'Please enter deadline date' : null,
                    ),
                  ),
                ),
                appSpaces.spaceForHeight20,
                GestureDetector(
                  onTap: () => _selectTime(context),
                  child: AbsorbPointer(
                    child: CustomTextField(
                      controller: timeController,
                      floatingTitle: 'Deadline Time',
                      hint: 'Deadline Time',
                      validator: (value) => value!.isEmpty ? 'Please enter deadline time' : null,
                    ),
                  ),
                ),
                appSpaces.spaceForHeight20,
                CustomTextField(
                  controller: durationController,
                  floatingTitle: 'Task Duration',
                  hint: 'Task Duration',
                  isNumberOnly: true,
                  validator: (value) => value!.isEmpty ? 'Please enter task duration' : null,
                ),
                appSpaces.spaceForHeight20,
                CustomButton(
                  buttonWidth: screenWidth(context),
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      final deadLine = DateTime.parse(dateController.text);
                      final expectedDuration = Duration(hours: int.parse(durationController.text));
                      final deadlineTime = selectedTime;
            
                      if (widget.task == null) {
                        context.read<TaskCubit>().createTask(Task(
                          title: titleController.text,
                          description: desController.text,
                          deadlineDate: deadLine,
                          deadlineTime: deadlineTime,
                          expectedDuration: expectedDuration,
                          isComplete: false,
                        ));
                      } else {
                        context.read<TaskCubit>().updateTask(Task(
                          id: widget.task!.id,
                          title: titleController.text,
                          description: desController.text,
                          deadlineDate: deadLine,
                          deadlineTime: deadlineTime,
                          expectedDuration: expectedDuration,
                          isComplete: false,
                        ));
                      }
                    }
                  },
                  title: Center(child: Text('Save', style: appFont.f16w500white)),
                ),
                CustomButton(
                  buttonWidth: screenWidth(context),
                  onTap: () {
                    Get.back();
                  },
                  title: Center(child: Text('Cancel', style: appFont.f16w500white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
