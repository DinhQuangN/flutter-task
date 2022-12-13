import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:task_app/comtroller/task_controller.dart';
import 'package:task_app/utils/extension.dart';

class DoingList extends StatelessWidget {
  TaskController controller = Get.put(TaskController());
  DoingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.doingTodos.isEmpty && controller.doneTodos.isEmpty
          ? Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0.wp),
                  child: Container(
                    width: 65.0.wp,
                    height: 65.0.wp,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/note-taking.png'),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Add Task',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16.0.sp),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            )
          : ListView(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              children: [
                ...controller.doingTodos
                    .map(
                      (element) => Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 3.0.wp, horizontal: 9.0.wp),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: Checkbox(
                                fillColor: MaterialStateProperty.resolveWith(
                                    (states) => Colors.grey),
                                value: element.doneItem != 0 ? true : false,
                                onChanged: (val) {
                                  controller.doneTodo();
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                              child: Text(
                                element.titleItem,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ],
            ),
    );
  }
}
