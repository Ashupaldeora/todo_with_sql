import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_with_sql/sql_helper/sql_service.dart';

class TodoController extends GetxController {
  SqlServices services = SqlServices();
  RxList todoData = [].obs;
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  TextEditingController taskController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  TodoController() {
    services.database;
    loadData();
  }

  Future<void> updateTaskCompletion(bool value, int index) async {
    await services.updateTask(todoData[index]['id'], {'isDone': value ? 1 : 0});
    loadData();
    todoData.refresh();
  }

  Future<void> sqlAddTask(Map task) async {
    await services.insertTask(task);
    await loadData();
    todoData.refresh();
  }

  Future<void> loadData() async {
    todoData.value = await services.fetchData();
  }

  Future<void> updateTask(Map<String, dynamic> task) async {
    await services.updateTask(task['id'], task);
    loadData();
  }

  Future<void> deleteTask(int id) async {
    await services.deleteTask(
      id,
    );
    loadData();
  }
}
