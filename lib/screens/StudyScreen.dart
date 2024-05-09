import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import 'package:speakeasy/globals.dart' as globals;
import 'dart:math';

import '../main.dart';

class StudyScreenState extends State<StudyScreen> {
  bool firstRun = true;

  nextQuestion(Qdata){
    print("next questioning");
    setState(() {
      var intValue = Random().nextInt(Qdata.length);
      globals.currentQuestion = Qdata.sublist(0)[intValue]['question'];
      List CQAns = [];
      for (var i = 0; i < globals.answers.length;){
        print("start");
        print(globals.answers);
        print("trackingggg");
        print(i);
        print(globals.answers[0]);
        //print(globals.answers[30]);
        print("S");
        print("A");
        print(globals.answers);
        print(globals.answers[i][0][1]);
        print("L");
        print(Qdata.sublist(0));
        print(Qdata.sublist(1));
        print(Qdata.sublist(i));
        print(Qdata.sublist(0)[0]);
        print(Qdata.sublist(0)[i]);
        print("massive L");
        print(Qdata.sublist(0)[0]['id']);
        print(globals.currentQuestion);

        print("K");
        for (var n = 0; n < Qdata.sublist(0).length;){
          print(Qdata.sublist(0)[n]['question']);
          print(globals.currentQuestion);
          print("T");
          if (Qdata.sublist(0)[n]['question'] == globals.currentQuestion){
            print("H");
            print(Qdata.sublist(0)[n]['id']);
            globals.currentQuestionId = Qdata.sublist(0)[n]['id'];
          }
          n += 1;
        }
        print("the current question id is");
        print(globals.currentQuestionId);
        if (globals.answers[i][0][1] == globals.currentQuestionId){
          CQAns = globals.answers[i];
          print("added to list");
        }
        i += 1;
      }
      print("whatthe");
      print(CQAns);
      print("here we go");
      print(CQAns[0][2]);
      print(CQAns[1][2]);
      print(CQAns[2][2]);
      print(CQAns[3][2]);
      print(CQAns);
      globals.a1but = CQAns[0][2];
      globals.a2but = CQAns[1][2];
      globals.a3but = CQAns[2][2];
      globals.a4but = CQAns[3][2];
      globals.a1Id = CQAns[0][0];
      globals.a2Id = CQAns[1][0];
      globals.a3Id = CQAns[2][0];
      globals.a4Id = CQAns[3][0];
      globals.a1B = CQAns[0][3];
      globals.a2B = CQAns[1][3];
      globals.a3B = CQAns[2][3];
      globals.a4B = CQAns[3][3];
      print(globals.currentQuestion);
      print(globals.a1but);
      print(globals.a2but);
      print(globals.a3but);
      print(globals.a4but);

    });

  }

  firstQuestion(Qdata){
    firstRun = false;
    print("first questioning");
    var intValue = Random().nextInt(Qdata.length);
    globals.currentQuestion = Qdata.sublist(0)[intValue]['question'];
    List CQAns = [];
    for (var i = 0; i < globals.answers.length;){
      print("start");
      print(globals.answers);
      print("trackingggg");
      print(i);
      print(globals.answers[0]);
      //print(globals.answers[30]);
      print("S");
      print("A");
      print(globals.answers);
      print(globals.answers[i][0][1]);
      print("L");
      print(Qdata.sublist(0));
      print(Qdata.sublist(1));
      print(Qdata.sublist(i));
      print(Qdata.sublist(0)[0]);
      print(Qdata.sublist(0)[i]);
      print("massive L");
      print(Qdata.sublist(0)[0]['id']);
      print(globals.currentQuestion);

      print("K");
      for (var n = 0; n < Qdata.sublist(0).length;){
        print(Qdata.sublist(0)[n]['question']);
        print(globals.currentQuestion);
        print("T");
        if (Qdata.sublist(0)[n]['question'] == globals.currentQuestion){
          print("H");
          print(Qdata.sublist(0)[n]['id']);
          globals.currentQuestionId = Qdata.sublist(0)[n]['id'];
        }
        n += 1;
      }
      print("the current question id is");
      print(globals.currentQuestionId);
      if (globals.answers[i][0][1] == globals.currentQuestionId){
        CQAns = globals.answers[i];
        print("added to list");
      }
      i += 1;
    }
    print("whatthe");
    print(CQAns);
    print("here we go");
    print(CQAns[0][2]);
    print(CQAns[1][2]);
    print(CQAns[2][2]);
    print(CQAns[3][2]);
    print(CQAns);
    globals.a1but = CQAns[0][2];
    globals.a2but = CQAns[1][2];
    globals.a3but = CQAns[2][2];
    globals.a4but = CQAns[3][2];
    globals.a1Id = CQAns[0][0];
    globals.a2Id = CQAns[1][0];
    globals.a3Id = CQAns[2][0];
    globals.a4Id = CQAns[3][0];
    globals.a1B = CQAns[0][3];
    globals.a2B = CQAns[1][3];
    globals.a3B = CQAns[2][3];
    globals.a4B = CQAns[3][3];
    print(globals.currentQuestion);
    print(globals.a1but);
    print(globals.a2but);
    print(globals.a3but);
    print(globals.a4but);
  }

