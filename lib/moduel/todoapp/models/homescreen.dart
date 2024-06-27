import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoappnew/moduel/todoapp/cubit/cubit.dart';
import 'package:todoappnew/moduel/todoapp/cubit/state.dart';
import 'package:todoappnew/shared/constants/constants.dart';




class HomeScreen extends StatelessWidget {
  @override

  var ScafooldKey=GlobalKey<ScaffoldState>();
  var TaskController=TextEditingController();
  var DateController=TextEditingController();
  var TimeController=TextEditingController();


  @override

  var FormKey=GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (BuildContext context)=>TodoCubit()..CreateDataBase(),
      child: BlocConsumer<TodoCubit,TodoState>(
        listener: (context,TodoState){

        },
        builder: (context,TodoState){
          var cubit=TodoCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.grey[200],
            key: ScafooldKey,
            appBar: AppBar(
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.blue,
                    statusBarBrightness: Brightness.dark
                ),
                title: Text(
                  '${cubit.ChangeTitle[cubit.screen]}',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.white
                  ),

                )

            ),

            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(20),
                  topEnd:Radius.circular(20)
                )
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: GNav(
                  backgroundColor: Colors.white,
                  color: Colors.black,
                  gap: 8,
                  selectedIndex: cubit.screen,
                  onTabChange: (index){
                    cubit.ChangeIndex(index);
                  },
                  activeColor: Colors.white,
                  tabBackgroundColor: Colors.blue,
                  tabs: [
                    GButton(
                        icon: Icons.task,
                      text: 'Task',
                    ),
                    GButton(
                      icon: Icons.done,
                      text: 'Done',
                    ),
                    GButton(
                      icon: Icons.archive,
                      text: 'Archive',
                    )


                  ],
                ),
              ),
            ),
            body:cubit.ChangeScreen[cubit.screen] ,
            floatingActionButton: FloatingActionButton(
              onPressed: (){
                if(cubit.IsOpen){
                 if(FormKey.currentState!.validate()){
                   cubit.InsertToDataBase(
                       task: TaskController.text,
                       time: TimeController.text,
                       date: DateController.text);
                   cubit.ChangeShowBottomSheet(boolean: false);
                   Navigator.pop(context);
                 }

                }
                else
                {
                  cubit.ChangeShowBottomSheet(
                    boolean: true,
                  );

                  ScafooldKey.currentState!.showBottomSheet((context) =>Container(
                    color: Colors.grey[200],
                    padding: EdgeInsetsDirectional.all(20),
                    child: Form(
                      key: FormKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          BuildTextFormFieldDefault(
                              LabelText: 'Task Title',
                              border: OutlineInputBorder(),
                              icon: Icons.task,
                              validate: (String?value){
                                if(value==null || value.isEmpty){
                                  return 'You have To enter The Task';
                                }
                              },
                              controller: TaskController),
                          SizedBox(
                            height: 15,
                          ),
                          BuildTextFormFieldDefault(
                              LabelText: 'Time Task',
                              border: OutlineInputBorder(),
                              ontap: (){
                                showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now()).then((value) {
                                  TimeController.text=value!.format(context).toString();
                                });
                              },
                              icon: Icons.watch_later_rounded,
                              validate: (String?value){
                                if(value==null || value.isEmpty){
                                  return 'You have To enter The Time';
                                }
                              },
                              controller: TimeController),
                          SizedBox(
                            height: 15,
                          ),
                          BuildTextFormFieldDefault(
                              LabelText: 'Date Task',
                              border: OutlineInputBorder(),
                              validate: (String?value){
                                if(value==null || value.isEmpty){
                                  return 'You have To enter The Date';
                                }
                              },
                              ontap: (){
                                showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.parse('2024-09-10')).then((value) {
                                  DateController.text=DateFormat.yMMMd().format(value!);
                                });
                              },
                              icon: Icons.calendar_month,
                              controller: DateController)

                        ],
                      ),
                    ),
                  )).closed.then((value) =>{
                    cubit.ChangeShowBottomSheet(boolean: false)


                  });

                }


              },
              child: Icon(
                  cubit.Iconn
              ),
            ),

          );
        },
      ),
    );
  }

}
