import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoappnew/moduel/todoapp/cubit/state.dart';
import 'package:todoappnew/moduel/todoapp/models/archivescreen/archivescreen.dart';
import 'package:todoappnew/moduel/todoapp/models/donescreen/donescreen.dart';
import 'package:todoappnew/moduel/todoapp/models/taskscreen/taskscreen.dart';

import 'package:todoappnew/shared/CasheHelper/CasheHelper.dart';

class TodoCubit extends Cubit<TodoState>{
  TodoCubit():super(InitialTodoState());
  static TodoCubit get(context)=>BlocProvider.of(context);
  List<Map> tabelTaskData=[];
  List<Map> tabelDoneData=[];
  List<Map> tabelArchiveData=[];
  int screen=0;
  Database ?database;

  List<Widget> ChangeScreen=[
    TaskScreen(),
    DoneScreen(),
    ArchiveScreen()
  ];


  List<String> ChangeTitle=[
    'Tasks',
    'Done Tasks',
    'Archive Tasks'
  ];


  bool IsOpen=false;


  IconData Iconn=Icons.edit;


  void ChangeShowBottomSheet({
    required bool boolean,
}){
    IsOpen=boolean;
    Iconn=IsOpen==true?Icons.add:Icons.edit;
    emit(ChangeOpenBottomSheeetState());



  }
  void ChangeIndex(int index){
    screen=index;
    emit(ChangeIndexState());
  }
  bool isDark=false;



  void CreateDataBase() async{
     database=await openDatabase(
        'aya.db',
        version: 1,
        onCreate: (database,version){
          print('data base is created');
          database.execute(
              'CREATE TABLE aya (id INTEGER PRIMARY KEY,task TEXT,time TEXT,date TEXT,status TEXT)'
          ).then((value) {
            print('table created');
          }).catchError((error){
            print('error when create data base ${ error.toString()}');
          });


        },
        onOpen: (database){
          print('data base is opened');
          GetDataFromDataBase(database);

        }

    );

  }


  void InsertToDataBase({
    required String task,
    required String time,
    required String date
  })async{
    await database!.transaction((txn) async{
      await txn.rawInsert(
          'INSERT INTO aya(task,time,date,status)VALUES("${task}","${time}","${date}","new")'
      ).then((value) => {
        print('${value} Row is inserted Succss'),
        emit(InsertToDataBaseState()),
        GetDataFromDataBase(database!)
      }).catchError((error){
        emit(InsertToDataBaseStateError());
        print('there is an error when insert Data ${error.toString()}');
      });

    });

  }


  void GetDataFromDataBase(Database database)async{
    await database.rawQuery('SELECT * FROM aya').then((value)
    {
      tabelTaskData=[];
       tabelDoneData=[];
      tabelArchiveData=[];
      value.forEach((element) {
        if(element['status']=='new'){
          tabelTaskData.add(element);

        }
        else if(element['status']=='done'){
          tabelDoneData.add(element);
        }
        else
          tabelArchiveData.add(element);
      });
      emit(GetDataFromDataBaseState());
    }).catchError((error){
      emit(GetDataFromDataBaseStateError());
    });


  }


  void UpdateDataFromDataBase(String status,int id)async{
    await database?.rawUpdate(
        'UPDATE aya SET status = ? WHERE id = ?',
        ['${status}',id]).then((value) {
          emit(UpdataToDataBaseStateSuccess());
          GetDataFromDataBase(database!);

    }).catchError((error){
      emit(UpdataToDataBaseStateError());

    });

  }


  void DeleteFromDataBase({
    required int id
})async{
    await database!.rawDelete('DELETE FROM aya WHERE id = ?', [id]).then((value) =>{
      GetDataFromDataBase(database!),
      emit(DeleteFromDataBaseStateSuccess()),
    }).catchError((error){
      emit(DeleteFromDataBaseStateError());
    });

  }


  void ChangeThemeMode({bool ?fromshared}){
    if(fromshared!=null)
      isDark=fromshared;
      else
    isDark=!isDark;
    CasheHelper.saveData(key: 'isDarkk', value: isDark).then((value) {
      emit(ChangeThemeModeSuccess());

    });

  }


}