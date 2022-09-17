import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/providers/listProvider.dart';
import 'package:to_do_app/providers/localProvider.dart';
import 'package:to_do_app/ui/taskItem.dart';

class ListTab extends StatefulWidget {
  const ListTab({Key? key}) : super(key: key);

  @override
  State<ListTab> createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
  late ListProvider listProvider;
  late LocaleProvider localeProvider;
  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of(context);
    localeProvider = Provider.of(context);
    if (listProvider.todos.isEmpty) {
      listProvider.getTodosFireStore();
    }
    return Container(
      child: Column(
        children: [
          CalendarTimeline(
            initialDate: listProvider.selectedDate,
            firstDate: DateTime.now().subtract(Duration(days: 365)),
            lastDate: DateTime.now().add(Duration(days: 365)),
            onDateSelected: (date) {
              listProvider.setNewSlelected(date);
              listProvider.getTodosFireStore();
              // setState(() {});
            },
            leftMargin: 20,
            monthColor: Theme.of(context).backgroundColor,
            dayColor: Theme.of(context).backgroundColor,
            activeDayColor: Colors.white,
            activeBackgroundDayColor: Theme.of(context).backgroundColor,
            dotsColor: Colors.transparent,
            // selectableDayPredicate: (date) => date.day != 23,
            locale: "${Locale(localeProvider.currentLocale)}",
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Expanded(
              child: ListView.builder(
            itemCount: listProvider.todos.length,
            itemBuilder: (context, index) {
              return TaskItem(listProvider.todos[index]);
            },
          ))
        ],
      ),
    );
  }
}
