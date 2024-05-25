// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
//
// class CustomDropDownBtn extends StatelessWidget {
//   final List<String> items;
//   final String selectedItemText;
//   final Function(String?) onSelected;
//   final String? selectedValue;
//
//   const CustomDropDownBtn({
//     super.key,
//     required this.items,
//     required this.selectedItemText,
//     required this.onSelected,
//     this.selectedValue,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Center(
//         child: DropdownButtonHideUnderline(
//           child: DropdownButton2<String>(
//             isExpanded: true,
//             hint: Text(
//               selectedItemText,
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Theme.of(context).hintColor,
//               ),
//             ),
//             items: items
//                 .map((String item) => DropdownMenuItem<String>(
//                       value: item,
//                       child: Text(
//                         item,
//                         style: const TextStyle(
//                           fontSize: 14,
//                         ),
//                       ),
//                     ))
//                 .toList(),
//             value: items.contains(selectedValue) ? selectedValue : null,
//             onChanged: (String? value) {
//               onSelected(value);
//             },
//
//             buttonStyleData: const ButtonStyleData(
//               padding: EdgeInsets.symmetric(horizontal: 16),
//               height: 40,
//               width: 140,
//             ),
//             menuItemStyleData: const MenuItemStyleData(
//               height: 40,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomDropDownBtn extends StatelessWidget {
  final List<String> items;
  final String selectedItemText;
  final Function(String?) onSelected;
  final String? selectedValue;
  final Function(String?)? onValueChanged;

  const CustomDropDownBtn({
    super.key,
    required this.items,
    required this.selectedItemText,
    required this.onSelected,
    this.selectedValue,
    this.onValueChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            hint: Text(
              selectedItemText,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: items
                .map((String item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ))
                .toList(),
            value: items.contains(selectedValue) ? selectedValue : null,
            onChanged: (String? value) {
              onSelected(value);
              if (onValueChanged != null) {
                onValueChanged!(value);
              }
            },
            buttonStyleData: const ButtonStyleData(
              padding: EdgeInsets.symmetric(horizontal: 16),
              height: 40,
              width: 140,
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
            ),
          ),
        ),
      ),
    );
  }
}
