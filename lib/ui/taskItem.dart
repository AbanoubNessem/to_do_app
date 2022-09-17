import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/providers/listProvider.dart';
import 'package:to_do_app/screens/editTask.dart';
import '../models/todo.dart';
import '../providers/ThemeProvider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskItem extends StatefulWidget {
  Todo item;
  TaskItem(this.item);

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  late ThemeProvider themeProvider;
  late ListProvider listProvider;

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of(context);
    listProvider = Provider.of(context);
    return Slidable(
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              Todo.getCollectionRef()
                  .doc(widget.item.id)
                  .delete()
                  .timeout(Duration(milliseconds: 500), onTimeout: () {
                listProvider.getTodosFireStore();
              });
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15)),
            icon: Icons.delete,
            label: AppLocalizations.of(context)!.delete,
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder:
          (context)=> EditTask(widget.item)
          ));
        },
        child: Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
          decoration:  BoxDecoration(
            color: Theme.of(context).cursorColor,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: widget.item.cheeked
                      ? Colors.green
                      : Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                ),
                width: MediaQuery.of(context).size.width * 0.015,
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.03,
                    ),
                    child: Text(
                      widget.item.title,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                              color: widget.item.cheeked
                                  ? Colors.green
                                  : Theme.of(context).primaryColor),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.03,
                      vertical: MediaQuery.of(context).size.width * 0.03,
                    ),
                    child: Text(
                      widget.item.details,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  DoneTask(widget.item);
                },
                child: widget.item.cheeked
                    ? Text(
                        AppLocalizations.of(context)!.done,
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: widget.item.cheeked ? Colors.green :Theme.of(context).primaryColor
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.width * 0.02,
                            horizontal:
                                MediaQuery.of(context).size.width * 0.04),
                        child: const Icon(
                          Icons.done,
                          color: Colors.white,
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
  void DoneTask (Todo todo){
    CollectionReference todoRef = FirebaseFirestore.instance.collection('todos');
    todoRef.doc(widget.item.id).update({
      'cheeked' : widget.item.cheeked ? false : true,
    });
    listProvider.getTodosFireStore();

  }
}
