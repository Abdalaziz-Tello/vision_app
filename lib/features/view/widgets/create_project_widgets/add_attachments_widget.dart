import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // Needed for kIsWeb

// class AddAttachments extends StatelessWidget {
//   const AddAttachments({
//     super.key,
//     required this.title,
//     required this.icon,
//     required this.onTap,
//     this.previewFile,
//     this.width = 212,
//   });

//   final String title;
//   final IconData icon;
//   final void Function()? onTap;
//   final PlatformFile? previewFile;
//   final double? width;

//   @override
//   Widget build(BuildContext context) {
//     final hasPreview = previewFile != null;
//     final isPdf = hasPreview && previewFile!.extension?.toLowerCase() == 'pdf';
//     final isImage = hasPreview && !isPdf;

//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         width:212, //width,// 212,//!fix this
//         height: 170,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//           border: Border.all(
//             color: AppColors.checkboxInactiveGreyFill,
//             width: 1,
//           ),
//         ),
//         child: hasPreview
//             ? isPdf
//                   ? _buildPdfPlaceholder()
//                   : isImage
//                   ? _buildImagePreview()
//                   : _buildPlaceholder()
//             : _buildPlaceholder(),
//       ),
//     );
//   }

//   Widget _buildPlaceholder() => Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       Icon(icon, size: 50, color: AppColors.grayGreen400),
//       Text(
//         title,
//         style: TextStyle(fontSize: 26, color: AppColors.grayGreen400),
//       ),
//     ],
//   );

//   Widget _buildImagePreview() {
//     try {
//       return ClipRRect(
//         borderRadius: BorderRadius.circular(15),
//         child: kIsWeb
//             ? previewFile!.bytes != null
//                   ? Image.memory(
//                       previewFile!.bytes!,
//                       fit: BoxFit.cover,
//                       width: double.infinity,
//                       height: double.infinity,
//                     )
//                   : _buildPlaceholder()
//             : previewFile!.path != null
//             ? Image.file(
//                 File(previewFile!.path!),
//                 fit: BoxFit.cover,
//                 width: double.infinity,
//                 height: double.infinity,
//               )
//             : previewFile!.bytes != null
//             ? Image.memory(
//                 previewFile!.bytes!,
//                 fit: BoxFit.cover,
//                 width: double.infinity,
//                 height: double.infinity,
//               )
//             : _buildPlaceholder(),
//       );
//     } catch (e) {
//       debugPrint('Error loading image: $e');
//       return _buildPlaceholder();
//     }
//   }

//   Widget _buildPdfPlaceholder() => Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       Icon(Icons.picture_as_pdf, size: 50, color: Colors.red),
//       const SizedBox(height: 8),
//       Text(
//         previewFile?.name ?? 'PDF Document',
//         style: const TextStyle(fontSize: 16),
//         maxLines: 1,
//         overflow: TextOverflow.ellipsis,
//       ),
//     ],
//   );
// }

class AttachmentPicker extends StatefulWidget {
  final String title;
  final IconData icon;
  final PlatformFile? initialFile;
  final void Function(PlatformFile) onPicked;
  final bool isPdf; // true = PDF, false = Image

  const AttachmentPicker({
    Key? key,
    required this.title,
    required this.icon,
    this.initialFile,
    required this.onPicked,
    this.isPdf = false,
  }) : super(key: key);

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
    final type = widget.isPdf ? FileType.custom : FileType.image;
    final result = await FilePicker.platform.pickFiles(
      type: type,
      allowMultiple: false,
      allowedExtensions: widget.isPdf ? ['pdf'] : null,
      withData: true, // required to load .bytes
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() => _file = result.files.first);
      widget.onPicked(_file!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasFile = _file != null;

    return InkWell(
      onTap: _pick,
      child: Container(
        width: 200,
        height: 150,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
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

  Widget _buildImagePreview(PlatformFile file) {
    if (file.bytes != null) {
      return Image.memory(
        file.bytes!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    } else if (file.path != null && file.path!.startsWith('http')) {
      return Image.network(
        file.path!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    } else {
      return Center(
        child: Icon(Icons.broken_image, size: 40, color: Colors.grey),
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
          Icon(widget.icon, size: 40, color: Colors.grey),
          const SizedBox(height: 8),
          Text(widget.title, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
