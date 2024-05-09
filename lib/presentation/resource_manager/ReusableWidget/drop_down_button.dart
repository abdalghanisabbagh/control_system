import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../../../domain/controllers/dropdown_controller.dart';

class MultiSelectDropDownView extends GetView<MultiSelectDropDownController> {
  const MultiSelectDropDownView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiSelectDropDown(
      onOptionSelected: controller.onOptionSelected,
      options: controller.options,
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
