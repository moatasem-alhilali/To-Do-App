import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:todo/controllers/task_controller.dart';
import 'package:todo/models/task.dart';
import 'package:todo/ui/theme.dart';
import 'package:todo/ui/widgets/button.dart';
import 'package:todo/ui/widgets/input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  TaskController controller = Get.put(TaskController());
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController noteEditingController = TextEditingController();
  DateTime selectedTime = DateTime.now();
  String startTime =
      DateFormat('hh:mm a', 'en').format(DateTime.now()).toString();

  // String endTime = DateFormat('hh:mm a').format(DateTime.now().add(const Duration(minutes: 15))).toString();
  String endTime = '00:00';
  int? selectedReminder = 5;
  List<int> reminedList = [5, 10, 15, 20];
  String selectedRepate = 'None';
  List<String> ListRebate = ['لاشيء', 'يومي', 'اسبوعي', 'شهري'];
  int selectedColors = 0;

  @override
  void initState() {
    super.initState();
    // initializeDateFormatting('en_US',null);
    // Intl.defaultLocale = 'pt_BR';
    // Localizations.maybeLocaleOf(context)?.toLanguageTag();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        backgroundColor: context.theme.backgroundColor,
        elevation: 0,
        actions: const [
          CircleAvatar(
            radius: 18,
            backgroundImage: AssetImage(
              'images/person.jpeg',
            ),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 22),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'اضافة المهمة مهمة جديدة',
                style: headingStyle,
              ),
              InputField(
                hint: 'ادخل العنوان',
                title: 'العنوان',
                controller: titleEditingController,
              ),
              InputField(
                hint: 'ادخل تفاصيل الملاحضة',
                title: 'ملاحظة',
                controller: noteEditingController,
              ),
              InputField(
                hint: DateFormat.yMd().format(selectedTime),
                title: 'التاريخ',
                widget: IconButton(
                  onPressed: () async {
                    await showSelectedData();
                  },
                  icon: const Icon(
                    Icons.calendar_today,
                    color: Colors.grey,
                  ),
                ),
              ),
              InputField(
                hint: startTime,
                title: 'وقت التذكير',
                widget: IconButton(
                  onPressed: () async {
                    await showSelectedTime();
                  },
                  icon: const Icon(
                    Icons.lock_clock,
                    color: Colors.grey,
                  ),
                ),
              ),
              InputField(
                hint: '$selectedReminder  دقاىق فقط',
                title: 'ذكرني',
                widget: DropdownButton(
                  underline: Container(
                    width: 0,
                    height: 0,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  dropdownColor: Colors.blueGrey,
                  items: reminedList
                      .map<DropdownMenuItem<String>>(
                        (int e) => DropdownMenuItem<String>(
                          value: e.toString(),
                          child: Text(
                            '$e',
                            style: titleStyle.copyWith(
                                color: Colors.white, fontSize: 14),
                          ),
                        ),
                      )
                      .toList(),
                  icon: const Icon(Icons.arrow_drop_down_sharp),
                  onChanged: (String? value) {
                    setState(() {
                      selectedReminder = int.parse(value!);
                    });
                  },
                ),
              ),
              InputField(
                hint: '$selectedRepate ',
                title: 'تكرار',
                widget: DropdownButton(
                  underline: Container(
                    width: 0,
                    height: 0,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  dropdownColor: Colors.blueGrey,
                  items: ListRebate.map<DropdownMenuItem<String>>(
                    (String e) => DropdownMenuItem<String>(
                      value: e,
                      child: Text(
                        e,
                        style: titleStyle.copyWith(
                            color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ).toList(),
                  icon: const Icon(Icons.arrow_drop_down_sharp),
                  onChanged: (String? value) {
                    setState(() {
                      selectedRepate = value!;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        "اللون",
                        style: titleStyle,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Wrap(
                        children: List.generate(
                          3,
                          (index) => Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedColors = index;
                                });
                              },
                              child: CircleAvatar(
                                child: selectedColors == index
                                    ? const Icon(
                                        Icons.done,
                                        color: Colors.white,
                                      )
                                    : null,
                                backgroundColor: index == 0
                                    ? primaryClr
                                    : index == 1
                                        ? pinkClr
                                        : orangeClr,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  MyButton(
                    onTap: () {
                      //controller.readTasks();
                      validate();
                    },
                    lable: 'أنشئ مهمة',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  validate() {
    if (titleEditingController.text.isNotEmpty &&
        noteEditingController.text.isNotEmpty) {
      addTasks();
      Get.back();
    } else {
      Get.snackbar(
        'خطأ',
        'يجب عليك ان تدخل كل الحقول',
        snackStyle: SnackStyle.GROUNDED,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        icon: const Icon(
          Icons.warning,
          color: Colors.redAccent,
        ),
        colorText: Colors.black,
      );
    }
  }

  addTasks() async {
    int value = await controller.addTasks(
      task: Task(
        title: titleEditingController.text,
        note: noteEditingController.text,
        date: DateFormat.yMd().format(selectedTime),
        endTime: endTime,
        startTime: startTime,
        isCompleted: 0,
        color: selectedColors,
        remind: selectedReminder,
        repeat: selectedRepate,
      ),
    );
    print('$value');
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

  showSelectedData() async {
    DateTime? timePiker = await showDatePicker(
        context: context,
        initialEntryMode: DatePickerEntryMode.calendar,
        initialDate: selectedTime,
        firstDate: DateTime(2000),
        lastDate: DateTime(2090));
    if (timePiker != null)
      setState(() {
        selectedTime = timePiker;
      });
    else
      print("error in datae");
  }

  showSelectedTime() {
    showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.dial,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
        child: Localizations.override(
          context: context,
          locale: const Locale('en', 'US'),
          child: child!,
        ),
      ),
    ).then((value) {
      //String timeOfDay = value!.format(context);
      setState(() {
        startTime = formatTimeOfDay(value!);
        //timeOfDay.replaceRange(4, end, replacement)
        //startTime = timeOfDay;
      });
    });
    //   showTimePicker(
    //     context: context,
    //     initialEntryMode: TimePickerEntryMode.input,
    //     initialTime: isTrue
    //         ? TimeOfDay.fromDateTime(DateTime.now())
    //         : TimeOfDay.fromDateTime(DateTime.now().add(const Duration(minutes: 15))),
    //   ).then((value) {
    //     String timeOfDay = value!.format(context);
    //
    //     if (isTrue) {
    //       setState(() {
    //         startTime = timeOfDay;
    //       });
    //     } else if (!isTrue) {
    //       setState(() {
    //        // endTime = resault;
    //       });
    //     }
    //   });
  }
}
