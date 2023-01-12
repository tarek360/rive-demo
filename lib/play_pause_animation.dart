/// Demonstrates how to play and pause a looping animation
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class PlayPauseAnimation extends StatefulWidget {
  const PlayPauseAnimation({Key? key}) : super(key: key);

  @override
  _PlayPauseAnimationState createState() => _PlayPauseAnimationState();
}

class _PlayPauseAnimationState extends State<PlayPauseAnimation> {
  /// Controller for playback
  late RiveAnimationController _controller;

  /// Toggles between play and pause animation states
  void _togglePlay(){

    setState(() {
      _controller.isActive = !_controller.isActive;

    });
  }

  /// Tracks if the animation is playing by whether controller is running
  bool get isPlaying => _controller.isActive;

  @override
  void initState() {
    super.initState();
    _controller = SimpleAnimation('filled', autoplay: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation Example'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: _togglePlay, child: const Text('Button1')),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: _togglePlay, child: const Text('Button2')),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  width: 24,
                  height: 24,
                  child: OverflowBox(
                    alignment: Alignment.bottomCenter,
                    maxWidth: 100,
                    maxHeight: 100,
                    child: Container(
                      color: Colors.lightGreenAccent.withOpacity(0.3),
                      child: RiveAnimation.asset(
                        'assets/like.riv',
                        animations: ['like', 'unlike'],
                        controllers: [_controller],
                        // Update the play state when the widget's initialized
                        // onInit: (_) => setState(() {}),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(onPressed: _togglePlay, child: const Text('Button3')),
              ],
            ),
            ElevatedButton(onPressed: _togglePlay, child: const Text('Button4')),
          ],
        ),
      ),
    );
  }
}
