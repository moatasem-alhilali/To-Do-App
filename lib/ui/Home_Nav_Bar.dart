import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:todo/controllers/note_controler.dart';
import 'package:todo/controllers/task_controller.dart';
import 'package:todo/services/notification_services.dart';
import 'package:todo/ui/Note/add_Note.dart';
import 'package:todo/ui/Note/home_page.dart';
import 'package:todo/ui/Tasks/add_task_page.dart';
import 'package:todo/ui/settings_screen.dart';
import 'package:todo/ui/theme.dart';

import 'Tasks/screen_to_do.dart';

class HomeNavBar extends StatefulWidget {
  HomeNavBar({Key? key}) : super(key: key);

  @override
  State<HomeNavBar> createState() => _HomeNavBarState();
}

class _HomeNavBarState extends State<HomeNavBar> {
  final NoteController notesController = Get.put(NoteController());
  final TaskController taskController = Get.put(TaskController());

  List<Widget> screens = [
    const ScreenNote(),
    const ScreenToDo(),
    const SettingsScreen(),
  ];

  int currentIndex = 0;
  int? counterTasks;
  int? counterNote;
  late NotifyHelper notifyHelper;

  @override
  void initState() {
    super.initState();
    // initializeDateFormatting('en_US', '');
    // print("initState");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //print("WidgetsBinding");
    });
    SchedulerBinding.instance.addPostFrameCallback((_) {
      //  print("SchedulerBinding");
    });
    notifyHelper = NotifyHelper();
    taskController.readTasks();
    notifyHelper.initializeNotification();
    // TODO: implement initState
    super.initState();

    notesController.readNotes();
  }

  void changePage(int? index) {
    setState(() {
      currentIndex = index!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: currentIndex == 2
          ? null
          : FloatingActionButton(
              onPressed: () async {
                if (currentIndex == 0) {
                  Get.to(() => AddNewNotePage());
                } else if (currentIndex == 1) {
                  await Get.to(const AddTaskPage());
                } else {}
              },
              child: Icon(
                Icons.add_outlined,
                size: 50,
                color: Get.isDarkMode ? Colors.white : Colors.white,
              ),
              backgroundColor: primaryClr,
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      bottomNavigationBar: BubbleBottomBar(
        backgroundColor: Get.isDarkMode ? Colors.grey[800] : Colors.white,
        hasNotch: true,
        fabLocation: BubbleBottomBarFabLocation.end,
        opacity: .2,
        currentIndex: currentIndex,
        onTap: changePage,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(16),
        ),
        elevation: 8,
        tilesPadding: const EdgeInsets.symmetric(
          vertical: 8.0,
        ),
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
            showBadge: true,
            badge: Text(
              '${notesController.notesList.length}',
              style: const TextStyle(color: Colors.white),
            ),
            badgeColor:
                Get.isDarkMode ? Colors.purple : Colors.deepPurpleAccent,
            backgroundColor: Get.isDarkMode ? Colors.white : Colors.red,
            icon: Icon(
              Icons.dashboard,
              color: Get.isDarkMode ? Colors.white : Colors.black,
            ),
            activeIcon: Icon(
              Icons.dashboard,
              color: Get.isDarkMode ? Colors.white : Colors.black,
            ),
            title: const Text(
              'الملاحضات',
              style: TextStyle(
                  fontFamily: 'Tajawal',
                  // color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          BubbleBottomBarItem(
            backgroundColor: Get.isDarkMode ? Colors.white : Colors.red,
            icon: Icon(
              Icons.task_alt_sharp,
              color: Get.isDarkMode ? Colors.white : Colors.black,
            ),
            badgeColor:
                Get.isDarkMode ? Colors.deepOrange : Colors.deepPurpleAccent,
            showBadge: true,
            badge: Text(
              '${taskController.tasksList.length}',
              style: TextStyle(color: Colors.white),
            ),
            activeIcon: Icon(
              Icons.access_time,
              color: Get.isDarkMode ? Colors.white : Colors.black,
            ),
            title: const Text(
              'المهام',
              style: TextStyle(
                  fontFamily: 'Tajawal',
                  // color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          BubbleBottomBarItem(
            backgroundColor: Get.isDarkMode ? Colors.white : Colors.purple,
            icon: Icon(
              Icons.settings_applications_outlined,
              color: Get.isDarkMode ? Colors.white : Colors.black,
            ),
            activeIcon: Icon(
              Icons.settings,
              color: Get.isDarkMode ? Colors.white : Colors.purple,
            ),
            title: const Text(
              'الاعدادات',
              style: TextStyle(
                  fontFamily: 'Tajawal',
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: screens[currentIndex],
    );
  }
}
