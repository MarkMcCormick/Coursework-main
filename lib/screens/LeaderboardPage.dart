import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import '../main.dart';

class LeaderboardPage extends StatelessWidget {
  LeaderboardPage({Key? key}) : super(key: key);

  Future<List<Map<String, dynamic>>> leaderboardQuery() async {
    final conn = await Connection.open(
      // Open connection to database, hosted by elephantsql
      Endpoint(
        host: 'trumpet.db.elephantsql.com',
        database: 'ccbrkqhl',
        username: 'ccbrkqhl',
        password: '7xxKPGlhzWg_psoIWrFh_DGiH6Jl70EX',
      ),
    );

    final result = await conn.execute(
      // Fetch all users ordered by score
      "SELECT username, score FROM player ORDER BY score DESC LIMIT 10",
    );

    await conn.close();

    final List<Map<String, dynamic>> leaderboardData =
        result.map((row) => {'username': row[0], 'score': row[1]}).toList();

    return leaderboardData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 147, 177),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 237, 147, 177),
        toolbarHeight: 100,
        title: const Text('Leaderboard'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: leaderboardQuery(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final leaderboardData = snapshot.data!;
            final topThreeUsers = leaderboardData.sublist(0, 3);
            final remainingUsers = leaderboardData.sublist(3);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 150, // Height of podiums
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildPodium(
                        topThreeUsers[1], // Right podium
                        height: 60, // Height of the right podium
                        color: Colors.grey[300]!,
                      ), // Right podium
                      _buildPodium(
                        topThreeUsers[0], // Middle podium
                        height: 100, // Height of the middle podium
                        color: Colors.yellow[700]!,
                      ), // Middle podium
                      _buildPodium(
                        topThreeUsers[2], // Left podium
                        height: 30, // Height of the left podium
                        color: const Color.fromARGB(
                            255, 205, 127, 50),
                      ), // Left podium
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: LayoutGrid(
                      columnGap: 0,
                      rowGap: 0,
                      columnSizes: [
                        0.13.fr, // Width of the first column
                        0.6.fr, // Width of the second column
                        0.2.fr, // Width of the third column
                      ],
                      rowSizes: [
                        for (var i = 0; i < remainingUsers.length; i++) 1.fr
                      ],
                      children: [
                        for (var i = 0; i < remainingUsers.length; i++)
                          for (var j = 0; j < 3; j++)
                            _buildGridCell(
                              remainingUsers[i],
                              j,
                              i,
                            ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
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

  Widget _buildPodium(Map<String, dynamic> userData,
      {required double height, required Color color}) {
    return SizedBox(
      width: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(userData['username']),
          Text(userData['score'].toString()),
          SizedBox(height: 10), // Space between user and podium
          Container(
            width: 100,
            height: height,
            color: color,
          ),
        ],
      ),
    );
  }

  Widget _buildGridCell(
      Map<String, dynamic> userData, int columnType, int userIndex) {
    late String displayValue;

    switch (columnType) {
      case 0:
        displayValue = (userIndex + 4).toString();
        break;
      case 1:
        displayValue = userData['username'];
        break;
      case 2:
        displayValue = userData['score'].toString();
        break;
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(5),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            displayValue,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
