import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class MultiSelectDropDownView extends StatelessWidget {
  final void Function(List<ValueItem<dynamic>>)? onOptionSelected;

  final String hintText;
  final bool multiSelect;
  final List<ValueItem<dynamic>> optionSelected;
  final List<ValueItem<dynamic>> options;
  final bool searchEnabled;
  final bool showChipSelect;
  const MultiSelectDropDownView({
    super.key,
    this.onOptionSelected,
    required this.options,
    this.searchEnabled = false,
    this.multiSelect = false,
    this.showChipSelect = false,
    this.hintText = "Search",
    this.optionSelected = const [],
  });

  @override
  Widget build(BuildContext context) {
    return MultiSelectDropDown(
      selectedOptions: optionSelected,
      borderWidth: 2,
      focusedBorderWidth: 5,
      onOptionSelected: onOptionSelected,
      options: options,
      selectedItemBuilder: showChipSelect
          ? null
          : (_, __) {
              return const SizedBox.shrink();
            },
      selectionType: multiSelect ? SelectionType.multi : SelectionType.single,
      chipConfig: const ChipConfig(
        wrapType: WrapType.wrap,
        autoScroll: true,
      ),
      optionTextStyle: const TextStyle(fontSize: 16),
      selectedOptionIcon: const Icon(Icons.check_circle),
      searchEnabled: searchEnabled,
      searchLabel: "Search",
      showChipInSingleSelectMode: showChipSelect,
      hint: hintText,
    );
  }
}