  isCorrect(AB){
    print("maybe");
    if (AB == true) {
      globals.previousCorrect = "Your previous answer was Correct!";
      globals.rgb1 = 126;
      globals.rgb2 = 250;
      globals.rgb3 = 77;
    } else {
      globals.previousCorrect = "Your previous answer was Incorrect";
      globals.rgb1 = 250;
      globals.rgb2 = 75;
      globals.rgb3 = 62;
    }
  }



  Future<List<Map<String, dynamic>>> StudyQuery() async {
    final conn = await Connection.open(
      // Open connection to database, hosted by elephantsql
      Endpoint(
        host: 'trumpet.db.elephantsql.com',
        database: 'ccbrkqhl',
        username: 'ccbrkqhl',
        password: '7xxKPGlhzWg_psoIWrFh_DGiH6Jl70EX',
      ),
    );

    final skillLevel = await conn.execute(
      // Fetch User level
        "SELECT skill_level FROM player WHERE username = 'user1'" //change this for the logged in user
    );
    print(skillLevel[0][0]);


    final questions = await conn.execute(
      // Fetch question
      Sql.named('SELECT * FROM question WHERE skill_level <= @skillLevel'),
      parameters: {'skillLevel': skillLevel[0][0]},
    );
    print("elephant");
    print(questions[0][0]);
    final qid = questions[0][0];

    List allAnswers = [];
    print("Questions length: " + questions.length.toString());

    for (var i = 0; i < questions.length;){
      questions[i][0];
      final answersi = await conn.execute(
        // Fetch question
        Sql.named('SELECT * FROM answer WHERE question_id = @qid'),
        parameters: {'qid': questions[i][0]},
      );
      allAnswers.add(answersi);
      print(allAnswers);
      print("aA len" + allAnswers.length.toString());
      i += 1;

    }
    print(allAnswers.length);
    print("all Answers:");
    print(allAnswers);

    globals.answers = allAnswers;
    print(globals.answers);

    final List<Map<String, dynamic>> questionsData = questions.map((row) => {'id': row[0], 'skill_level': row[1], 'question': row[2]}).toList();
    print(questionsData);


    print(questions.first.toColumnMap());
    print("trace1");
    print(skillLevel[0].toString());
    print(questions);
    await conn.close();
    return questionsData;
  }






  @override
  Widget build(BuildContext context) {
    //StudyQuery();


    print("hell");
    print("hello");

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 147, 177),
      appBar: AppBar(),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: StudyQuery(),
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
            final Qdata = snapshot.data!;
            final QA = Qdata[0];
            print("jjjj");
            print(Qdata);
            print(Qdata.sublist(0));
            print(Qdata.sublist(0)[0]);
            print(Qdata.sublist(0)[0]['question']);
            print(Qdata.sublist(0)[0]['id']);
            print("answers????????????????");
            print(globals.answers);

            print("running first question");
            if (firstRun == true) {
              firstQuestion(Qdata);
            }

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 300,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, globals.rgb1, globals.rgb2, globals.rgb3),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(globals.previousCorrect,
                          style: TextStyle(color: Colors.black, fontSize: 20),
                          textAlign: TextAlign.center), //question display text
                    ),
                  ),

                  SizedBox(height: 20),

                  Container(
                    width: 300,
                    height: 200,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(globals.currentQuestion,
                          style: TextStyle(color: Colors.black, fontSize: 20),
                          textAlign: TextAlign.center), //question display text
                    ),
                  ),

                  SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          isCorrect(globals.a1B);
                          nextQuestion(Qdata);// Handle button press
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 255, 255, 255)),
                        ),
                        child: Text(globals.a1but, style: TextStyle(color: Colors.black, fontSize: 20)),//button text
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          isCorrect(globals.a2B);
                          nextQuestion(Qdata);// Handle button press
                        },
                        child: Text(globals.a2but, style: TextStyle(color: Colors.black, fontSize: 20)),//button text
                      ),
                      ]
                  ),

                  SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          isCorrect(globals.a3B);
                          nextQuestion(Qdata);// Handle button press
                        },
                        child: Text(globals.a3but, style: TextStyle(color: Colors.black, fontSize: 20)),//button text
                      ),

                    ],
                  ),

                  SizedBox(height: 20),

                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            isCorrect(globals.a4B);
                            nextQuestion(Qdata);// Handle button press
                          },
                          child: Text(globals.a4but, style: TextStyle(color: Colors.black, fontSize: 20)),//button text
                        ),
                      ]
                  ),


                ],
              ),
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
}

class StudyScreen extends StatefulWidget {
  const StudyScreen({Key? key}) : super(key: key);

  @override
  State<StudyScreen> createState() => StudyScreenState();


}
