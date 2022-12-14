import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:task_app/comtroller/task_controller.dart';
import 'package:task_app/model/task_model.dart';
import 'package:task_app/router/index.dart';
import 'package:task_app/screens/report_screen.dart';
import 'package:task_app/utils/extension.dart';
import 'package:task_app/widgets/add_card.dart';
import 'package:task_app/widgets/task_card.dart';

class HomeScreen extends StatelessWidget {
  TaskController controller = Get.put(TaskController());
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          return await controller.getListTask();
        },
        child: Obx(
          () => controller.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : IndexedStack(
                  index: controller.tabIndex.value,
                  children: [
                    SafeArea(
                      child: ListView(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(4.0.wp),
                            child: Text(
                              'My List',
                              style: TextStyle(
                                  fontSize: 24.0.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          GridView.count(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            children: [
                              ...controller.listTasks
                                  .map(
                                    (e) => LongPressDraggable(
                                      data: e,
                                      onDragStarted: () =>
                                          controller.changeDeleting(true),
                                      onDraggableCanceled: (_, __) =>
                                          controller.changeDeleting(false),
                                      onDragEnd: (_) =>
                                          controller.changeDeleting(false),
                                      child: TaskCard(task: e),
                                      feedback: Opacity(
                                        opacity: 0.8,
                                        child: TaskCard(task: e),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              AddCard(),
                            ],
                          )
                        ],
                      ),
                    ),
                    ReportPage(),
                  ],
                ),
        ),
      ),
      floatingActionButton: DragTarget(
        builder: (_, __, ___) {
          return Obx(
            () => FloatingActionButton(
              onPressed: () {
                if (controller.listTasks.isNotEmpty) {
                  Get.toNamed(RouteHelper.getAddDialog());
                } else {
                  controller.showSnackBar('Error',
                      'Please create your task type', Colors.red[500]!);
                }
              },
              backgroundColor:
                  controller.deleting.value ? Colors.red : Colors.blue,
              child: Icon(controller.deleting.value ? Icons.delete : Icons.add),
            ),
          );
        },
        onAccept: (Task task) {
          controller.deleteListTask(task, task.id.toString());
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Obx(
          () => BottomNavigationBar(
            onTap: (int index) => controller.changeTabIndex(index),
            currentIndex: controller.tabIndex.value,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(right: 15.0.wp),
                    child: Icon(Icons.apps),
                  ),
                  label: 'Home,'),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(left: 15.0.wp),
                  child: Icon(Icons.data_usage),
                ),
                label: 'Report',
              )
            ],
          ),
        ),
      ),
    );
  }
}
