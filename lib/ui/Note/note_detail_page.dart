import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:string_stats/string_stats.dart';
import 'package:todo/controllers/note_controler.dart';
import 'package:todo/models/note.dart';
import 'package:todo/ui/size_config.dart';
import 'package:todo/ui/theme.dart';

class NoteDetailPage extends StatelessWidget {
  final int i;

  NoteDetailPage({super.key, required this.i});

  final NoteController controller = Get.find();
  Note? note;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    String wordsCount = controller.notesList[i].note!;
    String charsCount = controller.notesList[i].note!;
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: context.theme.backgroundColor,

      ),
      body: GetBuilder<NoteController>(
        builder: (_) => Scrollbar(
          child: GestureDetector(
            onTap: () {
              showBottomSheet(context, i, wordsCount, charsCount);
            },
            child: Container(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(
                            SizeConfig.orientation == Orientation.landscape
                                ? 8
                                : 10),
                      ),
                      width: SizeConfig.orientation == Orientation.landscape
                          ? SizeConfig.screenWidth / 2
                          : SizeConfig.screenWidth,
                      margin: EdgeInsets.only(
                        bottom: getProportionateScreenHeight(8),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          color: primaryClr,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.notesList[i].title!,
                                      style: titleStyle.copyWith(
                                          color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'اخر تعديل : ' +
                                          controller.notesList[i].dateTimeEdit!,
                                      style: titleStyle.copyWith(
                                          color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      controller.notesList[i].note!,
                                      style: titleStyle.copyWith(
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                                physics: const BouncingScrollPhysics(),
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              color: Colors.grey[200]!.withOpacity(0.7),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  showBottomSheet(context, int index, String charsCount, String wordsCount) {
    return Get.bottomSheet(
      SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 4),
              width: SizeConfig.screenWidth,
              height: 90,
              color: Get.isDarkMode ? darkGreyClr : Colors.white,
              child: Column(
                children: [
                  Flexible(
                    child: Container(
                      height: 8,
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
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'عدد الكلمات : ${wordCount(wordsCount)} ',
                        style: titleStyle.copyWith(
                          color: Get.isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        'عدد الحروف : ${charCount(charsCount)}',
                        style: titleStyle.copyWith(
                          color: Get.isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    'انشأتها :  ' + controller.notesList[i].dateTimeCreated!,
                    style: titleStyle.copyWith(
                      color: Get.isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 30, right: 30),
                  //   child: Divider(
                  //     height: 2,
                  //     color: Get.isDarkMode ? Colors.grey : darkGreyClr,
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 8,
                  // ),
                  // buildBottomSheet(),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: MyButton(
          //       onTap: () {
          //         controller.deleteNote(controller.notesList[i].id!);
          //         Get.offAll(HomeNavBar());
          //       },
          //       lable: 'حذف الملاحضة'),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: MyButton(
          //       onTap: () {
          //         controller.shareNote(
          //           controller.notesList[i].title!,
          //           controller.notesList[i].note!,
          //         );
          //       },
          //       lable: 'مشاركة'),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: MyButton(
          //       onTap: () {
          //         Get.back();
          //       },
          //       lable: 'رجوع'),
          // ),
        ],
      ),
    );
  }
}
