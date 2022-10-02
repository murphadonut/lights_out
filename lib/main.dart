import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final materialThemeData = ThemeData(
      scaffoldBackgroundColor: Colors.red,
      appBarTheme: const AppBarTheme(color: Colors.purple),
      primaryColor: Colors.green,
      secondaryHeaderColor: Colors.yellow,
      canvasColor: Colors.orange,
      backgroundColor: Colors.red,
      textTheme: const TextTheme().copyWith(bodyLarge: const TextTheme().bodyMedium), colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red).copyWith(secondary: Colors.blue));

  @override
  Widget build(BuildContext context) {
    return PlatformApp(
      home: const HomeScreen(),
        material:(a,b) => MaterialAppData(theme: materialThemeData)
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  List<Widget> buttons = <Widget>[];

  _HomeScreen() {
    for (int i = 0; i < 25; i++) {
      buttons.add(
          Container(
            color: Colors.purple,
              padding: const EdgeInsets.all(8),
            child: PlatformElevatedButton(
              child: PlatformText(""),
            )
          )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: PlatformText('Lights Out'),
      ),
        body: Center(
            child: SafeArea(
                child: GridView.count(shrinkWrap: true, crossAxisCount: 5, padding: const EdgeInsets.all(20), children: buttons))));
  }
}
