import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class FilePickerButton extends StatelessWidget {
  final Function(PlatformFile) onFileSelected;

  const FilePickerButton({super.key, required this.onFileSelected});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.attach_file),
      onPressed: () async {
        final result = await FilePicker.platform.pickFiles();
        if (result != null) {
          onFileSelected(result.files.first);
        }
      },
    );
  }
}