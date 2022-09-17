import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/providers/listProvider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../models/todo.dart';
import '../providers/ThemeProvider.dart';

class BottomSheetStyle extends StatefulWidget {
  const BottomSheetStyle({Key? key}) : super(key: key);

  @override
  State<BottomSheetStyle> createState() => _BottomSheetStyleState();
}



class _BottomSheetStyleState extends State<BottomSheetStyle> {
  String title = "";
  String details = "";
  DateTime selectedDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  late ThemeProvider themeProvider;
  late ListProvider listProvider;

  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of(context);
    themeProvider = Provider.of(context);
    return Container(
      color: Theme.of(context).cursorColor,
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.03),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Center(
              child: Text(
                AppLocalizations.of(context)!.addNewTask,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            TextFormField(
              onChanged: (text) {
                title = text;
              },
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return AppLocalizations.of(context)!.pleaseEnterYourTask;
                }
              },
              style: Theme.of(context).textTheme.titleSmall,
              decoration:
                   InputDecoration(hintText: AppLocalizations.of(context)!.enterYourTask,hintStyle: Theme.of(context).textTheme.headlineSmall),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            TextFormField(
              onChanged: (text) {
                details = text;
              },
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return AppLocalizations.of(context)!.placeEnterYourDetailsTask;
                }
              },
              maxLines: 3,
              style: Theme.of(context).textTheme.titleSmall,
              decoration:  InputDecoration(
                hintText: AppLocalizations.of(context)!.enterYourDetailsTask,hintStyle: Theme.of(context).textTheme.headlineSmall
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            Text(
              AppLocalizations.of(context)!.selectedTime,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Center(
              child: InkWell(
                onTap: () {
                  ShowDatePicker();
                },
                child: Text(
                  "${selectedDate.year} / ${selectedDate.month} / ${selectedDate.day}",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            const Spacer(),
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
              child: ElevatedButton(
                onPressed: () {
                  AddTask();
                },
                child: Text(
                  AppLocalizations.of(context)!.add,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void ShowDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(Duration(days: 365)))
        .then((selectedDate) {
      this.selectedDate = selectedDate ?? this.selectedDate;
      setState(() {});
    });
  }

  void AddTask() {
    if (!_formKey.currentState!.validate()) return;
    CollectionReference todos = FirebaseFirestore.instance.collection('todos');
    todos.doc().set({
      "title": title,
      "details": details,
      "dateTime": selectedDate.millisecondsSinceEpoch,
      "cheeked" : false
    }).timeout(Duration(milliseconds: 500), onTimeout: () {
      listProvider.getTodosFireStore();
      Navigator.pop(context);
    });
  }
}
