import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'add_attachments_widget.dart';
import 'package:vision_app/core/res/app_string.dart';

class PdfPickerWidget extends StatefulWidget {
  final void Function(List<PlatformFile>) onFilesPicked;

  const PdfPickerWidget({super.key, required this.onFilesPicked});

  @override
  State<PdfPickerWidget> createState() => _PdfPickerWidgetState();
}

class _PdfPickerWidgetState extends State<PdfPickerWidget> {
  Future<void> _pickFiles() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        allowMultiple: true,
      );
      if (result != null) {
        widget.onFilesPicked(result.files);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking files: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AddAttachments(
      onTap: _pickFiles,
      title: AppString.addFiles,
      icon: Icons.file_present_outlined,
    );
  }
}
