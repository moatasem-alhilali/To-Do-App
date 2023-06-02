import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/constant.dart';
import 'package:todo/controllers/note_controler.dart';
import 'package:todo/services/theme_services.dart';
import 'package:todo/ui/Home_Nav_Bar.dart';
import 'package:todo/ui/Note/note_detail_page.dart';
import 'package:todo/ui/Note/searchbar.dart';
import 'package:todo/ui/Note/update_Note.dart';
import 'package:todo/ui/size_config.dart';
import 'package:todo/ui/theme.dart';
import 'package:todo/ui/widgets/Notes_Tile.dart';
import 'package:todo/ui/widgets/button.dart';

import 'alarm_dialog.dart';

class ScreenNote extends StatefulWidget {
  const ScreenNote({Key? key}) : super(key: key);

  @override
  State<ScreenNote> createState() => _ScreenToDoState();
}

class _ScreenToDoState extends State<ScreenNote> {
  DateTime selectedDateTime = DateTime.now();
  final NoteController notesController = Get.put(NoteController());

  @override
  void initState() {
    super.initState();
    notesController.readNotes();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        backgroundColor: context.theme.backgroundColor,
        elevation: 0,
        actions: [
          Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 15, right: 8, bottom: 8),
            child: CircleAvatar(
              radius: 18,
              backgroundImage: female
                  ? const AssetImage('assets/profile/profileWomen.png')
                  : const AssetImage('assets/profile/profileMan.png'),
            ),
          ),
        ],
        title: IconButton(
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
        leading: IconButton(
          onPressed: () {
            showSearch(
              context: context,
              delegate: SearchBar(),
            );
          },
          icon: Icon(
            Icons.search,
            color: Get.isDarkMode ? Colors.white : Colors.black,
            size: 30,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          addTaskBar(),
          Text(
            'الملاحظات',
            style: titleStyle.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 10,
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
          MyButton(onTap: () async {}, lable: ' حذف الكل'),
          Container(
            height: 5,
            color: Colors.red,
          ),
          Text(
            DateFormat.yMMMMd().format(
              DateTime.now(),
            ),
            style: subHeadingStyle,
          ),
        ],
      ),
    );
  }

  Future<void> onRefresh() async {
    notesController.readNotes();
  }

  showTasks() {
    return Expanded(
      flex: 1,
      child: AnimationLimiter(
        child: Obx(
          () => notesController.isEmpty()
              ? noTasks()
              : RefreshIndicator(
                  onRefresh: onRefresh,
                  child: ListView.builder(
                    scrollDirection:
                        SizeConfig.orientation == Orientation.landscape
                            ? Axis.horizontal
                            : Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      var notes = notesController.notesList[index];
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 800),
                        child: SlideAnimation(
                          horizontalOffset: 200,
                          child: FadeInAnimation(
                            child: GestureDetector(
                              onTap: () {},
                              child: FocusedMenuHolder(
                                menuWidth:
                                    MediaQuery.of(context).size.width * 0.50,
                                blurSize: 5.0,
                                menuItemExtent: 45,
                                menuBoxDecoration: const BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15.0))),
                                duration: const Duration(milliseconds: 100),
                                animateMenuItems: true,
                                blurBackgroundColor: Colors.black54,
                                openWithTap: true,
                                menuOffset: 10.0,
                                bottomOffsetHeight: 80.0,
                                menuItems: <FocusedMenuItem>[
                                  FocusedMenuItem(
                                      title: Text(
                                        "قرائه",
                                        style: titleStyle.copyWith(
                                            color: Colors.black),
                                      ),
                                      trailingIcon: const Icon(
                                          Icons.mark_chat_unread_rounded),
                                      onPressed: () {
                                        Get.to(
                                          NoteDetailPage(i: index),
                                        );
                                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>()));
                                      }),
                                  FocusedMenuItem(
                                      title: Text(
                                        'تعديل',
                                        style: titleStyle.copyWith(
                                            color: Colors.black),
                                      ),
                                      trailingIcon:
                                          const Icon(Icons.favorite_border),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => EditNotePage(
                                              id: index,
                                            ),
                                          ),
                                        );
                                      }),
                                  FocusedMenuItem(
                                      title: Text(
                                        'مشاركة',
                                        style: titleStyle.copyWith(
                                            color: Colors.black),
                                      ),
                                      trailingIcon: const Icon(Icons.share),
                                      onPressed: () {
                                        notesController.shareNote(
                                          notesController
                                              .notesList[index].title!,
                                          notesController
                                              .notesList[index].note!,
                                        );
                                      }),
                                  FocusedMenuItem(
                                      title: Text(
                                        'حذف',
                                        style: titleStyle.copyWith(
                                            color: Colors.red),
                                      ),
                                      trailingIcon: const Icon(
                                        Icons.delete,
                                        color: Colors.redAccent,
                                      ),
                                      onPressed: () async {
                                        notesController.deleteNote(
                                            notesController
                                                .notesList[index].id!);
                                        Get.offAll(HomeNavBar());
                                      }),
                                ],
                                onPressed: () {},
                                child: NotesTile(notes),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: notesController.notesList.length,
                  ),
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
