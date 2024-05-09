import 'package:flutter/material.dart';
import 'package:speakeasy/main.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool switch1 = false;
  bool switch2 = false;
  bool switch3 = false;
  bool switch4 = false;

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
            buildSwitchRow('Dark Mode', switch1, (value) {
              setState(() {
                switch1 = value;
              });
            }),
            buildSwitchRow('Notifications', switch2, (value) {
              setState(() {
                switch2 = value;
              });
            }),
            buildSwitchRow('Themes', switch3, (value) {
              setState(() {
                switch3 = value;
              });
            }),
            buildSwitchRow('Sound On/Off', switch4, (value) {
              setState(() {
                switch4 = value;
              });
            }),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, settingsRoute);
              },
              icon: const Icon(Icons.home),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, leaderboardRoute);
              },
              icon: const Icon(Icons.leaderboard),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSwitchRow(String label, bool value, Function(bool) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}