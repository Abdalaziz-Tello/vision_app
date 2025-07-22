import 'package:flutter/material.dart';
import 'package:vision_app/core/res/color/app_colors.dart';
import 'package:vision_app/core/shared/widgets/lable_row.dart';
//for the drop button :

class TextWithExpansionTileSelector extends StatelessWidget {
  final String? label;
  final String selectedValue;
  final List<String> options;
  final Function(String) onSelected;
  final double widthOfExpansionTile;
  final Color? textColor;
  final Color? primaryColor;

  const TextWithExpansionTileSelector({
    super.key,
    this.label,
    required this.selectedValue,
    required this.options,
    required this.onSelected,
    this.widthOfExpansionTile = double.infinity,
    this.textColor,
    this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null) LableRow(title: label!),
          const SizedBox(height: 10),
          Container(
            width: widthOfExpansionTile,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Color.fromRGBO(228, 228, 228, 1)),
              color: primaryColor ?? const Color.fromRGBO(228, 228, 228, 1),
            ),
            child: MyExpansionTile(
              text1: selectedValue,
              primaryColor:
                  primaryColor ?? const Color.fromRGBO(228, 228, 228, 1),
              options: options,
              onSelected: onSelected,
              textColor: textColor,
            ),
          ),
        ],
      ),
    );
  }
}

//_______________________________________________________________

class MyExpansionTile extends StatefulWidget {
  final String text1;
  final List<String> options;
  final Color primaryColor;
  final Function(String) onSelected;
  final Color? textColor;

  const MyExpansionTile({
    super.key,
    required this.text1,
    required this.options,
    required this.primaryColor,
    required this.onSelected,
    this.textColor,
  });

  @override
  State<MyExpansionTile> createState() => _MyExpansionTileState();
}

class _MyExpansionTileState extends State<MyExpansionTile> {
  Key tileKey = UniqueKey();

  void _resetTile() {
    setState(() {
      tileKey = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      key: tileKey,
      title: Text(widget.text1, style: TextStyle(color: widget.textColor)),
      backgroundColor: widget.primaryColor,
      collapsedBackgroundColor: widget.primaryColor,
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      textColor: AppColors.grayGreen400,
      iconColor: AppColors.grayGreen400,
      children: [
        // Scrollable list limited in height
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 200), // adjust height
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.options.length,
            itemBuilder: (context, index) {
              final option = widget.options[index];
              return ListTile(
                title: Text(option),
                onTap: () {
                  widget.onSelected(option);
                  _resetTile();
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
