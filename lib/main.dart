import 'package:flutter/material.dart';

import 'myfunc.dart';
import 'mywidgets.dart';
import 'questions.dart';

void main() {
  startQuiz();
  runApp(
    const MaterialApp(
      title: 'Da Quiz',
      home: DaQuiz(),
    ),
  );
}

class DaQuiz extends StatefulWidget {
  const DaQuiz({super.key});

  @override
  State<DaQuiz> createState() => _DaQuizState();
}

class _DaQuizState extends State<DaQuiz> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Da Quiz',
          style: TextStyle(
            fontFamily: 'Die',
            fontSize: 40.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[900],
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Column(
            children: [
              /// Question Container
              Expanded(
                flex: 7,
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[100],
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      width: 3.0,
                    ),
                  ),
                  child: Column(
                    children: [
                      /// Score and icons
                      Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: iconslist,
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                margin: const EdgeInsets.all(3.0),
                                padding: const EdgeInsets.all(3.0),
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey[900],
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                    width: 2.0,
                                  ),
                                ),
                                child: Text(
                                  'Score : $score',
                                  style: const TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: 'KGB',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// Question
                      Expanded(
                        flex: 8,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            /// Question number
                            Center(
                              child: Text(
                                'Question ${quesno + 1} of ${maxques}',
                                style: const TextStyle(
                                  fontSize: 10.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10.0),

                            /// Question
                            Center(
                              child: Text(
                                // question is at index 0 of daques where quesinorder[quesno]
                                // is the index of question no in daques
                                daques[quesinorder[quesno]][0],
                                style: TextStyle(
                                  fontSize: 30.0,
                                  fontFamily: 'RussoOne',
                                  color: Colors.indigo[900],
                                  height: 1,

                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// Answer row 1
              genrow(
                  btn1: 0,
                  btn2: 1,
                  updatestate: (String user_ans) {
                    setState(() {
                      checkAnswer(user_ans, context);
                    });
                  }),
              const SizedBox(height: 5.0),

              /// Answer row 2
              genrow(
                  btn1: 2,
                  btn2: 3,
                  updatestate: (String user_ans) {
                    setState(() {
                      checkAnswer(user_ans, context);
                    });
                  }),
              const SizedBox(height: 5.0),
            ],
          ),
        ),
      ),
    );
  }
}
