// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
//
// import '../Model/expenseModel.dart';
//
// class SettingsPage extends StatefulWidget {
//   @override
//   _SettingsPageState createState() => _SettingsPageState();
// }
//
// class _SettingsPageState extends State<SettingsPage> {
//   late Future<bool> _isDarkModeFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     _isDarkModeFuture = _loadSettings();
//   }
//
//   Future<bool> _loadSettings() async {
//     final box = await Hive.openBox<SettingsModel>('SettingsModel');
//     final settings = box.get('settingsKey', defaultValue: SettingsModel());
//     return settings?.isDarkMode ?? false;
//   }
//
//   void _toggleDarkMode(bool value) async {
//     final box = await Hive.openBox<SettingsModel>('SettingsModel');
//     final settings = box.get('settingsKey', defaultValue: SettingsModel())?..isDarkMode = value;
//     await box.put('settingsKey', settings!);
//     setState(() {
//       _isDarkModeFuture = Future.value(value);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<bool>(
//       future: _isDarkModeFuture,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
//           return Scaffold(
//             appBar: AppBar(
//               title: Text('Settings'),
//             ),
//             body: ListTile(
//               title: Text('Enable Dark Mode'),
//               trailing: Switch(
//                 value: snapshot.data!,
//                 onChanged: _toggleDarkMode,
//               ),
//             ),
//           );
//         } else {
//           return Scaffold(
//             body: Center(child: CircularProgressIndicator()),
//           );
//         }
//       },
//     );
//   }
// }