import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stage_test/Models/Collections/task_collection.dart';
import 'package:stage_test/UI/CreatePage/create_page.dart';
import 'package:stage_test/UI/HomePage/Components/task_item.dart';
import 'package:stage_test/UI/HomePage/Provider/home_page_provider.dart';
import 'package:stage_test/Utils/Strings/app_constants.dart';
import 'package:stage_test/Utils/Themes/colors.dart';
import 'package:stage_test/Utils/Themes/text_styles.dart';

/// This class is used to show user the list of tasks
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late HomePageProvider homePageProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // Initial fetch for today's date
      homePageProvider.fetch(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    homePageProvider = Provider.of<HomePageProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.tasks),
        actions: [
          IconButton(
              onPressed: () {
                // Logout Action
                homePageProvider.logout(context);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          homePageProvider.createNew(context);
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CalendarTimeline(
            initialDate: homePageProvider.selectedDate ?? DateTime.now(),
            firstDate: DateTime(2019, 1, 15),
            lastDate: DateTime(2024, 11, 20),
            onDateSelected: (date) {
              // Fetch new tasks for new date selection
              homePageProvider.selectedDate = date;
              homePageProvider.fetch(context);
            },
            leftMargin: 20,
            monthColor: AppColors.appColorBlack65,
            dayColor: AppColors.appColorBlack65,
            activeDayColor: Colors.white,
            activeBackgroundDayColor: AppColors.primaryColor,
            dotsColor: AppColors.appColorWhite,
            selectableDayPredicate: (date) => date.day != 23,
            locale: 'en_IN',
          ),
          Consumer<HomePageProvider>(
              builder: (BuildContext context, value, Widget? child) {
            return Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 24),
              child: Text(
                "${homePageProvider.list.length} ${Strings.tasks}",
                style:
                    TextStyles.headline6.copyWith(fontWeight: FontWeight.bold),
              ),
            );
          }),
          Expanded(
            child: Consumer<HomePageProvider>(
                builder: (BuildContext context, value, Widget? child) {
              return ListView.builder(
                itemCount: homePageProvider.list.length,
                padding: EdgeInsets.zero,
                itemBuilder: (BuildContext context, int index) {
                  var data = TaskCollection.fromFirestore(
                      homePageProvider.list[index]);
                  return TaskItem(
                      data: data,
                      editCallback: (value) {
                        homePageProvider.edit(context, value);
                      },
                      markCallback: (path, isComplete) {
                        homePageProvider.markCompletion(
                            context, path, isComplete);
                      },
                      deleteCallback: (value) {
                        homePageProvider.deleteData(context, value);
                      });
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
