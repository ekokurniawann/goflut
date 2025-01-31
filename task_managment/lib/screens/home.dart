import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/controllers/data_controller.dart';
import 'package:task_management/screens/add_task_screen.dart';
import 'package:task_management/screens/view_all_task_screen.dart';
import 'package:task_management/utils/app_colors.dart';
import 'package:task_management/widgets/button_widget.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late AnimationController controller;

  late Animation<double> fadeOutAnimation;

  @override
  void initState() {
    Get.lazyPut(() => DataController());
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this)
      ..forward();
    fadeOutAnimation =
        CurvedAnimation(parent: controller, curve: Curves.easeInCirc);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/welcome.jpg"),
            ),
          ),
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeTransition(
                opacity: fadeOutAnimation,
                child: RichText(
                  text: const TextSpan(
                    text: "Hello",
                    style: TextStyle(
                      color: AppColors.mainColor,
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: "\nstart your Beautiful day",
                        style: TextStyle(
                          color: AppColors.smallTextColor,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 2.5,
              ),
              FadeTransition(
                opacity: fadeOutAnimation,
                child: InkWell(
                  onTap: () => Get.to(
                    () => AddTaskScreen(),
                    transition: Transition.fadeIn,
                    duration: const Duration(
                      milliseconds: 500,
                    ),
                  ),
                  child: const ButtonWidget(
                    backgroundColor: AppColors.mainColor,
                    text: "Add Task",
                    textColor: AppColors.textHolder,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 40,
              ),
              InkWell(
                onTap: () => Get.to(
                  () => ViewTaskScreen(),
                  transition: Transition.rightToLeft,
                  duration: const Duration(
                    milliseconds: 500,
                  ),
                ),
                child: const ButtonWidget(
                  backgroundColor: AppColors.textHolder,
                  text: "View All",
                  textColor: AppColors.smallTextColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
