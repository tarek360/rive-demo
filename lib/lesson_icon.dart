import 'dart:io';

import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LessonScreen extends StatefulWidget {
  const LessonScreen({Key? key}) : super(key: key);

  @override
  _LessonScreenState createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  _IconStatus _status = _IconStatus.disabledLight;
  String? _filePath;
  String? _fileName;

  bool _dragging = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      appBar: AppBar(
        title: const Text('Lesson Icon'),
      ),
      body: Center(
        child: Column(
          children: [
            _RadioButtons(
              _status,
              (iconsStatus) {
                setState(() {
                  _status = iconsStatus;
                });
              },
            ),
            const SizedBox(height: 8),
            if (Platform.isMacOS)
              DropTarget(
                onDragDone: (detail) {
                  if (detail.files.isNotEmpty) {
                    setState(() {
                      final file = detail.files.first;
                      _filePath = file.path;
                      _fileName = file.name;
                    });
                  }
                },
                onDragEntered: (detail) {
                  setState(() {
                    _dragging = true;
                  });
                },
                onDragExited: (detail) {
                  setState(() {
                    _dragging = false;
                  });
                },
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    color: _filePath != null
                        ? null
                        : _dragging
                            ? Colors.blue.withOpacity(0.4)
                            : Colors.black26,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: _filePath == null
                      ? const Center(
                          child: Text(
                          "Drop here",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ))
                      : LessonIcon(iconStatus: _status, file: _filePath!),
                ),
              )
            else
              Column(
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles();
                        if (result != null) {
                          setState(() {
                            _filePath = result.files.single.path;
                          });
                        }
                      },
                      child: Text('Import')),
                  const SizedBox(height: 16),
                  if (_filePath != null)
                    LessonIcon(iconStatus: _status, file: _filePath!)
                ],
              ),
            const SizedBox(height: 8),
            if (_fileName != null) Text(_fileName!),
          ],
        ),
      ),
    );
  }
}

class LessonIcon extends StatelessWidget {
  const LessonIcon({
    required this.iconStatus,
    required this.file,
  });

  final _IconStatus iconStatus;
  final String file;

  @override
  Widget build(BuildContext context) {
    print('file $file');
    return SizedBox(
      width: 100,
      height: 100,
      child: RiveAnimation.file(
        file,
        fit: BoxFit.contain,
        onInit: _onRiveInit,
      ),
    );
  }

  void _onRiveInit(Artboard artBoard) {
    final controller = StateMachineController.fromArtboard(artBoard, 'default');
    artBoard.addController(controller!);
    controller.findInput<double>('status')?.value =
        iconStatus.index.toDouble() + 1;
  }
}

enum _IconStatus {
  disabledLight,
  disabledDark,
  active,
  finished,
}

class _RadioButtons extends StatelessWidget {
  const _RadioButtons(this._iconStatus, this.onIconStatusUpdated);

  final _IconStatus _iconStatus;
  final void Function(_IconStatus) onIconStatusUpdated;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        RadioListTile<_IconStatus>(
          title: const Text('disabled_light'),
          value: _IconStatus.disabledLight,
          groupValue: _iconStatus,
          onChanged: (value) {
            if (value != null) {
              onIconStatusUpdated(value);
            }
          },
        ),
        RadioListTile<_IconStatus>(
          title: const Text('disabled_dark'),
          value: _IconStatus.disabledDark,
          groupValue: _iconStatus,
          onChanged: (value) {
            if (value != null) {
              onIconStatusUpdated(value);
            }
          },
        ),
        RadioListTile<_IconStatus>(
          title: const Text('active'),
          value: _IconStatus.active,
          groupValue: _iconStatus,
          onChanged: (value) {
            if (value != null) {
              onIconStatusUpdated(value);
            }
          },
        ),
        RadioListTile<_IconStatus>(
          title: const Text('finished'),
          value: _IconStatus.finished,
          groupValue: _iconStatus,
          onChanged: (value) {
            if (value != null) {
              onIconStatusUpdated(value);
            }
          },
        ),
      ],
    );
  }
}
