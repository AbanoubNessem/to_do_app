import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/providers/ThemeProvider.dart';

import '../providers/localProvider.dart';

class bottomSheetStyle extends StatefulWidget {
  bottomSheetStyle({Key? key}) : super(key: key);

  @override
  State<bottomSheetStyle> createState() => _bottomSheetStyleState();
}

class _bottomSheetStyleState extends State<bottomSheetStyle> {
  late LocaleProvider localeProvider;
  late ThemeProvider themeProvider;


  @override
  Widget build(BuildContext context) {
    localeProvider = Provider.of(context);
    themeProvider = Provider.of(context);
    return Container(
      color: Theme.of(context).cursorColor,
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
              onTap: () {
                localeProvider.changeCurrentLocale("en");
                Navigator.pop(context);
                // final  prefs = await SharedPreferences.getInstance();
                // prefs.setString('locale',"en");
              },
              child: getSelectedlang("en")),
          SizedBox(
            height: 10,
          ),
          InkWell (
              onTap: () {
                localeProvider.changeCurrentLocale("ar");
                Navigator.pop(context);
                // final  prefs = await SharedPreferences.getInstance();
                // prefs.setString('locale',"ar");
              },
              child: getSelectedlang('ar'))
        ],
      ),
    );
  }

  Widget getSelectedlang(String locale) {
    return localeProvider.currentLocale == locale
        ? Row(
      children: [
        Text(
          locale == "en" ? "English" : "العربية",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Spacer(),
        Icon(
          Icons.done,
          color: Theme.of(context).backgroundColor,
        )
      ],
    )
        : Text(
      locale == "en" ? "English" : "العربية",
      style:  Theme.of(context).textTheme.headlineSmall,
    );
  }
}
