import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/providers/ThemeProvider.dart';
import 'package:to_do_app/screens/listTab.dart';
import 'package:to_do_app/screens/settingTab.dart';
import 'package:to_do_app/ui/bottomSheetStyle.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Home extends StatefulWidget {
  static String routeName = "Home";
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  List<Widget> tabs = [const ListTab(), const SettingTab()];
  late ThemeProvider themeProvider;
  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.2,
        title: Text(AppLocalizations.of(context)!.toDoList),
        titleSpacing: MediaQuery.of(context).size.width * 0.1,
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 5,
        clipBehavior: Clip.hardEdge,
        shape: const CircularNotchedRectangle(),
        elevation: 4,
        child: BottomNavigationBar(
          onTap: (index) {
            currentIndex = index;
            setState(() {});
          },
          currentIndex: currentIndex,
          selectedItemColor:  Theme.of(context).backgroundColor,
          selectedIconTheme:  IconThemeData(color:Theme.of(context).backgroundColor),
          unselectedIconTheme: IconThemeData(color:Theme.of(context).cardColor),
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.list,
                    // color: Theme.of(context).cardColor
                ),
                label: "list"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings,
                    // color: Theme.of(context).cardColor
                ),
                label: "Setting"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const StadiumBorder(
            side: BorderSide(color: Colors.white, width: 3)),
        onPressed: () {
          ShowBottomSheet();
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: tabs[currentIndex],
    );
  }

  void ShowBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return const BottomSheetStyle();
        });
  }
}
