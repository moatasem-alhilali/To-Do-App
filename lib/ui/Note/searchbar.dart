import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:todo/controllers/note_controler.dart';
import 'package:todo/ui/size_config.dart';
import 'package:todo/ui/widgets/Notes_Tile.dart';

import 'note_detail_page.dart';

class SearchBar extends SearchDelegate {
  final NoteController controller = Get.find<NoteController>();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon:  Icon(Icons.clear, color: Get.isDarkMode?Colors.white:Colors.black,),)
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Get.back();
        },
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,color: Get.isDarkMode?Colors.white:Colors.black,
          progress: transitionAnimation,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    
    SizeConfig().init(context);

    final suggestionList = query.isEmpty
        ? controller.notesList
        : controller.notesList.where(
          (p) {
        return p.title!.toLowerCase().contains(query.toLowerCase()) ||
            p.note!.toLowerCase().contains(query.toLowerCase());},
    ).toList();
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        scrollDirection:
        SizeConfig.orientation == Orientation.landscape
            ? Axis.horizontal
            : Axis.vertical,
        itemBuilder: (BuildContext context, int index) {

          var notes = suggestionList[index];
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 800),
            child: SlideAnimation(
              horizontalOffset: 200,
              child: FadeInAnimation(
                child: GestureDetector(
                  onLongPress: () {
                    // showDialog(
                    //   context: context,
                    //   builder: (context) {
                    //     return AlertDialogWidget(
                    //       contentText:
                    //           'Are you sure you want to delete the note?',
                    //       confirmFunction: () {
                    //         notesController.deleteNote(
                    //             notesController
                    //                 .notesList[index].id!);
                    //         Get.back();
                    //       },
                    //       declineFunction: () {
                    //         Get.back();
                    //       },
                    //     );
                    //   },
                    // );
                    // suggestionList[index].title;
                  },
                  onTap: () {
                    Get.to(
                      NoteDetailPage(i: suggestionList[index].id!),
                    );
                  },
                  child: NotesTile(notes),
                ),
              ),
            ),
          );
        },
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: suggestionList.length,
      ),
    );

  }
}
