import 'dart:async';

import 'package:flutter/material.dart';

class TimerText extends StatefulWidget {
  final Function onTapCallback;
  final bool isEnable;

  const TimerText({Key key, this.onTapCallback, this.isEnable})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TimerTextState();
  }
}

class _TimerTextState extends State<TimerText> {
  Timer _timer;
  int count = 60;
  String buttonText = "发送验证码";
  VoidCallback voidCallback;

  @override
  void initState() {
    super.initState();
    setState(() {
      voidCallback = widget.isEnable ? _startTimer : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: RaisedButton(
          disabledColor: Colors.grey,
          color: Colors.blue,
          onPressed: voidCallback,
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 13,
              color: Colors.white,
            ),
          )),
    );
  }

  void _startTimer() {
    widget.onTapCallback.call();
    voidCallback = null;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      count--;
      if (count <= 0) {
        voidCallback = _startTimer;
        timer.cancel();
      }
      setState(() {
        if (voidCallback != null) {
          buttonText = "发送验证码";
        } else {
          buttonText = "$count再次发送";
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    if(_timer.isActive){
      _timer.cancel();
    }
  }
}
