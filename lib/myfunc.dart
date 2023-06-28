import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'questions.dart';

List<Widget> iconslist = [];
// overall no of questions
int maxques = daques.length - 1;
//overall score
int max_score = 0;
List<int> quesinorder = List.generate(maxques + 1, (index) => index);

/// options are at index 1,2,3,4
List<int> optionorder = [1, 2, 3, 4];

/// quesno is the overall question no in the list
int quesno = 0;

/// session_qno is the question no in the current quiz session (ie max 7) and will referesh and quiz reset
int session_qno = 0;
int max_session_ques = 0;
int score = 0;

void startQuiz() {
  iconslist = [];
  maxques = daques.length - 1;
  max_score = 0;
  quesinorder = List.generate(maxques + 1, (index) => index);
  max_score = 0;
  score = 0;
  quesno = 0;
  session_qno = 0;
  playsfx('start');
  max_session_ques = 9;
  quesinorder.shuffle();
  optionorder.shuffle();
  // print('Quiz started');
  // print('Max ques : $maxques  max_session_ques : $max_session_ques');
  // print('Question order : $quesinorder');
  // print('Shuffled Question order : $quesinorder');
  // print("Shuffle options order : $optionorder");
}

//reset session
void resetQuiz() {
  session_qno = 0;
  score = 0;
  iconslist.clear();

  ///even though it is reset quiz but quesno should be incremented because it is the overall question no and with the next question after the reset it should be a new question
  quesno++;
}

void nextQuestion() {
  optionorder.shuffle();
  session_qno++;
  quesno++;
  // print('\nNext Question \n session_qno: $session_qno  :: quesno: $quesno');
  // print("Q${quesno}: ${daques[quesinorder[quesno]][0]}");
}

void checkAnswer(String user_ans, BuildContext context) {
  //right answer is at index 5
  if (user_ans == daques[quesinorder[quesno]][5]) {
    score++;
    max_score++;
    if (iconslist.length >= 7) {
      // Remove the first icon
      iconslist.removeAt(0);
    }
    iconslist.add(
      const Icon(
        Icons.check,
        color: Colors.green,
      ),
    );

    quizflow(context);
  } else {
    // print('Wrong Answer');
    if (iconslist.length >= 7) {
      // Remove the first icon
      iconslist.removeAt(0);
    }
    iconslist.add(const Icon(
      Icons.close,
      color: Colors.red,
    ));
    quizflow(context);
  }
}

/// this function will check if the quiz is completed or not and will call the functions(reset,nextquestion,start,result etc) accordingly
void quizflow(BuildContext context) {
  // print("\nQuiz flow called:");
  // print(
  //     'session_qno : $session_qno  max_session_ques : $max_session_ques && quesno : $quesno  maxques : $maxques-1');
  // print("next question: ${session_qno < max_session_ques && quesno < maxques-1}");
  // print("reset quiz: ${!(session_qno < max_session_ques) && quesno < maxques-1}");
  // print(
  //     "start again: ${!(session_qno < max_session_ques) && quesno < maxques-1}");
  //

  ///if session have not completed and overall quiz have not completed
  if (session_qno < max_session_ques && quesno < maxques - 1) {
    nextQuestion();
  }

  ///if session questions are completed but overall quiz have not completed
  else if (!(session_qno < max_session_ques) && quesno < maxques - 1) {
    showdailogbox(context, 'result');
    resetQuiz();
  }

  ///when overall quiz is completed
  else {
    restartdailoag_overallscore(context);
    startQuiz();
  }
}

