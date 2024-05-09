import 'package:flutter/material.dart';
import 'package:speakeasy/main.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 147, 177),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 237, 147, 177),
        toolbarHeight: 100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              width: (MediaQuery.of(context).size.width), // Button width
              height: (MediaQuery.of(context).size.height) / 3, // Button height
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, studyRoute);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(20.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text(
                  'Study',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),

            SizedBox(height: 20),

          SizedBox(
            width: (MediaQuery.of(context).size.width), // Button width
            height: (MediaQuery.of(context).size.height) / 3, // Button height
            child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, quizRoute);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    'Quiz',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, menuRoute);
              },
              icon: const Icon(Icons.home),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, leaderboardRoute);
              },
              icon: const Icon(Icons.leaderboard),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, settingsRoute);
              },
              icon: const Icon(Icons.settings),
            ),
          ],
        ),
      ),
    );
  }
}
