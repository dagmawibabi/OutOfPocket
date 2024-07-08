import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myexpensetracker/Model/expenseModel.dart';
import 'package:myexpensetracker/Pages/addExpensePage.dart';
import 'package:myexpensetracker/Pages/graphsPage.dart';
import 'package:myexpensetracker/Pages/homePage.dart';
import 'package:myexpensetracker/Pages/loadingPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(ExpenseModelAdapter());
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(BudgetModelAdapter());
  Hive.registerAdapter(SettingsModelAdapter());

  await Hive.openBox<ExpenseModel>("Expenses");
  await Hive.openBox<UserModel>("UserModel");
  await Hive.openBox<BudgetModel>("BudgetModel");
  await Hive.openBox<SettingsModel>("SettingsModel");
  runApp(Main());
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box<SettingsModel>("SettingsModel").listenable(),
        builder: (BuildContext context, Box<SettingsModel> box, _) {
          final settings = box.get(
              'settingsKey', defaultValue: SettingsModel())!;

          // Dark Mode Status Bar
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
              statusBarColor: settings.isDarkMode ? Colors.grey[900] : Colors
                  .grey[200],
              statusBarIconBrightness: settings.isDarkMode
                  ? Brightness.light
                  : Brightness.dark,
            ),
          );
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: "/",
            routes: {
              "/": (context) => LoadingPage(),
              "homePage": (context) => HomePage(),
              "addExpensePage": (context) => AddExpensePage(),
              "graphsPage": (context) => GraphsPage(),
            },
            themeMode: settings.isDarkMode ? ThemeMode.dark : ThemeMode.light,

            darkTheme: ThemeData(

              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                   Color(0xff1a1a1a),
                  ),
                ),
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                foregroundColor:settings.isDarkMode? Color(0xff1a1a1a) : Colors.white,
                backgroundColor: Color(0xff1a1a1a),
              ),
              fontFamily: "Abel",

              primaryColor: Color(0xff1a1a1a),
              primaryColorDark: Colors.grey[300],
              secondaryHeaderColor: Colors.white,
              scaffoldBackgroundColor: Colors.grey[900],
              textTheme: TextTheme(
                bodyLarge: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                ),
                bodyMedium: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                ),

              ),
              hintColor: Colors.white,
              dividerColor: Colors.transparent,
              inputDecorationTheme: InputDecorationTheme(
                fillColor: Colors.black,
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
              ),
              iconTheme: IconThemeData(
                color: Colors.white,
              ),
            ),
            theme: ThemeData(
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    Color(0xff1a1a1a),
                  ),
                ),
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                foregroundColor: Colors.white,
                backgroundColor: Color(0xff1a1a1a),
              ),
              fontFamily: "Abel",
              primaryColor: Colors.white,
              primaryColorDark: Colors.grey[200],
              secondaryHeaderColor: Color(0xff1a1a1a),
              scaffoldBackgroundColor: Color(0xffeeeeee),
              textTheme: TextTheme(
                bodyLarge: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                ),
                bodyMedium: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                ),
              ),
              hintColor: Colors.black,
              dividerColor: Colors.transparent,
              inputDecorationTheme: InputDecorationTheme(
                fillColor: Colors.black,
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
              ),
              iconTheme: IconThemeData(
                color: Colors.black,
              ),


            ),


          );
        }
    );
  }
}
