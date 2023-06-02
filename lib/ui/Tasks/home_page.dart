import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/controllers/task_controller.dart';
import 'package:todo/models/task.dart';
import 'package:todo/services/notification_services.dart';
import 'package:todo/services/theme_services.dart';
import 'package:todo/ui/size_config.dart';
import 'package:todo/ui/theme.dart';
import 'package:todo/ui/widgets/button.dart';
import 'package:todo/ui/widgets/task_tile.dart';

import 'add_task_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late NotifyHelper notifyHelper;

  DateTime selectedDateTime = DateTime.now();
  final TaskController taskController = Get.put(TaskController());

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('en_US', null);
    // print("initState");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //print("WidgetsBinding");
    });
    SchedulerBinding.instance.addPostFrameCallback((_) {
      //  print("SchedulerBinding");
    });
    notifyHelper = NotifyHelper();
    onRefresh();
    taskController.readTasks();
    notifyHelper.initializeNotification();
    // taskController.readTasks();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      // bottomNavigationBar:GNav(
      //   //  rippleColor: Colors.grey![800], // tab button ripple color when pressed
      //    // hoverColor: Colors.grey![700], // tab button hover color
      //     haptic: true, // haptic feedback
      //     tabBorderRadius: 15,
      //     tabActiveBorder: Border.all(color: Colors.black, width: 1), // tab button border
      //     tabBorder: Border.all(color: Colors.grey, width: 1), // tab button border
      //     tabShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)], // tab button shadow
      //     curve: Curves.easeOutExpo, // tab animation curves
      //     duration: const Duration(milliseconds: 900), // tab animation duration
      //     gap: 8, // the tab button gap between icon and text
      //     color: Colors.grey[800], // unselected icon color
      //     activeColor: Colors.purple, // selected icon and text color
      //     iconSize: 24, // tab button icon size
      //     tabBackgroundColor: Colors.purple.withOpacity(0.1), // selected tab background color
      //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5), // navigation bar padding
      //     tabs: const [
      //       GButton(
      //         icon: Icons.today_outlined,
      //         text: 'Home',
      //       ),
      //       GButton(
      //         icon: Icons.note_alt_outlined,
      //         text: 'Likes',
      //       ),
      //
      //     ],
      //
      // ),
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        backgroundColor: context.theme.backgroundColor,
        elevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.only(top: 10, left: 15, right: 8, bottom: 8),
            child: CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage(
                'images/person.jpeg',
              ),
            ),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            ThemeServices().switchTheme();
          },
          icon: Get.isDarkMode
              ? const Icon(
                  Icons.brightness_2,
                  size: 30,
                )
              : const Icon(
                  Icons.brightness_2_outlined,
                  color: Colors.black,
                  size: 30,
                ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          addTaskBar(),
          addDateBar(),
          const SizedBox(
            height: 20,
          ),
          showTasks(),
        ],
      ),
    );
  }

  addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 10, top: 14, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyButton(
              onTap: () async {
                await Get.to(const AddTaskPage());
                // ThemeServices().switchTheme();
              },
              lable: '+ أضف مهمة'),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                DateFormat.yMMMMd().format(
                  DateTime.now(),
                ),
                style: subHeadingStyle,
              ),
              Text(
                'Today',
                style: subTitleStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }

  addDateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 6, left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 70,
        initialSelectedDate: DateTime.now(),
        selectionColor: primaryClr,
        onDateChange: (newDataTime) {
          setState(() {
            selectedDateTime = newDataTime;
          });
        },
        selectedTextColor: Colors.white,
        dayTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontWeight: FontWeight.w600, fontSize: 20, color: Colors.grey),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontWeight: FontWeight.w600, fontSize: 16, color: Colors.grey),
        ),
        dateTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontWeight: FontWeight.w600, fontSize: 12, color: Colors.grey),
        ),
      ),
    );
  }

  Future<void> onRefresh() async {
    taskController.readTasks();
  }

  showTasks() {
    return Expanded(
      child: AnimationLimiter(
        child: Obx(() {
          if (taskController.tasksList.isNotEmpty) {
            return RefreshIndicator(
              onRefresh: onRefresh,
              child: ListView.builder(
                // scrollDirection:Axis.vertical,
                scrollDirection: SizeConfig.orientation == Orientation.landscape
                    ? Axis.horizontal
                    : Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  var tasks = taskController.tasksList[index];
                  DateTime date =
                      DateFormat.jm().parse(tasks.startTime.toString());
                  var myTime = DateFormat('HH:mm').format(date);
                  if (tasks.date == DateFormat.yMd().format(selectedDateTime) ||
                      tasks.repeat == 'يومي' ||
                      (tasks.repeat == 'اسبوعي' &&
                          selectedDateTime
                                      .difference(
                                          DateFormat.yMd().parse(tasks.date!))
                                      .inDays %
                                  7 ==
                              0) ||
                      (tasks.repeat == 'شهري' &&
                          DateFormat.yMd().parse(tasks.date!).day ==
                              selectedDateTime.day)) {
                    notifyHelper.scheduledNotification(
                        int.parse(myTime.toString().split(':')[0]),
                        int.parse(myTime.toString().split(':')[1]),
                        tasks);
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 800),
                      child: SlideAnimation(
                        horizontalOffset: 200,
                        child: FadeInAnimation(
                          child: GestureDetector(
                            onTap: () {
                              showBottomSheet(
                                context,
                                tasks,
                                index,
                              );
                            },
                            child: TaskTile(
                              tasks,
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: taskController.tasksList.length,
              ),
            );
          } else {
            return noTasks();
          }
        }),
      ),
    );
  }

  showBottomSheet(context, Task task, int index) {
    return Get.bottomSheet(
      SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 4),
              width: SizeConfig.screenWidth,
              height: (SizeConfig.orientation == Orientation.landscape)
                  ? (task.isCompleted == 1
                      ? SizeConfig.screenHeight * 0.6
                      : SizeConfig.screenHeight * 0.8)
                  : (task.isCompleted == 1
                      ? SizeConfig.screenHeight * 0.30
                      : SizeConfig.screenHeight * 0.39),
              color: Get.isDarkMode ? darkGreyClr : Colors.white,
              child: Column(
                children: [
                  Flexible(
                    child: Container(
                      height: 6,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Get.isDarkMode
                            ? Colors.grey[600]
                            : Colors.grey[600],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  if (task.isCompleted == 1)
                    Container()
                  else
                    buildBottomSheet(
                      onTap: () {
                        notifyHelper.cancelNotification(task);
                        taskController.updateTasks(
                            task: Task(id: task.id, isCompleted: 1));
                        Get.back();
                      },
                      lable: ' اكتملت المهمة',
                      clr: primaryClr,
                    ),
                  buildBottomSheet(
                    onTap: () {
                      notifyHelper.cancelNotification(task);
                      taskController.deleteTasks(task: task);
                      Get.back();
                    },
                    lable: 'حذف المهمة',
                    clr: Colors.red,
                  ),
                  Divider(
                    height: 2,
                    color: Get.isDarkMode ? Colors.grey : darkGreyClr,
                  ),
                  buildBottomSheet(
                    onTap: () {
                      Get.back();
                    },
                    lable: ' رجوع',
                    clr: primaryClr,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildBottomSheet({
    String? lable,
    Function()? onTap,
    bool isClosed = false,
    Color? clr,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 65,
        width: SizeConfig.screenWidth * 0.9,
        decoration: BoxDecoration(
          color: isClosed ? Colors.transparent : clr!,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 2,
            color: isClosed
                ? Get.isDarkMode
                    ? Colors.grey[600]!
                    : Colors.grey[300]!
                : clr!,
          ),
        ),
        child: Center(
          child: Text(
            lable!,
            style: isClosed
                ? titleStyle
                : titleStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  noTasks() {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(seconds: 2),
          child: RefreshIndicator(
            onRefresh: onRefresh,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Wrap(
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: SizeConfig.orientation == Orientation.landscape
                    ? Axis.horizontal
                    : Axis.vertical,
                children: [
                  SizeConfig.orientation == Orientation.landscape
                      ? const SizedBox(
                          height: 6,
                        )
                      : const SizedBox(
                          height: 70,
                        ),
                  Lottie.asset(
                    height: 300,
                    // width: double.infinity,
                    'images/noTasksTow.json',
                  ),
                  SizeConfig.orientation == Orientation.landscape
                      ? const SizedBox(
                          height: 6,
                        )
                      : const SizedBox(
                          height: 100,
                        ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
