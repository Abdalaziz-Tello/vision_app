// ignore: must_be_immutable
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class DialogScreen extends StatelessWidget {
  DialogScreen({super.key});

  TextEditingController projectNameController = TextEditingController();
  TextEditingController projectTypeController = TextEditingController();
  TextEditingController projectDescrabtionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Dialog(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Text(
              'انشأ مشروعك الأول',
              style: TextStyle(
                fontSize: 24,
                color: Color(0XFF3A433E),
                fontWeight: FontWeight.bold,
              ),
            ),
            CustomTextField(
              controller: projectNameController,
              hintText: 'مشروع منصة استيراد وتصدير',
              title: 'اسم المشروع',
            ),
            CustomTextField(
              controller: projectTypeController,
              hintText: 'برمجة ويب',
              title: 'مجال المشروع',
            ),
            CustomTextField(
              controller: projectDescrabtionController,
              hintText: 'منصة لاستيراد و تصدير القطع الصناعية و صمامات النفط ',
              title: 'وصف المشروع',
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "إضافة مرفقات",
                  style: TextStyle(fontSize: 22, color: Color(0XFF3A433E)),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AddAttachments(
                  onTap: () async {
                    await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['pdf'],
                      allowMultiple: true,
                    );
                  },
                  title: "إضافة ملفات",
                  icon: Icons.file_present_outlined,
                ),
                AddAttachments(
                  onTap: () async {
                    await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['pdf'],
                      allowMultiple: true,
                    );
                  },
                  title: "إضافة صورة غلاف",
                  icon: Icons.photo_size_select_actual_outlined,
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "طالب جامعي",
                  style: TextStyle(
                    fontSize: 22,

                    color: Color.fromRGBO(45, 51, 47, 1),
                  ),
                ),
                Checkbox(value: true, onChanged: (val) {}, side: BorderSide()),
              ],
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),

                      color: Color.fromRGBO(33, 193, 242, 1),
                    ),
                    child: Center(
                      child: Text(
                        "رفع",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class AddAttachments extends StatelessWidget {
  const AddAttachments({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 212,
        height: 170,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Color.fromRGBO(166, 181, 172, 1), width: 2),
        ),
        child: Column(
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

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.title,
    required this.controller,
  });

  final String title;
  final String hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 22, color: Color(0XFF3A433E)),
              ),
              SizedBox(width: 2),
              Text("*", style: TextStyle(fontSize: 22, color: Colors.red)),
            ],
          ),
          Container(
            width: 1008,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color.fromRGBO(228, 228, 228, 1),
            ),
            child: TextField(
              controller: controller,
              textAlign: TextAlign.end,
              decoration: InputDecoration(
                hintText: hintText,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}