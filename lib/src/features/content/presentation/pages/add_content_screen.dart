import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loggy/loggy.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class AddContentScreen extends StatelessWidget with UiLoggy {
  const AddContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Add Content'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
          child: Text(
            'Select a Video',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          onPressed: () async {
            _handleVideo();
          },
        ),
      ),
    );
  }

  Future<void> _handleVideo() async {
    XFile? uploadedVideo =
        await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (uploadedVideo == null) {
      return;
    }
    final directory = await getApplicationDocumentsDirectory();
    final fileName = basename(uploadedVideo.path);
    final savedVideo =
        await File(uploadedVideo.path).copy('${directory.path}/$fileName');
    loggy.debug(savedVideo);
  }
}
