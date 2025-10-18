import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'state/app_state.dart';
import 'screens/onboarding_screen.dart';
import 'screens/role_selection.dart';
import 'screens/roommate_swipe.dart';
import 'screens/home_screen.dart';
import 'screens/questionnaire.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Color primary = const Color(0xFF992F2F);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tartan Homes',
        theme: ThemeData(
          primaryColor: primary,
          colorScheme: ColorScheme.fromSwatch().copyWith(primary: primary, secondary: Colors.white),
          scaffoldBackgroundColor: Colors.white,
          textTheme: GoogleFonts.latoTextTheme(),
          appBarTheme: AppBarTheme(
            backgroundColor: primary,
            foregroundColor: Colors.white,
            elevation: 2,
            centerTitle: true,
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
            selectedItemColor: primary,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 4,
              textStyle: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          cardTheme: CardTheme(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (c) => OnboardingScreen(),
          '/role': (c) => RoleSelectionScreen(),
          '/questionnaire': (c) => QuestionnaireScreen(),
          '/roommates': (c) => RoommateSwipeScreen(),
          '/home': (c) => HomeScreen(),
        },
      ),
    );
  }
}
 
