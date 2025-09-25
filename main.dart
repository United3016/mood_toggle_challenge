import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MoodModel(),
      child: MyApp(),
    ),
  );
}

// Mood Model - State Management with Provider
class MoodModel with ChangeNotifier {
  String _currentMood = "assets/happy.png"; // default mood image
  Color _bgColor = Colors.yellow; // default background color

  // Mood counters
  final Map<String, int> _moodCounts = {
    "happy": 0,
    "sad": 0,
    "excited": 0,
  };

  String get currentMood => _currentMood;
  Color get bgColor => _bgColor;
  Map<String, int> get moodCounts => _moodCounts;

  void setHappy() {
    _currentMood = "assets/happy.png";
    _bgColor = Colors.yellow;
    _moodCounts["happy"] = _moodCounts["happy"]! + 1;
    notifyListeners();
  }

  void setSad() {
    _currentMood = "assets/sad.png";
    _bgColor = Colors.blue;
    _moodCounts["sad"] = _moodCounts["sad"]! + 1;
    notifyListeners();
  }

  void setExcited() {
    _currentMood = "assets/excited.png";
    _bgColor = Colors.orange;
    _moodCounts["excited"] = _moodCounts["excited"]! + 1;
    notifyListeners();
  }
}

// Main App
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mood Toggle Challenge",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

// Home Page
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MoodModel>(
      builder: (context, moodModel, child) {
        return Scaffold(
          backgroundColor: moodModel.bgColor, // background changes with mood
          appBar: AppBar(title: Text("Mood Toggle Challenge")),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("How are you feeling?", style: TextStyle(fontSize: 24)),
                SizedBox(height: 30),
                MoodDisplay(),
                SizedBox(height: 50),
                MoodButtons(),
                SizedBox(height: 40),
                MoodCounter(), // mood counter added
              ],
            ),
          ),
        );
      },
    );
  }
}

// Widget that displays current mood image
class MoodDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MoodModel>(
      builder: (context, moodModel, child) {
        return Image.asset(
          moodModel.currentMood,
          height: 150,
          width: 150,
        );
      },
    );
  }
}

// Widget with buttons to change mood
class MoodButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () =>
              Provider.of<MoodModel>(context, listen: false).setHappy(),
          child: Text("Happy"),
        ),
        ElevatedButton(
          onPressed: () =>
              Provider.of<MoodModel>(context, listen: false).setSad(),
          child: Text("Sad"),
        ),
        ElevatedButton(
          onPressed: () =>
              Provider.of<MoodModel>(context, listen: false).setExcited(),
          child: Text("Excited"),
        ),
      ],
    );
  }
}

// Widget to display mood counters
class MoodCounter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MoodModel>(
      builder: (context, moodModel, child) {
        return Column(
          children: [
            Text(
              "Mood Counters",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Happy: ${moodModel.moodCounts["happy"]}"),
                Text("Sad: ${moodModel.moodCounts["sad"]}"),
                Text("Excited: ${moodModel.moodCounts["excited"]}"),
              ],
            ),
          ],
        );
      },
    );
  }
}
