import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'add_attachments_widget.dart';
import 'package:vision_app/core/res/app_string.dart';

class CoverImagePickerWidget extends StatefulWidget {
  final void Function(PlatformFile?) onImagePicked;
  final PlatformFile? currentImage;

  const CoverImagePickerWidget({
    super.key,
    required this.onImagePicked,
    this.currentImage,
  });

  @override
  State<CoverImagePickerWidget> createState() => _CoverImagePickerWidgetState();
}

class _CoverImagePickerWidgetState extends State<CoverImagePickerWidget> {
  Future<void> _pickCoverImage() async {
    try {
      final result = await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null && result.files.isNotEmpty) {
        widget.onImagePicked(result.files.first);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AddAttachments(
      onTap: _pickCoverImage,
      title: AppString.addCoverImage,
      icon: Icons.photo_size_select_actual_outlined,
      previewFile: widget.currentImage,
    );
  }
}
