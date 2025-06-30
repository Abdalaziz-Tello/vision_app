import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:vision_app/core/res/color/app_colors.dart';
import 'package:flutter/foundation.dart'; // Needed for kIsWeb

class AddAttachments extends StatelessWidget {
  const AddAttachments({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.previewFile,
  });

  final String title;
  final IconData icon;
  final void Function()? onTap;
  final PlatformFile? previewFile;

  @override
  Widget build(BuildContext context) {
    final hasPreview = previewFile != null;
    final isPdf = hasPreview && previewFile!.extension?.toLowerCase() == 'pdf';
    final isImage = hasPreview && !isPdf;

    return InkWell(
      onTap: onTap,
      child: Container(
        width: 212,
        height: 170,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: AppColors.checkboxInactiveGreyFill,
            width: 1,
          ),
        ),
        child: hasPreview
            ? isPdf
                  ? _buildPdfPlaceholder()
                  : isImage
                  ? _buildImagePreview()
                  : _buildPlaceholder() // Fallback for unknown types
            : _buildPlaceholder(),
      ),
    );
  }

  Widget _buildPlaceholder() => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(icon, size: 50, color: AppColors.grayGreen400),
      Text(
        title,
        style: TextStyle(fontSize: 26, color: AppColors.grayGreen400),
      ),
    ],
  );

  Widget _buildImagePreview() {
    try {
      return ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: kIsWeb
            ? previewFile!.bytes != null
                  ? Image.memory(
                      previewFile!.bytes!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    )
                  : _buildPlaceholder()
            : previewFile!.path != null
            ? Image.file(
                File(previewFile!.path!),
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              )
            : previewFile!.bytes != null
            ? Image.memory(
                previewFile!.bytes!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              )
            : _buildPlaceholder(),
      );
    } catch (e) {
      debugPrint('Error loading image: $e');
      return _buildPlaceholder();
    }
  }

  Widget _buildPdfPlaceholder() => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(Icons.picture_as_pdf, size: 50, color: Colors.red),
      const SizedBox(height: 8),
      Text(
        previewFile?.name ?? 'PDF Document',
        style: const TextStyle(fontSize: 16),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    ],
  );
}
