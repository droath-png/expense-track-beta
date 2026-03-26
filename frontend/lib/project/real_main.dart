import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'database_management/shared_preferences_services.dart';
import 'localization/app_localization.dart';
import 'home.dart';
import 'classes/constants.dart';

void realMain() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sharedPrefs.sharePrefsInit();
  sharedPrefs.setItems(setCategoriesToDefault: false);
  sharedPrefs.getCurrency();
  sharedPrefs.getAllExpenseItemsLists();
  runApp(MyApp()
      // AppLock(
      // builder: (args) => MyApp(),
      // lockScreen: MainLockScreen(),
      // enabled: sharedPrefs.isPasscodeOn ? true : false)
      );
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Locale? _locale;
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    Locale appLocale = sharedPrefs.getLocale();
    setState(() {
      this._locale = appLocale;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (this._locale == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[800]!)),
        ),
      );
    } else {
      return ScreenUtilInit(
        designSize: Size(428.0, 926.0),
        builder: (_, child) => MaterialApp(
          title: 'MMAS',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: primaryColor,
              primary: primaryColor,
              secondary: secondaryColor,
              surface: surfaceColor,
              error: red,
            ),
            scaffoldBackgroundColor: backgroundColor,
            appBarTheme: AppBarTheme(
              backgroundColor: primaryColor,
              foregroundColor: white,
              elevation: 0,
              centerTitle: true,
              titleTextStyle: GoogleFonts.nunito(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: white,
              ),
            ),
            cardTheme: CardThemeData(
              color: cardBackground,
              elevation: 0,
              shadowColor: shadowColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: white,
                elevation: 0,
                shadowColor: shadowColor,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.r),
                ),
                textStyle: GoogleFonts.nunito(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            outlinedButtonTheme: OutlinedButtonThemeData(
              style: OutlinedButton.styleFrom(
                foregroundColor: primaryColor,
                side: BorderSide(color: primaryColor, width: 2),
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.r),
                ),
                textStyle: GoogleFonts.nunito(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: surfaceColor,
              contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide(color: dividerColor, width: 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide(color: dividerColor, width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide(color: primaryColor, width: 2),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide(color: red, width: 1.5),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide(color: red, width: 2),
              ),
              labelStyle: GoogleFonts.nunito(color: textSecondary, fontSize: 14.sp),
              hintStyle: GoogleFonts.nunito(color: textHint, fontSize: 14.sp),
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: surfaceColor,
              selectedItemColor: primaryColor,
              unselectedItemColor: textSecondary,
              selectedLabelStyle: GoogleFonts.nunito(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
              ),
              unselectedLabelStyle: GoogleFonts.nunito(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
              type: BottomNavigationBarType.fixed,
              elevation: 0,
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: primaryColor,
              foregroundColor: white,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
            textTheme: TextTheme(
              displayLarge: GoogleFonts.inter(
                fontSize: 32.sp,
                fontWeight: FontWeight.bold,
                color: textPrimary,
              ),
              displayMedium: GoogleFonts.inter(
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: textPrimary,
              ),
              displaySmall: GoogleFonts.inter(
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
                color: textPrimary,
              ),
              headlineMedium: GoogleFonts.inter(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: textPrimary,
              ),
              titleLarge: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: textPrimary,
              ),
              titleMedium: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: textPrimary,
              ),
              titleSmall: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: textPrimary,
              ),
              bodyLarge: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.normal,
                color: textPrimary,
              ),
              bodyMedium: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.normal,
                color: textSecondary,
              ),
              bodySmall: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.normal,
                color: textSecondary,
              ),
              labelLarge: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: textPrimary,
              ),
            ),
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: primaryColor,
              selectionColor: primaryLight.withOpacity(0.3),
            ),
            dividerTheme: DividerThemeData(
              color: dividerColor,
              thickness: 1,
              space: 1,
            ),
            iconTheme: IconThemeData(
              color: textPrimary,
              size: 24,
            ),
          ),
          builder: (context, widget) => MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
            child: widget!,
          ),
          home: Home(),
          // SignIn(),
          locale: _locale,
          localizationsDelegates: [
            AppLocalization.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale!.languageCode &&
                  supportedLocale.countryCode == locale.countryCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
          supportedLocales: [
            Locale("en", "US"),
            Locale("de", "DE"),
            Locale("es", "ES"),
            Locale("fr", "FR"),
            Locale("hi", "IN"),
            Locale("ja", "JP"),
            Locale("ko", "KR"),
            Locale("pt", "PT"),
            Locale("ru", "RU"),
            Locale("tr", "TR"),
            Locale("vi", "VN"),
            Locale("zh", "CN"),
            Locale("ne", "NP"),
          ],
        ),
      );
    }
  }
}
