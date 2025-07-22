import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:vision_app/core/res/app_string.dart';
import 'package:vision_app/core/res/color/app_colors.dart';
import 'package:vision_app/core/shared/widgets/project_network_image.dart';

class AttachmentPicker extends StatefulWidget {
  final String title;
  final IconData icon;
  final PlatformFile? initialFile;
  final void Function(PlatformFile)? onPicked;
  final bool isPdf; // true = PDF, false = Image

  const AttachmentPicker({
    super.key,
    required this.title,
    required this.icon,
    this.initialFile,
    required this.onPicked,
    this.isPdf = false,
  });

  @override
  _AttachmentPickerState createState() => _AttachmentPickerState();
}

class _AttachmentPickerState extends State<AttachmentPicker> {
  PlatformFile? _file;

  @override
  void initState() {
    super.initState();
    _file = widget.initialFile;
  }

  Future<void> _pick() async {
    final type = //widget.isPdf ?
        FileType.custom; //: FileType.image;
    final result = await FilePicker.platform.pickFiles(
      type: type,
      allowMultiple: false,
      allowedExtensions: widget.isPdf
          ? ['pdf']
          : ['jpg', 'png', 'bmp', 'webp'], // No SVG/ 'jpeg' /  'gif'
      withData: true, // required to load .bytes
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() => _file = result.files.first);
      if (widget.onPicked != null) {
        widget.onPicked!(_file!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasFile = _file != null;

    return InkWell(
      onTap: widget.onPicked == null ? null : _pick,
      child: Container(
        width: 300,
        height: 150,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.gray200),
          borderRadius: BorderRadius.circular(12),
        ),
        child: hasFile
            ? (widget.isPdf
                  ? _buildPdfPreview(_file!)
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: _buildImagePreview(_file!),
                    ))
            : _buildPlaceholder(),
      ),
    );
  }

  //TODO : this don't accept the SVG files (flutter_svg package ) need to use ?
  Widget _buildImagePreview(PlatformFile file) {
    if (file.bytes != null) {
      return Image.memory(
        file.bytes!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    } else if (file.path != null && file.path!.startsWith('http')) {
      // return Image.network(
      //   file.path!,
      //   fit: BoxFit.fill,
      //   width: double.infinity,
      //   height: double.infinity,
      // );
      return ProjectNetworkImage(
        imageUrl: file.path!,
        borderRadius: 12,
        height: double.infinity,
      );
    } else {
      return Center(
        child: Icon(Icons.broken_image, size: 40, color: AppColors.gray200),
      );
    }
  }

  Widget _buildPdfPreview(PlatformFile file) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          file.name,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 14),
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(widget.icon, size: 40, color: AppColors.gray600),
          const SizedBox(height: 8),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: '',
              style: TextStyle(color: AppColors.gray600, fontSize: 14),
              children: [
                if (widget.title == AppString.addCoverImage)
                  const TextSpan(
                    text: ' * ',
                    style: TextStyle(color: AppColors.redColor),
                  ),
                TextSpan(text: widget.title),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
