import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/db/db_helper.dart';
import 'package:todo/models/task.dart';

class TaskController extends GetxController {
  final RxList<Task> tasksList = <Task>[].obs;

 static TextDirection? textDirection=TextDirection.ltr.obs as TextDirection?;

  addTasks({Task? task}) async {
    return DBHelper.insert(task!).then((value) {
      readTasks();
    });
  }

  Future<void> readTasks() async {
    return await DBHelper.query().then((value) {
      tasksList.assignAll(value.map((e) => Task.fromJson(e)).toList());
      //debugPrint(tasksList);
    });
  }

  void deleteTasks({Task? task}) async {
    DBHelper.delete(task!).then((value) {
      readTasks();
    });
  }

  void deleteAllNotes() async {
    await DBHelper.deleteAllNotes().then((value) {
      readTasks();
    });
  }

  void updateTasks({required Task task}) async {
    DBHelper.update(task).then((value) {
      readTasks();
    });
  }

  Locale? locale;

//
// Future<void> getSavedLanguage() async {
//   // final String cachedLanguageCode = await CashHelper().getCachedLanguageCode();
//   CashHelper().getCachedLanguageCode().then((value) {
//     locale = Locale(value.toString());
//     // emit(ChangeLanState());
//   });
// }
//
// void changeLanguage(String languageCode) {
//   CashHelper().cacheLanguageCode(languageCode).then((value) {
//     locale = Locale(languageCode);
//     // emit(ChangeLanState());
//   });
//
//   // emit(ChangeLocaleState(locale: Locale(languageCode)));
// }

}
