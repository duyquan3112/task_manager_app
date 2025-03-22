import 'package:flutter/material.dart';
import 'package:task_manager_app/common/colors.dart';

class SearchTextFieldWidget extends StatelessWidget {
  const SearchTextFieldWidget({
    super.key,
    required this.controller,
    this.onSearch,
  });

  final TextEditingController controller;
  final Function(String)? onSearch;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: UIColors.instance.blurBackgroundColor.withValues(alpha: 0.1),
            blurRadius: 5,
            offset: Offset(1, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onSearch,
        onTapOutside: (ev) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        decoration: InputDecoration(
          hintText: "Search by title",
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: UIColors.instance.whiteColor, // Màu nền nhẹ nhàng
        ),
      ),
    );
  }
}
