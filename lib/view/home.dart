import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../controlller/todo_controller.dart';

class TodoHomeScreen extends StatelessWidget {
  const TodoHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TodoController todoController = Get.put(TodoController());
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              TableCalendar(
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Color(0xff30384c),
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xff30384c)),
                  ),
                  defaultDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  weekendDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  outsideDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                ),
                startingDayOfWeek: StartingDayOfWeek.monday,
                daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    weekendStyle: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold)),
                focusedDay: DateTime.now(),
                firstDay: DateTime.utc(2024, 7, 1),
                lastDay: DateTime.utc(2024, 7, 31),
                headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleTextStyle: TextStyle(
                        color: Color(0xff30384c),
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.only(top: 50, left: 20, right: 20),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.55,
                decoration: BoxDecoration(
                    color: Color(0xff2A3043),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        topLeft: Radius.circular(50))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Today",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Obx(
                        () => (todoController.todoData.isEmpty)
                            ? Container(
                                height: 300,
                                alignment: Alignment.center,
                                child: Text(
                                  "No tasks available",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              )
                            : Obx(
                                () => ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: todoController.todoData.length,
                                    itemBuilder: (context, index) {
                                      // if (index < 0 ||
                                      //     index >= todoController.todoData.length) {
                                      //   return Container(
                                      //     height: 50,
                                      //     width: 100,
                                      //     color: Colors.yellow,
                                      //   ); // Return empty container if index is invalid
                                      // }

                                      return Dismissible(
                                        direction: DismissDirection.startToEnd,
                                        key: UniqueKey(),
                                        onDismissed: (direction) {
                                          todoController.deleteTask(
                                              todoController.todoData[index]
                                                  ['id']);
                                          print(todoController.todoData.length);
                                        },
                                        child: GestureDetector(
                                          onLongPress: () {
                                            print("long pressed");
                                            todoController.taskController.text =
                                                todoController.todoData[index]
                                                    ['taskName'];
                                            todoController.descriptionController
                                                    .text =
                                                todoController.todoData[index]
                                                    ['note'];
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text('Add Task'),
                                                  content: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      TextField(
                                                        controller:
                                                            todoController
                                                                .taskController,
                                                        decoration:
                                                            InputDecoration(
                                                          labelText: 'Task',
                                                        ),
                                                      ),
                                                      TextField(
                                                        controller: todoController
                                                            .descriptionController,
                                                        decoration:
                                                            InputDecoration(
                                                          labelText:
                                                              'Description',
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      child: Text('Cancel'),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                        todoController
                                                            .taskController
                                                            .clear();

                                                        todoController
                                                            .descriptionController
                                                            .clear();
                                                      },
                                                    ),
                                                    TextButton(
                                                      child: Text('update'),
                                                      onPressed: () {
                                                        if (todoController
                                                            .taskController
                                                            .text
                                                            .isNotEmpty) {
                                                          todoController
                                                              .updateTask({
                                                            'id': todoController
                                                                    .todoData[
                                                                index]['id'],
                                                            'taskName':
                                                                todoController
                                                                    .taskController
                                                                    .text,
                                                            'isDone': 0,
                                                            'note': (todoController
                                                                    .descriptionController
                                                                    .text
                                                                    .isEmpty
                                                                ? "This task has no description"
                                                                : todoController
                                                                    .descriptionController
                                                                    .text),
                                                            'priority': "Low"
                                                          });
                                                          Navigator.of(context)
                                                              .pop();
                                                          todoController
                                                              .taskController
                                                              .clear();
                                                          todoController
                                                              .descriptionController
                                                              .clear();
                                                        }
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                top: 10, bottom: 10),

                                            // color: Colors.yellow,
                                            child: Row(
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Checkbox(
                                                      activeColor: Colors.green,
                                                      shape: CircleBorder(),
                                                      value: (todoController
                                                                          .todoData[
                                                                      index]
                                                                  ['isDone'] ==
                                                              1)
                                                          ? true
                                                          : false,
                                                      onChanged: (value) {
                                                        todoController
                                                            .updateTaskCompletion(
                                                                value!, index);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      todoController
                                                              .todoData[index]
                                                          ['taskName'],
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      todoController
                                                              .todoData[index]
                                                          ['note'],
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 15),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          todoController.taskController.clear();
          todoController.descriptionController.clear();
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Add Task'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: todoController.taskController,
                      decoration: InputDecoration(
                        labelText: 'Task',
                      ),
                    ),
                    TextField(
                      controller: todoController.descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Description',
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      todoController.taskController.clear();
                      todoController.descriptionController.clear();
                    },
                  ),
                  TextButton(
                    child: Text('Add'),
                    onPressed: () {
                      if (todoController.taskController.text.isNotEmpty) {
                        todoController.sqlAddTask({
                          'taskName': todoController.taskController.text,
                          'isDone': 0,
                          'note':
                              (todoController.descriptionController.text.isEmpty
                                  ? "This task has no description"
                                  : todoController.descriptionController.text),
                          'priority': "Low"
                        });
                      }
                      Get.back();
                      print(todoController.todoData);
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
