import 'package:flutter/material.dart';
import 'dart:async';
import 'package:arzaq_app/widgets/custome_app_text.dart';

class CountdownTimer extends StatefulWidget {
  final DateTime endTime;
  final DateTime startTime;
  final VoidCallback onLast30Seconds;
  final VoidCallback on0Seconds;

  CountdownTimer({
    required this.endTime,
    required this.startTime,
    required this.onLast30Seconds,
    required this.on0Seconds,
  });

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  bool hasCalledOn0Seconds = false;
  bool last30 = false;
  bool hasStartedWithNonZero = false; // متغير لتتبع إذا كان العداد قد بدأ بقيمة أكبر من 0

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: _countdownStream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text("");
        }

        final secondsLeft = snapshot.data!;

        // التحقق من أن العداد قد بدأ بقيمة أكبر من 0
        if (secondsLeft > 0) {
          hasStartedWithNonZero = true;
        }

        if (hasStartedWithNonZero && secondsLeft == 0 && !hasCalledOn0Seconds) {
          // تنفيذ on0Seconds فقط عند انتهاء العداد لأول مرة بعد أن يبدأ بقيمة أكبر من 0
          hasCalledOn0Seconds = true;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            widget.on0Seconds();
          });
          return AppText(
            text: "00:00:00",
            color: Color(0xFFFF3B3F),
            fontSize: 10,
            textAlign: TextAlign.start,
            fontWeight: FontWeight.w500,
          );
        }

        if (secondsLeft <= 30 && !last30) {
          // تنفيذ onLast30Seconds مرة واحدة عند تبقي 30 ثانية أو أقل
          last30 = true;
          widget.onLast30Seconds();
        }

        final minutes = (secondsLeft ~/ 60).toString().padLeft(2, '0');
        final seconds = (secondsLeft % 60).toString().padLeft(2, '0');

        return AppText(
          text: "00:$minutes:$seconds",
          color: Color(0xFFFF3B3F),
          fontSize: 10,
          textAlign: TextAlign.start,
          fontWeight: FontWeight.w500,
        );
      },
    );
  }

  Stream<int> _countdownStream() async* {
    while (true) {
      final currentTime = DateTime.now();
      var timeLeft = widget.endTime.difference(currentTime).inSeconds;

      if (timeLeft <= 0) {
        yield 0; // عرض 0 عندما ينتهي العداد
        break;
      }

      yield timeLeft;

      await Future.delayed(Duration(seconds: 1));
    }
  }
}
