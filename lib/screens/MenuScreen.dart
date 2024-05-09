import 'package:flutter/material.dart';
import 'package:speakeasy/main.dart'; // Assuming you have your routes defined in a file called main.dart

class MenuScreen extends StatefulWidget {
  final String username; // Receive the username as a parameter

  const MenuScreen({Key? key, required this.username}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> with TickerProviderStateMixin {
  late final AnimationController _logoController;
  late final Animation<double> _logoAnimation;

  late final AnimationController _buttonController;
  late final Animation<double> _buttonAnimation;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    _logoAnimation = Tween<double>(begin: 0, end: 0.1).animate(_logoController);

    _buttonController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    _buttonAnimation = CurvedAnimation(
      parent: _buttonController,
      curve: Interval(
        0.5, // Start fading in at 50% of the animation duration
        1.0, // Fully faded in at 100%
        curve: Curves.easeOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 147, 177),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const SizedBox(height: 20.0),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                'Welcome to SpeakEsasy',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 50),
            AnimatedBuilder(
              animation: _logoAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: 1 + _logoAnimation.value,
                  child: Transform.translate(
                    offset: Offset(0, -100 * _logoAnimation.value),
                    child: child,
                  ),
                );
              },
              child: Image.asset(
                'assets/images/Piggy1.png',
                width: 150.0,
                height: 150.0,
              ),
            ),
            FadeTransition(
              opacity: _buttonAnimation,
              child: Column(
                children: [
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, learnRoute);
                    },
                    child: const Text(
                      'Learn',
                      style: TextStyle(fontSize: 28.5),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  // Conditional display of Logout button and username
                  widget.username.isNotEmpty
                      ? Column(
                          children: [
                            Text(
                              'Logged in as: ${widget.username}',
                              style: TextStyle(fontSize: 20),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Logout functionality
                                Navigator.pushReplacementNamed(context, loginRoute);
                              },
                              child: const Text(
                                'Logout',
                                style: TextStyle(fontSize: 28.5),
                              ),
                            ),
                          ],
                        )
                      : ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, loginRoute);
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(fontSize: 28.5),
                          ),
                        ),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/spanish.png'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        'Learn a new language',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'with SpeakEasy!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
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

  @override
  void dispose() {
    _logoController.dispose();
    _buttonController.dispose();
    super.dispose();
  }
}
