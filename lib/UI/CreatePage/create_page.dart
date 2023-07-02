import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stage_test/Components/buttons.dart';
import 'package:stage_test/Components/cards.dart';
import 'package:stage_test/Components/spacers.dart';
import 'package:stage_test/Models/Collections/task_collection.dart';
import 'package:stage_test/UI/CreatePage/Provider/create_provider.dart';
import 'package:stage_test/Utils/Mixins/general_mixin.dart';
import 'package:stage_test/Utils/Strings/app_constants.dart';
import 'package:stage_test/Utils/Themes/colors.dart';
import 'package:stage_test/Utils/Themes/text_styles.dart';

/// This class is used to show Create Page UI
class CreatePage extends StatefulWidget {
  final TaskCollection? data;

  const CreatePage({super.key, this.data});

  @override
  CreatePageState createState() => CreatePageState();
}

class CreatePageState extends State<CreatePage> with GeneralMixins {
  late CreateTaskProvider taskProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      taskProvider.setData(widget.data);
    });
  }

  @override
  Widget build(BuildContext context) {
    taskProvider = Provider.of<CreateTaskProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.createTask),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: taskProvider.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomCard(
                child: TextFormField(
                  controller: taskProvider.titleController,
                  style: TextStyles.headline3,
                  validator: validateField,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                      hintText: Strings.enterTitle,
                      contentPadding:
                          const EdgeInsets.only(left: 16, right: 16),
                      border: InputBorder.none),
                ),
              ),
              CustomCard(
                child: TextFormField(
                  controller: taskProvider.descriptionController,
                  style: TextStyles.headline6,
                  validator: validateField,
                  maxLines: 10,
                  textCapitalization: TextCapitalization.sentences,
                  maxLength: 200,
                  decoration: InputDecoration(
                    hintText: Strings.enterDescription,
                    contentPadding: const EdgeInsets.only(
                        left: 16, right: 16, top: 16, bottom: 16),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Consumer<CreateTaskProvider>(
                builder: (BuildContext context, value, Widget? child) {
                  return GestureDetector(
                    onTap: () {
                      taskProvider.pickDate(context);
                    },
                    child: CustomCard(
                      child: TextFormField(
                        enabled: false,
                        controller: taskProvider.dateController,
                        style: TextStyles.headline6,
                        decoration: InputDecoration(
                            hintText: Strings.pickDate,
                            suffixIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.calendar_month)),
                            contentPadding: const EdgeInsets.only(
                                left: 16, right: 16, top: 16, bottom: 16),
                            border: InputBorder.none),
                      ),
                    ),
                  );
                },
              ),
              Spacers.w70Spacer,
              Consumer<CreateTaskProvider>(
                builder: (BuildContext context, value, Widget? child) {
                  // Build Button or Circular Progress based on loading state
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: taskProvider.isLoading
                        ? const CircularProgressIndicator()
                        : AppButtons(
                                onClick: () {
                                  if (taskProvider.isEdit) {
                                    taskProvider.checkAndSave(context);
                                  } else {
                                    taskProvider.check(context);
                                  }
                                },
                                buttonTitle: taskProvider.isEdit
                                    ? Strings.save
                                    : Strings.create,
                                textColor: AppColors.appColorWhite,
                                bgColor: AppColors.primaryColor)
                            .textButton,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
