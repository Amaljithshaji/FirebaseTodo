import 'package:flutter/material.dart';

import '../../manager/color_manager.dart';
import '../../manager/font_manager.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,required this.title,
    required this.delete,
    required this.status,
    required this.update
  });
  final String title;
  final Function()? update;
  final Function()? delete;
  final Function()? status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: appColors.appGrey
      ),
      child: Row(
        children: [
          Text(title,style: appFont.f20w500white,),
          Spacer(),
          IconButton(onPressed: update, icon: Icon(Icons.edit,color: Colors.white,)),
          IconButton(onPressed: delete, icon: Icon(Icons.delete,color: Colors.white,)),
          IconButton(onPressed: status, icon: Icon(Icons.check_circle_outline_rounded,color: Colors.white,))
    
        ],
      ),
    );
  }
}