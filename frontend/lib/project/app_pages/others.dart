import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:money_assistant_2608/project/app_pages/select_date_format.dart';
import 'package:money_assistant_2608/project/app_pages/select_language.dart';
import 'package:money_assistant_2608/project/auth_pages/user_account.dart';
import 'package:money_assistant_2608/project/classes/alert_dialog.dart';
import 'package:money_assistant_2608/project/classes/constants.dart';
import 'package:money_assistant_2608/project/classes/custom_toast.dart';
import 'package:money_assistant_2608/project/database_management/shared_preferences_services.dart';
import 'package:money_assistant_2608/project/database_management/sqflite_services.dart';
import 'package:money_assistant_2608/project/localization/methods.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../provider.dart';
import 'currency.dart';

class Other extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                primaryColor,
                primaryLight.withOpacity(0.8),
                backgroundColor,
              ],
              stops: [0.0, 0.6, 1.0],
            ),
          ),
          child: Column(
            children: [
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16.h),
                      Row(
                        children: [
                          CircleAvatar(
                            child: CircleAvatar(
                                child: Icon(
                                  FontAwesomeIcons.smileBeam,
                                  color: primaryColor,
                                  size: 40.sp,
                                ),
                                radius: 30.r,
                                backgroundColor: white),
                            radius: 35.r,
                            backgroundColor: accentColor.withOpacity(0.2),
                          ),
                          SizedBox(
                            width: 16.w,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${getTranslated(context, 'Hi you')!}!',
                                  style: GoogleFonts.inter(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.bold,
                                    color: white,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  'Welcome back',
                                  style: GoogleFonts.inter(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.normal,
                                    color: white.withOpacity(0.9),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ChangeNotifierProvider<OnSwitch>(
                    create: (context) => OnSwitch(),
                    builder: (context, widget) => Settings(providerContext: context)),
              ),
            ],
          ),
        ));
  }
}

class Settings extends StatefulWidget {
  final BuildContext providerContext;
  const Settings({required this.providerContext});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    List<Widget> pageRoute = [
      UserAccount(),
      SelectLanguage(),
      Currency(),
    ];
    List<Widget> settingsIcons = [
      Icon(
        Icons.account_circle,
        size: 24,
        color: primaryColor,
      ),
      Icon(
        Icons.language,
        size: 24.sp,
        color: primaryColor,
      ),
      Icon(
        Icons.monetization_on,
        size: 24.sp,
        color: accentColor,
      ),
      Icon(Icons.format_align_center, size: 24.sp, color: primaryColor),
      Icon(Icons.refresh, size: 24.sp, color: primaryColor),
      Icon(Icons.delete_forever, size: 24.sp, color: red),
      Icon(
        Icons.share,
        size: 22.sp,
        color: primaryColor,
      ),
      Icon(
        Icons.star,
        size: 24.sp,
        color: Colors.amber,
      ),
    ];
    List<String> settingsList = [
      getTranslated(context, 'My Account')!,
      getTranslated(context, 'Language') ?? 'Language',
      getTranslated(context, 'Currency') ?? 'Currency',
      (getTranslated(context, 'Date format') ??
          'Date format') +
              ' (${DateFormat(sharedPrefs.dateFormat).format(now)})',
      getTranslated(context, 'Reset All Categories') ?? 'Reset All Categories',
      getTranslated(context, 'Delete All Data') ?? 'Delete All Data',
      getTranslated(context, 'Rate App') ?? 'Rate App',
    ];

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: ListView.builder(
          padding: EdgeInsets.only(top: 16.h),
          itemCount: settingsList.length,
          itemBuilder: (context, int) {
            return GestureDetector(
              onTap: () async {
                if ((int == 0) || (int == 1) || (int == 2)) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => pageRoute[int]));
                } else if (int == 3) {
                  Navigator.push(context,
                          MaterialPageRoute(builder: (context) => FormatDate()))
                      .then((value) => setState(() {}));
                } else if (int == 4) {
                  void onReset() {
                    sharedPrefs.setItems(setCategoriesToDefault: true);
                    customToast(context, 'Categories have been reset');
                  }

                  false
                      ? await iosDialog(
                          context,
                          'This action cannot be undone. Are you sure you want to reset all categories?',
                          'Reset',
                          onReset)
                      : await androidDialog(
                          context,
                          'This action cannot be undone. Are you sure you want to reset all categories?',
                          'reset',
                          onReset);
                } else if (int == 5) {
                  Future onDeletion() async {
                    await DB.deleteAll();
                    customToast(context, 'All data has been deleted');
                  }

                  false
                      ? await iosDialog(
                          context,
                          'Deleted data can not be recovered. Are you sure you want to delete all data?',
                          'Delete',
                          onDeletion)
                      : await androidDialog(
                          context,
                          'Deleted data can not be recovered. Are you sure you want to delete all data?',
                          'Delete',
                          onDeletion);
                } else if (int == 6) {
                  // Rate app - no-op on web
                }
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: cardBackground,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: shadowColor,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: SizedBox(
                    child: ListTile(
                      title: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Text(
                          '${settingsList[int]}',
                          style: GoogleFonts.inter(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: textPrimary,
                          ),
                        ),
                      ),
                      leading: CircleAvatar(
                          radius: 22.r,
                          backgroundColor: backgroundColor,
                          child: settingsIcons[int]),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 18.sp,
                        color: textHint,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}

// class Upgrade extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         Container(
//           height: 165.h,
//           color: Color.fromRGBO(234, 234, 234, 1),
//         ),
//         Container(
//           alignment: Alignment.center,
//           height: 115.h,
//           decoration: BoxDecoration(
//               image: DecorationImage(
//                   fit: BoxFit.fill, image: AssetImage('images/image13.jpg'))),
//         ),
//         Container(
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//               color: Color.fromRGBO(255, 255, 255, 1),
//               borderRadius: BorderRadius.circular(40),
//               border: Border.all(
//                 color: Colors.grey,
//                 width: 0.5.w,
//               )),
//           height: 55.h,
//           width: 260.w,
//           child: Text(
//             getTranslated(context, 'VIEW UPGRADE OPTIONS')!,
//             style: TextStyle(fontSize: 4.206, fontWeight: FontWeight.bold),
//           ),
//         ),
//       ],
//     );
//   }
// }
