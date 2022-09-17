import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_app/models/todo.dart';
import '../providers/ThemeProvider.dart';
import '../providers/listProvider.dart';

class EditTask extends StatefulWidget {
  static String routeName = "EditTask";
  Todo item;
  EditTask( this.item);




  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  String title = "";
  String details = "";
  DateTime selectedDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  late ThemeProvider themeProvider;
  late ListProvider listProvider;
  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of(context);
    listProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).cursorColor,
        toolbarHeight: MediaQuery.of(context).size.height * 0.2,
        title:  Text(AppLocalizations.of(context)!.toDoList),
        titleSpacing: MediaQuery.of(context).size.width * 0.05,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
              decoration:  BoxDecoration(
                  color: Theme.of(context).cursorColor,
                  borderRadius: BorderRadius.all( Radius.circular(15))),
              padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.03),
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.7,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Center(
                      child: Text(
                        AppLocalizations.of(context)!.editTask,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
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
                      height: MediaQuery.of(context).size.height * 0.02,
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
                        hintText: AppLocalizations.of(context)!.enterYourDetailsTask,hintStyle: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Text(
                      AppLocalizations.of(context)!.selectedTime,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
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
                          editTask(widget.item);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.update,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    )
                  ],
                ),
              )
          ),
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
  void editTask(Todo todo){
    if (!_formKey.currentState!.validate()) return;
    CollectionReference todos = FirebaseFirestore.instance.collection('todos');
    todos.doc(todo.id).update({
      "title": title,
      "details": details,
      "dateTime": selectedDate.millisecondsSinceEpoch,
      "cheeked" :  todo.cheeked,
    }).timeout(Duration(milliseconds: 500), onTimeout: () {
      listProvider.getTodosFireStore();
      Navigator.pop(context);
    });

  }
}
