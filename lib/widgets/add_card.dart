import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:task_app/comtroller/task_controller.dart';
import 'package:task_app/utils/colors.dart';
import 'package:task_app/utils/extension.dart';
import 'package:task_app/widgets/icons.dart';

class AddCard extends StatelessWidget {
  TaskController controller = Get.put(TaskController());
  final formKey = GlobalKey<FormState>();
  AddCard({super.key});

  @override
  Widget build(BuildContext context) {
    final icons = getIcons();
    var squareWidth = Get.width - 12.0.wp;
    return Container(
      width: squareWidth / 2,
      height: squareWidth / 2,
      margin: EdgeInsets.all(3.0.wp),
      child: InkWell(
        onTap: () async {
          await Get.defaultDialog(
            titlePadding: EdgeInsets.symmetric(vertical: 5.0.wp),
            radius: 5,
            title: 'Task Type',
            content: Form(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
                    child: TextFormField(
                      controller: controller.editingController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Title',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your task title';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.0.wp),
                    child: Wrap(
                      spacing: 2.0.wp,
                      children: icons
                          .map((e) => Obx(
                                () {
                                  final index = icons.indexOf(e);
                                  return ChoiceChip(
                                      selectedColor: Colors.grey[200],
                                      pressElevation: 0,
                                      backgroundColor: Colors.white,
                                      label: e,
                                      selected:
                                          controller.chipIndex.value == index,
                                      onSelected: (bool selected) {
                                        controller.chipIndex.value =
                                            selected ? index : 0;
                                      });
                                },
                              ))
                          .toList(),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        int icon =
                            icons[controller.chipIndex.value].icon!.codePoint;
                        String color =
                            icons[controller.chipIndex.value].color!.toHex();
                        Map<String, dynamic> data = {
                          'titleTask': controller.editingController.text,
                          'iconTask': icon,
                          'colorTask': color
                        };
                        controller.createListTask(data);
                        Get.back();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        primary: blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        minimumSize: const Size(150, 40)),
                    child: Text('Confirm'),
                  ),
                ],
              ),
              key: formKey,
            ),
          );
        },
        child: DottedBorder(
          child: Center(
            child: Icon(
              Icons.add,
              size: 10.0.wp,
              color: Colors.grey,
            ),
          ),
          color: Colors.grey[400]!,
          dashPattern: const [8, 4],
        ),
      ),
    );
  }
}
