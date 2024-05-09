// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class MultiSelectDropDownView extends StatelessWidget {
  const MultiSelectDropDownView({
    super.key,
    this.onOptionSelected,
    required this.options,
  });

  final void Function(List<ValueItem<dynamic>>)? onOptionSelected;
  final List<ValueItem<dynamic>> options;
  @override
  Widget build(BuildContext context) {
    return MultiSelectDropDown(
      onOptionSelected: onOptionSelected,
      options: options,
      selectionType: SelectionType.multi,
      chipConfig: const ChipConfig(
        wrapType: WrapType.wrap,
        autoScroll: true,
      ),
      optionTextStyle: const TextStyle(fontSize: 16),
      selectedOptionIcon: const Icon(Icons.check_circle),
      searchEnabled: true,
      searchLabel: "Search",
      showChipInSingleSelectMode: true,
    );
  }
}
