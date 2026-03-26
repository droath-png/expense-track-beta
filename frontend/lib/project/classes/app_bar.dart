import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_assistant_2608/project/localization/methods.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_assistant_2608/project/app_pages/input.dart';

import 'constants.dart';


class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const BasicAppBar(this.title);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: primaryColor,
      foregroundColor: white,
      elevation: 0,
      centerTitle: true,
      title: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          color: white,
        ),
      ),
    );
  }
}


class InExAppBar extends StatelessWidget implements PreferredSizeWidget {
final bool isInputPage;
const InExAppBar(this.isInputPage);
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    Tab appBarTab(String title) => Tab(
      child: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: BoxDecoration(),
        child: Align(
            child: Text(
              getTranslated(context, title)!,
              style: GoogleFonts.nunito(
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
                color: white.withOpacity(0.85),
              ),
            )),
      ),
    );
    return AppBar(
      backgroundColor: primaryColor,  // Sky blue
      foregroundColor: white,
      elevation: 0,
      centerTitle: true,
      title: TabBar(
        unselectedLabelColor: white.withOpacity(0.7),
        labelColor: white,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(50.r),
          color: white.withOpacity(0.25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        dividerColor: Colors.transparent,
        labelStyle: GoogleFonts.inter(
          fontSize: 15.sp,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.inter(
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
        ),
        tabs: [
         appBarTab('EXPENSE'),
          appBarTab('INCOME')
        ],
      ),
      actions: isInputPage ? [
        IconButton(
          icon: Icon(Icons.check, size: 26),
          iconSize: 28,
          onPressed: () {
            saveInputFunc(context,true);
          },
          style: IconButton.styleFrom(
            backgroundColor: white.withOpacity(0.2),
            foregroundColor: white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        ),
        SizedBox(width: 8.w),
      ] : null,
    );
  }
}


class CategoryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget editCategory;
  const CategoryAppBar(this.editCategory);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: primaryColor,
      foregroundColor: white,
      elevation: 0,
      centerTitle: true,
      actions: [
        Padding(
          padding: EdgeInsets.only(
            right: 16.w,
          ),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => editCategory));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(children: [
                Icon(
                  Icons.edit,
                  size: 18.sp,
                  color: white,
                ),
                SizedBox(width: 6.w),
                Text(
                  getTranslated(context, 'Edit')!,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: white,
                  ),
                ),
              ]),
            ),
          ),
        ),
      ],
      title: Text(getTranslated(context, 'Category')!,
          style: GoogleFonts.inter(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: white,
          )),
    );
  }
}


class EditCategoryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget addCategory;
  const EditCategoryAppBar(this.addCategory);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: primaryColor,
      foregroundColor: white,
      elevation: 0,
      centerTitle: true,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 8.w),
          child: TextButton.icon(
            onPressed: () =>  Navigator.push(context,
                MaterialPageRoute(builder: (context) => addCategory)),
            icon: Icon(Icons.add, size: 20, color: white),
            label: Text(
              getTranslated(context, 'Add')!,
              style: GoogleFonts.inter(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: white,
              ),
            ),
            style: TextButton.styleFrom(
              backgroundColor: white.withOpacity(0.2),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ),
      ],
      title: Text(getTranslated(context, 'Edit Category')!,
          style: GoogleFonts.inter(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: white,
          )),
    );
  }
}


