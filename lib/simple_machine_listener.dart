import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class StateMachineListener extends StatelessWidget {
  const StateMachineListener();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Light Switch'),
      ),
      body: const Center(
        child: RiveAnimation.asset(
          'assets/light_switch.riv',
          fit: BoxFit.contain,
          stateMachines: ['Switch'],
        ),
      ),
    );
  }
}
