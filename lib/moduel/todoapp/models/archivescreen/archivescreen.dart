import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoappnew/moduel/todoapp/cubit/cubit.dart';
import 'package:todoappnew/moduel/todoapp/cubit/state.dart';
import 'package:todoappnew/shared/constants/constants.dart';

class ArchiveScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit,TodoState>(
      listener: (context,TodoState){

      },
      builder: (context,TodoState){
        var cubit=TodoCubit.get(context);
        return ConditionalBuilder(
          condition:cubit.tabelArchiveData.length>0 ,
          builder:(context)=>ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (contex,index)=>BuildTaskItem(cubit.tabelArchiveData[index],context),
              separatorBuilder: (context,index)=>Padding(
                padding: const EdgeInsets.only(
                    left: 20
                ),
                child: Container(
                  height: 2,

                  width: double.infinity,
                  color: Colors.grey,
                ),
              ),
              itemCount: cubit.tabelArchiveData.length) ,
          fallback:(context)=>Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.access_time_filled,
                  size: 70,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'There is No Tasks',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                  ),
                )
              ],
            ),
          ) ,
        );
      },
    );

  }

}