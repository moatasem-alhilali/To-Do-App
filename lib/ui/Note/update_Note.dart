import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo/controllers/note_controler.dart';
import 'package:todo/models/note.dart';
import 'package:todo/ui/theme.dart';
import 'package:todo/ui/widgets/input_field.dart';
import '../theme.dart';
import 'note_detail_page.dart';

class EditNotePage extends StatefulWidget {
  final int id;

  EditNotePage({super.key, required this.id});

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  final NoteController controller = Get.find();

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  initState() {
    super.initState();
    titleController.text = controller.notesList[widget.id].title!;
    contentController.text = controller.notesList[widget.id].note!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        backgroundColor: context.theme.backgroundColor,
        centerTitle: true,
        title: Text(
          'تعديل الملاحضة',
          style: titleStyle.copyWith(
              color: Get.isDarkMode ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.save,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
          onPressed: () {
            controller
                .updateNote(
              note: Note(
                note: contentController.text,
                id: controller.notesList[widget.id].id!,
                dateTimeCreated: controller.notesList[widget.id].dateTimeCreated!,
                dateTimeEdit: DateFormat('MMM dd, yyyy HH:mm:ss').format(DateTime.now()),
                title: titleController.text,
              ),
            )
                .then((value) {
              controller.readNotes();
              Navigator.pop(context);
            });
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.cancel_outlined,
              color: Get.isDarkMode ? Colors.white : Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: GetBuilder<NoteController>(
        init: controller,
        builder: (controller) => SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(
              top: 15,
              left: 15,
              right: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InputField(
                  hint: 'ادخل العنوان',
                  title: 'العنوان',
                  controller: titleController,
                ),
                InputField(
                  hint: 'ادخل الملاحضة',
                  title: 'التفاصيل',
                  controller: contentController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
