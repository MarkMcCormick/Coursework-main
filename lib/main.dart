import 'package:flutter/material.dart';

import 'screens/exportScreens.dart';

const menuRoute = '/menu';
const learnRoute = '/learn';
const studyRoute = '/study';
const quizRoute = '/quiz';
const blitzRoute = '/blitz';
const loginRoute = '/login';
const settingsRoute = '/settings';
const leaderboardRoute = '/board';

String loggedInUsername = '';


void main() {
  runApp(
    MaterialApp(
      initialRoute: menuRoute,
      routes: {
        menuRoute: (context) => MenuScreen(username: loggedInUsername),
        learnRoute: (context) => const LearnScreen(),
        studyRoute: (context) => const StudyScreen(),
        quizRoute: (context) => const QuizScreen(),
        loginRoute: (context) => LoginScreen(),
        settingsRoute: (context) => const SettingsPage(),
        leaderboardRoute: (context) => LeaderboardPage()

        // blitzRoute: (context) => const BlitzScreen()
      },
    ),
  );
}

// Future<void> testQuery() async {
//   final conn = await Connection.open(
//     // open connection to database, hosted by elephantsql
//     Endpoint(
//       host: 'trumpet.db.elephantsql.com',
//       database: 'ccbrkqhl',
//       username: 'ccbrkqhl',
//       password: '7xxKPGlhzWg_psoIWrFh_DGiH6Jl70EX',
//     ),
//     //settings: ConnectionSettings(sslMode: SslMode.disable), // disable ssl
//   );

//   final result = await conn.execute("SELECT * FROM player");
//   print(result);
//   await conn.close(); // close connection to database
//   globals.databaseValue = (result[0][1]).toString();
//   //globals.userSkillLevel = (result[0][2]);
// }
