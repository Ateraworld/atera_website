import "package:flutter/material.dart";
import "package:lottie/lottie.dart";

/// Build the default error screen
Widget errorBuilder(FlutterErrorDetails details) => Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: const Color(0xFF191C1C),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.asset(
              "assets/lottie/fatal_error.json",
              repeat: true,
              frameRate: FrameRate(30),
              width: 128,
              height: 128,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 32, bottom: 8, left: 16, right: 16),
              child: Text(
                "Something went incredibly wrong.\n Try to restart the application",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFE0E3E2),
                  fontSize: 12,
                  fontFamily: "Nunito",
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 16, left: 16, right: 16),
              child: Text(
                "${details.summary}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFFE0E3E2),
                  fontSize: 10,
                  fontFamily: "Nunito",
                  fontWeight: FontWeight.w200,
                ),
              ),
            ),
          ],
        ),
      ),
    );
