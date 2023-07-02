import 'package:flutter/material.dart';
import 'package:stage_test/Components/shadows.dart';
import 'package:stage_test/Models/Collections/task_collection.dart';
import 'package:stage_test/Utils/Themes/colors.dart';
import 'package:stage_test/Utils/Themes/text_styles.dart';
import 'package:stage_test/Utils/utility.dart';

/// This class is used to build UI for List Tile for Task List page
class TaskItem extends StatelessWidget {
  final TaskCollection data;

  // List Callbacks
  final Function(String) deleteCallback;
  final Function(String, bool) markCallback;
  final Function(TaskCollection) editCallback;

  const TaskItem({
    super.key,
    required this.data,
    required this.deleteCallback,
    required this.markCallback,
    required this.editCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [CustomShadows.lightShadow],
          color: AppColors.appColorWhite),
      child: ListTile(
        title: Text(
          (data.title ?? "").toCapitalized(),
          style: TextStyles.headline6.copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          (data.description ?? "").toCapitalized(),
          style: TextStyles.bodyText2,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.check_circle,
            color: (data.isCompleted ?? false)
                ? AppColors.primaryColor
                : AppColors.appColorBlack35,
          ),
          onPressed: () {
            // User clicked on check button
            markCallback(data.documentId!, !data.isCompleted!);
          },
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                Icons.edit,
                color: AppColors.appColorBlack35,
              ),
              onPressed: () {
                // User clicked on edit button
                editCallback(data);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: AppColors.appColorBlack35,
              ),
              onPressed: () {
                // User clicked on delete button
                deleteCallback(data.documentId!);
              },
            )
          ],
        ),
      ),
    );
  }
}
