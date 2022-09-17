import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../providers/ThemeProvider.dart';
import '../providers/localProvider.dart';
import '../ui/bottomSheetLog.dart';
import '../ui/bottomSheetTheme.dart';
class SettingTab extends StatefulWidget {
  const SettingTab({Key? key}) : super(key: key);

  @override
  State<SettingTab> createState() => _SettingTabState();
}

class _SettingTabState extends State<SettingTab> {
  late LocaleProvider localeProvider;
  late ThemeProvider themeProvider;
  @override
  Widget build(BuildContext context) {
    localeProvider = Provider.of(context);
    themeProvider = Provider.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height:MediaQuery.of(context).size.height*0.1 ,),
        Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.02),
          child: Text(
            AppLocalizations.of(context)!.language,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.titleMedium,
          ),

        ),
        InkWell(
          onTap: (){
            showBottomSheetLang();
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              color: Theme.of(context).cursorColor,
            ),
            padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.02),
            margin: EdgeInsets.all(MediaQuery.of(context).size.height*0.02),
            child: Row(
              children: [
                Text(localeProvider.currentLocale =="en" ? "English": "العربية",style: Theme.of(context).textTheme.headlineSmall,),
                Spacer(),
                Icon(Icons.arrow_downward_outlined,color: Theme.of(context).cardColor,)
              ],
            ),
          ),
        ),
        SizedBox(height:MediaQuery.of(context).size.height*0.02 ,),
        Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.02),
          child: Text(
            AppLocalizations.of(context)!.theme,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.titleMedium,
          ),

        ),
        InkWell(
          onTap: (){
            showBottomSheetTheme();
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              color: Theme.of(context).cursorColor,
            ),
            padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.02),
            margin: EdgeInsets.all(MediaQuery.of(context).size.height*0.02),

            child: Row(
              children: [
                Text(themeProvider.currentTheme ==ThemeMode.light ? "Light": "Dark",style: Theme.of(context).textTheme.headlineSmall,),
                Spacer(),
                Icon(Icons.arrow_downward_outlined,color: Theme.of(context).cardColor,)

              ],
            ),
          ),
        )
      ],
    );
  }
  void showBottomSheetLang(){
    showModalBottomSheet(
      context: context,

      builder: (context){
        return  bottomSheetStyle();
      },
    );
  }

  void showBottomSheetTheme() {
    showModalBottomSheet(
      context: context,

      builder: (context){
        return  bottomSheetTheme();
      },
    );
  }
}
