import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import '../main.dart';

class CreateAccountScreen extends StatefulWidget {
  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _email = '';
  String _password = '';

  void _tryCreateAccount() async {
    print("_tryCreateAccount function is working...");
    final isValid = _formKey.currentState?.validate();
    if (isValid == null || !isValid) {
      return;
    }
    _formKey.currentState?.save();

    // Open a connection
    final conn = await Connection.open(
      Endpoint(
        host: 'trumpet.db.elephantsql.com',
        database: 'ccbrkqhl',
        username: 'ccbrkqhl',
        password: '7xxKPGlhzWg_psoIWrFh_DGiH6Jl70EX',
      ),
    );

    // Insert the user details into the database
    final data = await conn.execute(
      "INSERT INTO player (username, email, password, skill_level, score, theme) "
      "VALUES ('$_username', '$_email', '$_password', 1, 0, 'light')",
    );

    // Close the connection
    await conn.close();

    if (data.isEmpty) {
      print('Account created for: $_username');
      // Navigate back to login screen
      Navigator.pop(context);
    } else {
      print('Failed to create account for: $_username');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true, // This line adds the back button
        backgroundColor: const Color.fromARGB(255, 237, 147, 177),
      ),
      backgroundColor: const Color.fromARGB(255, 237, 147, 177),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: "Username",
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your username';
                  }
                  return null;
                },
                onSaved: (value) {
                  _username = value ?? '';
                },
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.email),
                  labelText: "Email",
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value ?? '';
                },
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.lock),
                  labelText: "Password",
                ),
                obscureText: true,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value ?? '';
                },
              ),
              const SizedBox(
                height: 32,
              ),
              ElevatedButton(
                onPressed: _tryCreateAccount,
                child: const Text("Create!"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';

  void _tryLogin() async {
    final isValid = _formKey.currentState?.validate();
    if (isValid == null || !isValid) {
      return;
    }
    _formKey.currentState?.save();
    // Use _username and _password to login

    // Open a connection
    final conn = await Connection.open(
      Endpoint(
        host: 'trumpet.db.elephantsql.com',
        database: 'ccbrkqhl',
        username: 'ccbrkqhl',
        password: '7xxKPGlhzWg_psoIWrFh_DGiH6Jl70EX',
      ),
    );

    // Query the database to validate login
    final result = await conn.execute(
      "SELECT username FROM player WHERE username = '$_username' AND password = '$_password'",
    );

    // Close the connection
    await conn.close();

    if (result.isNotEmpty) {
  loggedInUsername = _username; // Set loggedInUsername when login is successful
  print('Login successful for: $_username');
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => MainMenu(username: loggedInUsername)),
  );
} else {
  print('Login failed for: $_username');
}
  }

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
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: "Username",
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your username';
                  }
                  return null;
                },
                onSaved: (value) {
                  _username = value ?? '';
                },
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.lock),
                  labelText: "Password",
                ),
                obscureText: true,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value ?? '';
                },
              ),
              const SizedBox(
                height: 32,
              ),
              ElevatedButton(
                onPressed: _tryLogin,
                child: const Text("Login"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateAccountScreen()),
                  );
                },
                child: const Text("Create Account"),
              ),
            ],
          ),
        ),
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
}

class MainMenu extends StatelessWidget {
  final String username;

  MainMenu({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Menu'),
        backgroundColor: const Color.fromARGB(255, 237, 147, 177),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome, $username!', // Display username
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate back to login screen
                Navigator.pushNamed(context, loginRoute);
              },
              child: Text('Logout'),
            ),
            SizedBox(height: 20), // Add space between buttons
            ElevatedButton(
              onPressed: () {
                // Navigate back to the main menu screen
                Navigator.pushNamed(context, menuRoute);
              },
              child: Text('Return to Maisn Menu'),
            ),
          ],
        ),
      ),
    );
  }
}
