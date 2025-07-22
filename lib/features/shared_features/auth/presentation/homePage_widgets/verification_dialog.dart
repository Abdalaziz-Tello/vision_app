import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vision_app/core/res/app_string.dart';
import 'package:vision_app/core/res/color/app_colors.dart';

class VerificationDialog extends StatelessWidget {
  const VerificationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.reallyWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 300, minHeight: 200),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.mark_email_read_outlined,
                    color: AppColors.lightBlue,
                  ),
                  SizedBox(width: 8),
                  Text(
                    AppString.checkEmail,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                AppString
                    .emailConfirmationSent, // 'لقد أرسلنا رابط تأكيد إلى بريدك الإلكتروني.\nيرجى فتحه لتفعيل الحساب.',,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.lightBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  AppString.ok,
                  style: TextStyle(color: AppColors.whiteColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
