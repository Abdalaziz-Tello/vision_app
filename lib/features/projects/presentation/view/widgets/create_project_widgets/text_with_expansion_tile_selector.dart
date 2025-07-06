import 'package:flutter/material.dart';
import 'package:vision_app/core/res/color/app_colors.dart';
import 'package:vision_app/features/projects/presentation/view/widgets/create_project_widgets/lable_row.dart';
//for the drop button :

// class TextWithExpansionTileSelector extends StatelessWidget {
//   final String label;
//   final String selectedValue;
//   final List<String> options;
//   final Function(String) onSelected;
//   final double widthOfExpansionTile;

//   const TextWithExpansionTileSelector({
//     super.key,
//     required this.label,
//     required this.selectedValue,
//     required this.options,
//     required this.onSelected,
//     this.widthOfExpansionTile = double.infinity,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           LableRow(title: label),
//           const SizedBox(height: 10),

//           Container(
//             width: widthOfExpansionTile,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8),
//               color: const Color.fromRGBO(228, 228, 228, 1),
//             ),
//             child: MyExpansionTile(
//               text1: selectedValue,
//               primaryColor: const Color.fromRGBO(228, 228, 228, 1),
//               children: options.map((option) {
//                 return ListTile(
//                   title: Text(option),
//                   onTap: () => onSelected(option),
//                 );
//               }).toList(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// //____________________________________
// class MyExpansionTile extends StatefulWidget {
//   final String text1;
//   final List<Widget> children;
//   final Color primaryColor;

//   const MyExpansionTile({
//     super.key,
//     required this.text1,
//     required this.children,
//     required this.primaryColor,
//   });

//   @override
//   State<MyExpansionTile> createState() => _MyExpansionTileState();
// }

// class _MyExpansionTileState extends State<MyExpansionTile> {
//   Key tileKey = UniqueKey();

//   void _resetTile() {
//     setState(() {
//       tileKey = UniqueKey(); // reset tile to collapse after selection
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final updatedChildren = widget.children.map((child) {
//       if (child is ListTile && child.onTap != null) {
//         return ListTile(
//           title: child.title,
//           onTap: () {
//             child.onTap!();
//             _resetTile();
//           },
//         );
//       }
//       return child;
//     }).toList();

//     return ExpansionTile(
//       key: tileKey,
//       title: Text(widget.text1),
//       backgroundColor: widget.primaryColor,
//       collapsedBackgroundColor: widget.primaryColor,
//       collapsedShape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8),
//       ),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       textColor: AppColors.grayGreen400,
//       iconColor: AppColors.grayGreen400,
//       children: updatedChildren,
//     );
//   }
// }

class MyExpansionTile extends StatefulWidget {
  final String text1;
  final List<String> options;
  final Color primaryColor;
  final Function(String) onSelected;

  const MyExpansionTile({
    super.key,
    required this.text1,
    required this.options,
    required this.primaryColor,
    required this.onSelected,
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
      title: Text(widget.text1),
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

class TextWithExpansionTileSelector extends StatelessWidget {
  final String label;
  final String selectedValue;
  final List<String> options;
  final Function(String) onSelected;
  final double widthOfExpansionTile;

  const TextWithExpansionTileSelector({
    super.key,
    required this.label,
    required this.selectedValue,
    required this.options,
    required this.onSelected,
    this.widthOfExpansionTile = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LableRow(title: label),
          const SizedBox(height: 10),
          Container(
            width: widthOfExpansionTile,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color.fromRGBO(228, 228, 228, 1),
            ),
            child: MyExpansionTile(
              text1: selectedValue,
              primaryColor: const Color.fromRGBO(228, 228, 228, 1),
              options: options,
              onSelected: onSelected,
            ),
          ),
        ],
      ),
    );
  }
}
