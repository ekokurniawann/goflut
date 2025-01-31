import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/controllers/data_controller.dart';
import 'package:task_management/screens/home.dart';
import 'package:task_management/utils/app_colors.dart';
import 'package:task_management/widgets/button_widget.dart';
import 'package:task_management/widgets/popup_warning.dart';
import 'package:task_management/widgets/textField_widget.dart';

class EditTaskScreen extends StatefulWidget {
  final String task_details;
  final String task_name;
  final String id;
  EditTaskScreen(
      {Key? key,
      required this.task_name,
      required this.task_details,
      required this.id})
      : super(key: key);

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController detailController = TextEditingController();

  @override
  void initState() {
    nameController.text = widget.task_name;
    detailController.text = widget.task_details;
    super.initState();
  }

  bool _dataValidation() {
    if (nameController.text.trim().isEmpty) {
      PopupWarning.taskWarning("Task Name", "Task Name is Required.");
      return false;
    } else if (detailController.text.trim().isEmpty) {
      PopupWarning.taskWarning("Task Details", "Task Details is Required.");
      return false;
    } else if (detailController.text.length <= 20) {
      PopupWarning.taskWarning(
          "Task Details", "Task Details should be at least 20 characters.");
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/addtask1.jpg"),
          ),
        ),
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.smallTextColor,
                      size: 27,
                    ))
              ],
            ),
            Column(
              children: [
                TextFiledWidget(
                  textController: nameController,
                  hintText: "Task Name",
                  borderRadius: 30,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFiledWidget(
                  textController: detailController,
                  hintText: "Task Details",
                  borderRadius: 20,
                  maxLines: 4,
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    if (_dataValidation()) {
                      Get.find<DataController>().updateTask(
                          widget.id,
                          nameController.text.trim(),
                          detailController.text.trim());

                      PopupWarning.taskWarning(
                          "Done", "Task Updated Successful.",
                          color: Colors.green);

                      Get.offAll(
                        () => const Home(),
                        transition: Transition.fade,
                        duration: const Duration(
                          milliseconds: 500,
                        ),
                      );
                    }
                  },
                  child: const ButtonWidget(
                    backgroundColor: AppColors.mainColor,
                    text: "Edit",
                    textColor: Colors.white,
                  ),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 7,
            ),
          ],
        ),
      ),
    );
  }
}
