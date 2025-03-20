import 'package:easy_swipe_widget/easy_swipe_widget.dart';
import 'package:flutter/material.dart';

/// Entry point of the application.
void main() {
  runApp(MyApp());
}

/// A simple Flutter app demonstrating the SwipeWidget.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hides debug banner
      home: Scaffold(
        appBar: AppBar(title: Text("Swipe Widget Example")),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            /// Example 1: Swipe with scale animation (Does not remove after swipe)
            Center(
              child: EasySwipeWidget(
                removeAfterSwipe: false,
                enableScaleAnimation: true,
                onSwipe: (direction) {
                  print(
                      "Swiped ${direction == SwipeDirection.left ? 'Left' : 'Right'}");
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  color: Colors.blue,
                  child: Text(
                    "Swipe me left or right! (with Scale Animation)",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),

            /// Example 2: Swipe and remove the widget after swipe
            Center(
              child: EasySwipeWidget(
                removeAfterSwipe: true,
                enableScaleAnimation: false,
                onSwipe: (direction) {
                  print(
                      "Swiped ${direction == SwipeDirection.left ? 'Left' : 'Right'}");
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  color: Colors.red,
                  child: Text(
                    "Swipe me left or right! (Will be removed)",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),

            /// Example 3: Swipe without scale animation (Remains after swipe)
            Center(
              child: EasySwipeWidget(
                removeAfterSwipe: false,
                enableScaleAnimation: false,
                onSwipe: (direction) {
                  print(
                      "Swiped ${direction == SwipeDirection.left ? 'Left' : 'Right'}");
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  color: Colors.green,
                  child: Text(
                    "Swipe me left or right!",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
