import 'package:arzaq_app/widgets/custome_app_text.dart';
import 'package:flutter/material.dart';
import 'dart:async';


class TimerWidget extends StatefulWidget {
  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  int _seconds = 120; // تغيير القيمة إلى 120 ثانية (دقيقتين)
  Timer _timer = Timer(const Duration(seconds: 1), () { });

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_seconds == 0) {
          timer.cancel();
        } else {
          setState(() {
            _seconds--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int minutes = (_seconds ~/ 60);
    int seconds = (_seconds % 60);
    String formattedSeconds = seconds < 10 ? "0$seconds" : "$seconds";

    return AppText(
      text: '0$minutes:$formattedSeconds',
      color: const Color(0XFFA7A9B7),
      fontWeight: FontWeight.w500,
      fontSize: 14,
    );
  }
}

