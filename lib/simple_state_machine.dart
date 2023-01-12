import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class SimpleStateMachine extends StatefulWidget {
  const SimpleStateMachine({Key? key}) : super(key: key);

  @override
  _SimpleStateMachineState createState() => _SimpleStateMachineState();
}

class _SimpleStateMachineState extends State<SimpleStateMachine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text('Simple Animation'),
      ),
      body: Center(
        child: AnimatedLikeIcon(
          iconStatus: _IconStatus.disabled,
        ),
      ),
    );
  }
}

class AnimatedLikeIcon extends StatefulWidget {
  const AnimatedLikeIcon({
    required this.iconStatus,
  });

  final _IconStatus iconStatus;

  @override
  State<AnimatedLikeIcon> createState() => _AnimatedLikeIconState();
}

class _AnimatedLikeIconState extends State<AnimatedLikeIcon> {
  late _IconStatus _iconStatus;
  SMINumber? _status;

  @override
  void initState() {
    super.initState();
    _iconStatus = widget.iconStatus;
  }

  @override
  void didUpdateWidget(covariant AnimatedLikeIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    _iconStatus = widget.iconStatus;
    _updateLikeState();
  }

  void _onRiveInit(Artboard artBoard) {
    final controller = StateMachineController.fromArtboard(artBoard, 'Default');
    artBoard.addController(controller!);
    final input = controller.findInput<double>('status');

    if (input != null) {
      _status = input as SMINumber;
      _updateLikeState();
    }
  }

  void _updateLikeState() {
    _status?.value = _iconStatus.index.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _RadioButtons((iconsStatus) {
          _status?.value = iconsStatus.index.toDouble();
        }),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.purple, width: 1, strokeAlign: StrokeAlign.center),
          ),
          width: 100,
          height: 100,
          child: RiveAnimation.asset(
            'assets/baby.riv',
            fit: BoxFit.cover,
            onInit: _onRiveInit,
          ),
        ),
      ],
    );
  }
}

enum _IconStatus {
  undefined,
  disabled,
  inProgress,
  finished,
}

class _RadioButtons extends StatefulWidget {
  const _RadioButtons(this.onIconStatusUpdated);

  final void Function(_IconStatus) onIconStatusUpdated;

  @override
  State<_RadioButtons> createState() => _RadioButtonsState();
}

class _RadioButtonsState extends State<_RadioButtons> {
  _IconStatus? _iconStatus = _IconStatus.undefined;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          title: const Text('disabled'),
          leading: Radio<_IconStatus>(
            value: _IconStatus.disabled,
            groupValue: _iconStatus,
            onChanged: (_IconStatus? value) {
              if (value != null) {
                widget.onIconStatusUpdated(value);
              }
              setState(() {
                _iconStatus = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('inProgress'),
          leading: Radio<_IconStatus>(
            value: _IconStatus.inProgress,
            groupValue: _iconStatus,
            onChanged: (_IconStatus? value) {
              if (value != null) {
                widget.onIconStatusUpdated(value);
              }
              setState(() {
                _iconStatus = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('finished'),
          leading: Radio<_IconStatus>(
            value: _IconStatus.finished,
            groupValue: _iconStatus,
            onChanged: (_IconStatus? value) {
              if (value != null) {
                widget.onIconStatusUpdated(value);
              }
              setState(() {
                _iconStatus = value;
              });
            },
          ),
        ),
      ],
    );
  }
}
