import 'package:base/core/cubit/task_cubit/task_cubit.dart';
import 'package:base/manager/color_manager.dart';
import 'package:base/manager/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import '../../core/model/task_model.dart';
import '../../widgets/detail_card.dart';

class CompletedTask extends StatefulWidget {
  const CompletedTask({super.key});

  @override
  State<CompletedTask> createState() => _CompletedTaskState();
}

class _CompletedTaskState extends State<CompletedTask> {
  @override
  void initState() {
    context.read<TaskCubit>().fetchTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColors.brandDark,
        automaticallyImplyLeading: false,
        title: Text(
          'Completed Tasks',
          style: appFont.f20w500white,
        ),
      ),
      backgroundColor: appColors.brandLite,
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          if(state is TaskLoading){
            return Center(child: CircularProgressIndicator(),);
          }else if(state is TasksLoaded){
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
                  children: List.generate(state.completedTasks.length, (index) {
                    final task =state.completedTasks[index];
                    return InkWell(
                      onTap: (){
                        showBottom(task: task, index: index.toString());
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        width: double.infinity,
                        height: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: appColors.appGrey),
                        child: Row(
                          children: [
                            Text(
                              task.title,
                              style: appFont.f20w500white,
                            ),
                          ],
                        ),
                      ),
                    );
                  }))
            ],
          );
          }else if(state is TaskFailure){
            return Center(child: Text(state.message),);
          }
          return Center(child: Text('No Complete tasks',style: appFont.f22wBoldBlack,),);
        },
      ),
    );
  }
  showBottom({required Task task,required String index}) {
    showModalBottomSheet(
      context: context,
      builder: (context) {    
        return DetailCard(task: task,
        index: index,);
      },
    );
  }
}
  

