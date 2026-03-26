import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_assistant_2608/project/classes/constants.dart';
import 'package:money_assistant_2608/project/database_management/sqflite_services.dart';
import 'app_pages/analysis.dart';
import 'app_pages/input.dart';
import 'localization/methods.dart';
import 'app_pages/calendar.dart';
import 'app_pages/others.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  List<Widget> myBody = [
    AddInput(),
    Analysis(),
    Calendar(),
    Other(),
  ];
  BottomNavigationBarItem bottomNavigationBarItem(
          IconData iconData, String label) =>
      BottomNavigationBarItem(
        icon: Padding(
          padding: EdgeInsets.only(bottom: 4.h),
          child: Icon(
            iconData,
            size: 24.sp,
          ),
        ),
        label: getTranslated(context, label),
        backgroundColor: surfaceColor,
      );

  @override
  void initState() {
    super.initState();
    DB.init();
  }

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> bottomItems = <BottomNavigationBarItem>[
      bottomNavigationBarItem(Icons.add, 'Input'),
      bottomNavigationBarItem(Icons.analytics_outlined, 'Analysis'),
      bottomNavigationBarItem(Icons.calendar_today, 'Calendar'),
      bottomNavigationBarItem(Icons.account_circle, 'Other'),
    ];

    return Scaffold(
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: shadowColor,
                blurRadius: 12,
                offset: Offset(0, -3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28.r),
              topRight: Radius.circular(28.r),
            ),
            child: BottomNavigationBar(
              iconSize: 28.sp,
              selectedFontSize: 13.sp,
              unselectedFontSize: 12.sp,
              backgroundColor: surfaceColor,
              selectedItemColor: primaryColor,
              unselectedItemColor: textSecondary,
              type: BottomNavigationBarType.fixed,
              items: bottomItems,
              currentIndex: _selectedIndex,
              selectedLabelStyle: GoogleFonts.nunito(
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
              ),
              unselectedLabelStyle: GoogleFonts.nunito(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
              onTap: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
        body: myBody[_selectedIndex]);
  }
}
