import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:vision_app/core/res/app_string.dart';
import 'package:vision_app/features/view/widgets/create_project_widgets/add_attachments_widget.dart';

class CoverImagePickerWidget extends StatefulWidget {
  final void Function(PlatformFile?) onImagePicked;
  final PlatformFile? currentImage;
  final double? width;
  const CoverImagePickerWidget({
    super.key,
    required this.onImagePicked,
    this.currentImage,
    this.width,
  });

  @override
  State<CoverImagePickerWidget> createState() => _CoverImagePickerWidgetState();
}

class _CoverImagePickerWidgetState extends State<CoverImagePickerWidget> {
  PlatformFile? _selectedImage;

  Future<void> _pickCoverImage() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        withData: true,
      );

      if (result == null || result.files.isEmpty) return;

      final file = result.files.first;
      if (file.bytes == null && file.path == null) {
        throw Exception('No image data available'); //TODO :fix this
      }

      setState(() => _selectedImage = file);
      widget.onImagePicked(file);
    } catch (e, stack) {
      debugPrint('Image picker error: $e\n$stack');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to select image')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AddAttachments(
      width: widget.width,
      onTap: _pickCoverImage,
      title: _selectedImage != null || widget.currentImage != null
          ? "Image Selected"
          : AppString.addCoverImage,
      icon: Icons.photo_size_select_actual_outlined,
      previewFile: _selectedImage ?? widget.currentImage,
    );
  }
}
