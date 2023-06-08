import 'package:akilabanq/utils/constant/color.dart';
import 'package:flutter/material.dart';

class AppSliderDotIndicator extends StatelessWidget {
  final List<int> _indexes;
  final int selectedIndex;

  AppSliderDotIndicator({required this.selectedIndex, required int itemCount})
      : _indexes = [] {
    for (int i = 0; i < itemCount; i++) {
      _indexes.add(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _indexes.map((index) {
        return _createIndicator(index == selectedIndex);
      }).toList(),
    );
  }

  Widget _createIndicator(bool isSelected) {
    return Container(
      height: 8.0,
      width: 8.0,
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border:
        isSelected ? null : Border.all(color: Colors.transparent, width: 2),
        color: isSelected ? AppColors.orange : AppColors.lightGrey,
      ),
    );
  }
}

