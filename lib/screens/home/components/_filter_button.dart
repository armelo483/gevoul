import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  final String label;
  final bool isActive;

  const FilterButton({required this.label, this.isActive = false, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive ? Colors.green : Colors.grey.shade200,
        foregroundColor: isActive ? Colors.white : Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Text(label),
    );
  }
}
