import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:task_app/comtroller/task_controller.dart';
import 'package:task_app/utils/extension.dart';

class AddDialog extends StatelessWidget {
  TaskController controller = Get.put(TaskController());
  AddDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(3.0.wp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                      controller.editingController.clear();
                      controller.changeTask(null);
                    },
                    icon: Icon(Icons.close),
                  ),
                  TextButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if (controller.task.value == null) {
                          controller.showSnackBar(
                              'Error', 'Please select task type', Colors.red);
                        } else {
                          Map<String, dynamic> data = {
                            'titleItem': controller.editingController.text,
                            'listTaskId': controller.task.value!.id,
                            'doneItem': false
                          };
                          controller.createItemTask(data);
                          Get.back();
                        }
                      }
                    },
                    child: Text(
                      'Done',
                      style: TextStyle(fontSize: 14.0.sp),
                    ),
                    style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
              child: Text(
                'New Task',
                style:
                    TextStyle(fontSize: 20.0.sp, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
              child: TextFormField(
                controller: controller.editingController,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400]!),
                  ),
                ),
                autofocus: true,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter your todo item';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 5.0.wp, left: 5.0.wp, right: 5.0.wp, bottom: 2.0.wp),
              child: Text(
                'Add To',
                style: TextStyle(fontSize: 14.0.sp, color: Colors.grey),
              ),
            ),
            ...controller.listTasks
                .map(
                  (e) => Obx(
                    () => InkWell(
                      onTap: () => controller.changeTask(e),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 3.0.wp, horizontal: 5.0.wp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  IconData(
                                    int.parse(e.iconTask),
                                    fontFamily: 'MaterialIcons',
                                  ),
                                  color: HexColor.fromHex(e.colorTask),
                                ),
                                SizedBox(
                                  width: 3.0.wp,
                                ),
                                Text(
                                  e.titleTask,
                                  style: TextStyle(
                                    fontSize: 12.0.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            if (controller.task.value == e)
                              Icon(
                                Icons.check,
                                color: Colors.blue,
                              )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}
