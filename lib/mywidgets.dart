import 'package:flutter/material.dart';

import 'myfunc.dart';
import 'questions.dart';

Expanded genrow(
    {required int btn1,
    required int btn2,
    required void Function(String) updatestate}) {
  return Expanded(
    flex: 2,
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: genbutton(btn_num: btn1, updatestate: updatestate),
          ),
          const SizedBox(width: 5.0),
          Expanded(
            child: genbutton(btn_num: btn2, updatestate: updatestate),
          ),
        ],
      ),
    ),
  );
}

ElevatedButton genbutton(
    {required int btn_num, required void Function(String) updatestate}) {
  return ElevatedButton(
    onPressed: () {
      String user_ans = daques[quesinorder[quesno]][optionorder[btn_num]];
      updatestate(user_ans);
      playsfx('button1');
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.redAccent[100],
      side: const BorderSide(
        width: 2.0,
        style: BorderStyle.solid,
        color: Colors.black,
      ),
    ),
    child: Text(
      daques[quesinorder[quesno]][optionorder[btn_num]],
      style: const TextStyle(
        fontSize: 20.0,
        fontFamily: 'KGB',
        // fontWeight: FontWeight.bold,
      ),
    ),
  );
}