void showdailogbox(BuildContext context, String type) {
  String title_face_rndmchr = String.fromCharCode(Random().nextInt(26) + 65);
  Color title_face_color = Colors.black;
  // print('Random char : $title_face_rndmchr');
  String descrip = "discription";
  if (type == 'reset') {
    descrip = "You have completed the session. Your score is $score";
  } else if (type == 'result') {
    if (score > 5) {
      right_list.shuffle();
      descrip = "\n ${right_list[0]}";
      title_face_color = Colors.green;
      playsfx('win');
    } else {
      playsfx('lose');
      wrong_list.shuffle();
      descrip = "\n ${wrong_list[0]}";
      title_face_color = Colors.red;
    }
  }
  Alert(
    context: context,
    title: "${title_face_rndmchr}",
    content: RichText(
      text: TextSpan(
        children: [
          const TextSpan(
            text: " ⵕuiz 𝙲ompleted,\n",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 30,
              fontFamily: 'RussoOne',
            ),
          ),
          const TextSpan(
            text: "\nYour score is ",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 10,
              fontFamily: 'RussoOne',
            ),
          ),
          TextSpan(
            text: "\"$score\"",
            style: TextStyle(
              color: title_face_color,
              fontSize: 15,
              fontFamily: 'RussoOne',
            ),
          ),
          TextSpan(
            text: descrip,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontFamily: 'RussoOne',
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    ),
    style: AlertStyle(
      backgroundColor: Colors.white,
      titleStyle: TextStyle(
        color: title_face_color,
        fontSize: 100,
        fontFamily: 'faces',
      ),
    ),
    buttons: [
      DialogButton(
        child: const Text(
          "ok bro",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {
          playsfx('button2');
          Navigator.pop(context);
          playsfx('start');
        },
        width: 120,
      )
    ],
  ).show();
}

void restartdailoag_overallscore(BuildContext context) {
  double percent = (max_score / maxques) * 100;
  Color score_color = Colors.black;
  if (percent > 65) {
    playsfx('win');
    score_color = Colors.green;
  } else {
    playsfx('lose');
    score_color = Colors.red;
  }
  // alert dailog to show overall score of the quiz
  Alert(
    context: context,
    title: "ⵕuiz 𝙲ompleted",
    content: RichText(
      text: TextSpan(
        children: [
          // "you score is"
          const TextSpan(
            text: "Your scored ",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15,
              fontFamily: 'RussoOne',
              fontWeight: FontWeight.bold,
            ),
          ),
          // "score"
          TextSpan(
            text: "$max_score",
            style: TextStyle(
              color: score_color,
              fontSize: 25,
              fontFamily: 'RussoOne',
            ),
          ),
          // "out of"
          TextSpan(
            text: "/$maxques",
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 20,
              fontFamily: 'RussoOne',
            ),
          ),
          // "percentage"
          TextSpan(
            text: "\n\n$percent",
            style: TextStyle(
              color: score_color,
              fontSize: 30,
              fontFamily: 'RussoOne',
            ),
          ),
          // "%"
          const TextSpan(
            text: "%",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15,
              fontFamily: 'RussoOne',
            ),
          ),
          const TextSpan(
            text: "\nOut of Questions you \nmay restart if you want",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 10,
              fontFamily: 'RussoOne',
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    ),
    //button to close the dailog
    buttons: [
      DialogButton(
        child: const Text(
          "  Restart  ",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {
          playsfx('button2');
          Navigator.pop(context);
        },
        width: 120,
      )
    ],
  ).show();
}

///play sound effects
void playsfx(String sfx) {
  if (sfx == 'button1') {
    final player = AudioPlayer();
    player.play(AssetSource('sfx/button1.wav'));
  } else if (sfx == 'button2') {
    final player = AudioPlayer();
    player.play(AssetSource('sfx/button2.wav'));
  } else if (sfx == 'start') {
    final player = AudioPlayer();
    player.play(AssetSource('sfx/start.wav'));
  } else if (sfx == 'win') {
    final player = AudioPlayer();
    player.play(AssetSource('sfx/win.wav'));
  } else if (sfx == 'lose') {
    final player = AudioPlayer();
    player.play(AssetSource('sfx/lose.wav'));
  } else {
    print('No sfx found');
  }
}
