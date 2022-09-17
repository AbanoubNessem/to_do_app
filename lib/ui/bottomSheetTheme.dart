import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../providers/ThemeProvider.dart';

class bottomSheetTheme extends StatefulWidget {
  bottomSheetTheme({Key? key}) : super(key: key);

  @override
  State<bottomSheetTheme> createState() => _bottomSheetThemeState();
}

class _bottomSheetThemeState extends State<bottomSheetTheme> {
  late ThemeProvider themeProvider;



  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of(context);
    return Container(
      color: Theme.of(context).cursorColor,
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
              onTap: (){
                themeProvider.changeCurrentTheme(ThemeMode.light);
                Navigator.pop(context);
              },
              child: getSelectedTheme(ThemeMode.light)),
          SizedBox(
            height: 10,
          ),
          InkWell(
              onTap: (){
                themeProvider.changeCurrentTheme(ThemeMode.dark);
                Navigator.pop(context);
              },
              child: getSelectedTheme(ThemeMode.dark))
        ],
      ),
    );
  }

  Widget getSelectedTheme(ThemeMode theme) {
    return themeProvider.currentTheme == theme
        ? Row(
      children: [
        Text(
          theme == ThemeMode.light ? AppLocalizations.of(context)!.lightMood
              : AppLocalizations.of(context)!.darkMood,
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
      theme == ThemeMode.light ? AppLocalizations.of(context)!.lightMood
          : AppLocalizations.of(context)!.darkMood,

      style: Theme.of(context).textTheme.headlineSmall,
    );
  }
}