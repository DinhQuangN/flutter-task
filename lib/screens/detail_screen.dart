import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:task_app/comtroller/task_controller.dart';
import 'package:task_app/utils/extension.dart';

class DetailPage extends StatelessWidget {
  TaskController controller = Get.put(TaskController());
  DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    var task = controller.task.value!;
    var color = HexColor.fromHex(task.colorTask);
    var formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(3.0.wp),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                      controller.changeTask(null);
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0.wp),
              child: Row(
                children: [
                  Icon(
                    IconData(int.parse(task.iconTask),
                        fontFamily: 'MaterialIcons'),
                    color: color,
                  ),
                  SizedBox(
                    width: 3.0.wp,
                  ),
                  Text(
                    task.titleTask,
                    style: TextStyle(
                        fontSize: 12.0.sp, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Obx(
              () {
                var totalTodos =
                    controller.doingTodos.length + controller.doneTodos.length;
                return Padding(
                  padding: EdgeInsets.only(
                    left: 16.0.wp,
                    top: 3.0.wp,
                    right: 16.0.wp,
                  ),
                  child: Row(
                    children: [
                      Text(
                        '$totalTodos Tasks',
                        style: TextStyle(
                          fontSize: 12.0.sp,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        width: 3.0.wp,
                      ),
                      Expanded(
                        child: StepProgressIndicator(
                          totalSteps: totalTodos == 0 ? 1 : totalTodos,
                          currentStep: controller.doneTodos.length,
                          size: 5,
                          padding: 0,
                          selectedGradientColor: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [color, color.withOpacity(0.5)],
                          ),
                          unselectedGradientColor: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.grey[300]!, Colors.grey[300]!],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: 2.0.wp, horizontal: 5.0.wp),
              child: TextFormField(
                controller: controller.editingController,
                autofocus: true,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.check_box_outline_blank,
                    color: Colors.grey[400]!,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        var success = controller.addItemTodo(
                            controller.editingController.text, task.id);
                        print(success);
                        // if (success == true) {
                        //   controller.showSnackBar(
                        //       'Success', 'Todo item add success', Colors.green);
                        // } else {
                        //   controller.showSnackBar(
                        //       'Error ', 'Todo item already exist ', Colors.red);
                        // }
                      }
                    },
                    icon: Icon(Icons.done),
                  ),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter your todo item';
                  }
                  return null;
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
