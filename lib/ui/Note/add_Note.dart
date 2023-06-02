import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/controllers/note_controler.dart';
import 'package:todo/ui/theme.dart';
import 'package:todo/ui/widgets/input_field.dart';

import '../Home_Nav_Bar.dart';

class AddNewNotePage extends StatelessWidget {
  DateTime selectedTime = DateTime.now();
  final NoteController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        backgroundColor: context.theme.backgroundColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
          onPressed: () {
            controller.clear().then((value) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeNavBar()));
            });
          },
        ),
        title: Text(
          'اضف ملاحضة',
          style: titleStyle.copyWith(
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
          ),
          child: Column(
            children: [
              InputField(
                hint: 'ادخل العنوان',
                title: 'العنوان',
                controller: controller.titleController,
              ),
              InputField(
                hint: 'ادخل الملاحضة',
                title: 'التفاصيل',
                controller: controller.contentController,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.addNote(context);

        },
        child: const Icon(
          Icons.save,
        ),
      ),
    );
  }
}
