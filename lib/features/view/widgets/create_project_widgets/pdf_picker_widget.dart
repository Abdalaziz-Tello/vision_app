import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:vision_app/core/res/app_string.dart';
import 'package:vision_app/features/view/widgets/create_project_widgets/add_attachments_widget.dart';
class PdfPickerWidget extends StatefulWidget {
  final void Function(List<PlatformFile>) onFilesPicked;
  final List<PlatformFile>? currentFiles;

  const PdfPickerWidget({
    super.key,
    required this.onFilesPicked,
    this.currentFiles,
  });

  @override
  State<PdfPickerWidget> createState() => _PdfPickerWidgetState();
}

class _PdfPickerWidgetState extends State<PdfPickerWidget> {
  List<PlatformFile> _selectedFiles = [];

  Future<void> _pickFiles() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        allowMultiple: true,
        withData: true,
      );

      if (result == null || result.files.isEmpty) return;

      // Validate all files
      for (final file in result.files) {
        if (file.bytes == null && file.path == null) {
          throw Exception('Invalid PDF file: ${file.name}');
        }
      }

      setState(() => _selectedFiles = result.files);
      widget.onFilesPicked(result.files);
    } catch (e, stack) {
      debugPrint('PDF picker error: $e\n$stack');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to select PDF')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasFiles = _selectedFiles.isNotEmpty ||
                     (widget.currentFiles?.isNotEmpty ?? false);
    final displayFile = _selectedFiles.isNotEmpty
        ? _selectedFiles.first
        : widget.currentFiles?.first;

    return AddAttachments(
      onTap: _pickFiles,
      title: hasFiles ? "PDF Selected" : AppString.addFiles,
      icon: Icons.file_present_outlined,
      previewFile: displayFile,
    );
  }
}