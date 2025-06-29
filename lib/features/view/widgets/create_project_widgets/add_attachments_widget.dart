import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

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
    final hasPreview = previewFile != null && previewFile!.path != null;

    return InkWell(
      onTap: onTap,
      child: Container(
        width: 212,
        height: 170,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Color.fromRGBO(166, 181, 172, 1), width: 2),
        ),
        child: hasPreview
            ? ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.file(
                  File(previewFile!.path!),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 50, color: Color.fromRGBO(166, 181, 172, 1)),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 26,
                      color: Color.fromRGBO(166, 181, 172, 1),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}