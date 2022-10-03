import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final materialThemeData = ThemeData(
      scaffoldBackgroundColor: Colors.red.shade100,
      appBarTheme: const AppBarTheme(color: Colors.purple),
      primaryColor: Colors.green,
      secondaryHeaderColor: Colors.yellow,
      canvasColor: Colors.orange,
      //backgroundColor: Colors.red.shade100,
      textTheme: const TextTheme().copyWith(bodyLarge: const TextTheme().bodyMedium),
      colorScheme:
          ColorScheme.fromSwatch(primarySwatch: Colors.red).copyWith(secondary: Colors.blue));

  @override
  Widget build(BuildContext context) {
    return PlatformApp(
      home: const HomeScreen(),
      material: (a, b) => MaterialAppData(theme: materialThemeData),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  List<bool> toggles = List<bool>.filled(25, true);

  @override
  void initState() {
    super.initState();
    randomize();
  }

  bool hasWon(){
    return toggles.any((e)=>e);
  }

  void randomize(){
    for (int i = 0; i < 100; i++) {
      buttonPress(buttonNumber: Random().nextInt(25));
    }
  }

  void buttonPress({required int buttonNumber}) {
    setState(() {
      toggles[buttonNumber] = !toggles[buttonNumber];
      if (buttonNumber % 5 >= 1 && buttonNumber % 5 <= 4) {
        toggles[buttonNumber - 1] = !toggles[buttonNumber - 1];
      }
      if (buttonNumber % 5 <= 3 && buttonNumber % 5 >= 0) {
        toggles[buttonNumber + 1] = !toggles[buttonNumber + 1];
      }
      if (buttonNumber >= 5) {
        int belowButton = buttonNumber % 5 + 5 * ((buttonNumber ~/ 5) - 1);
        toggles[belowButton] = !toggles[belowButton];
      }
      if (buttonNumber <= 19) {
        int aboveButton = buttonNumber % 5 + 5 * ((buttonNumber ~/ 5) + 1);
        toggles[aboveButton] = !toggles[aboveButton];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> buttons = <Widget>[];
    String winText = "";

    for (int i = 0; i < 25; i++) {
      buttons.add(Container(
          color: Colors.purple,
          padding: const EdgeInsets.all(8),
          child: PlatformElevatedButton(
            onPressed: () {
              buttonPress(buttonNumber: i);
              if(hasWon()){
                setState(() {
                  winText = "You won!";
                });
              }
            },
            material: (context, b) => MaterialElevatedButtonData(
                style: ElevatedButton.styleFrom(
                    backgroundColor: toggles[i] ? Colors.blue : Colors.black)),
            child: PlatformText(""),
          )));
    }
    return PlatformScaffold(
        appBar: PlatformAppBar(
          title: PlatformText('Lights Out'),
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              width: 300,
                height: 150,
              child: FittedBox(
                fit: BoxFit.contain,
                child: PlatformText("Lights out")
              )

            ),
            PlatformText(winText),
            Center(
                child: SafeArea(
                    child: GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 5,
                        padding: const EdgeInsets.all(20),
                        physics: const NeverScrollableScrollPhysics(),
                        children: buttons))),
            PlatformElevatedButton(
                material: (context, b) => MaterialElevatedButtonData(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black)),
              child: PlatformText("Start Over"),
              onPressed: ()=>
              setState(() {
                toggles = List<bool>.filled(25, true);
                randomize();
                winText = "";
              })
            )
          ],
        ));
  }
}
