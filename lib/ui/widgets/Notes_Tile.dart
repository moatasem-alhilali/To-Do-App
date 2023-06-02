import 'package:flutter/material.dart';
import 'package:todo/models/note.dart';
import 'package:todo/ui/size_config.dart';
import 'package:todo/ui/theme.dart';

class NotesTile extends StatelessWidget {
   NotesTile(this.note, {Key? key}) : super(key: key);
   Note? note;

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(
            SizeConfig.orientation == Orientation.landscape ? 8 : 20),
      ),
      width: SizeConfig.orientation == Orientation.landscape
          ? SizeConfig.screenWidth / 2
          : SizeConfig.screenWidth,
      margin: EdgeInsets.only(
        bottom: getProportionateScreenHeight(8),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blueAccent,
        ),
        child: Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      note!.title!,
                      style: titleStyle.copyWith(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.timelapse,
                          color: Colors.grey,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          ' تاريخ الانشاء ${note!.dateTimeCreated!} ',
                          style: const TextStyle(
                            fontFamily: 'Tajawal',

                            fontSize: 13,
                            overflow: TextOverflow.ellipsis,
                            color: Colors.white,

                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      note!.note!,
                      maxLines: 10,
                      style: titleStyle.copyWith(color: Colors.white,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              color: Colors.grey[200]!.withOpacity(0.7),
            ),
             RotatedBox(
              quarterTurns: 3,
              child: Text(
                ' تاريخ التعديل  ${note!.dateTimeEdit}  ',
                // task.isCompleted == 0 ? 'غير مكتملة' : 'مكتملة',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Tajawal',
                  fontSize: 10,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
