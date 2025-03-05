import 'package:cray/utils/base_colors.dart';
import 'package:flutter/material.dart';

class CustomSwitchButton extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool> onChanged;

  const CustomSwitchButton({
    super.key,
    this.initialValue = false,
    required this.onChanged,
  });

  @override
  State<CustomSwitchButton> createState() => _CustomSwitchButtonState();
}

class _CustomSwitchButtonState extends State<CustomSwitchButton> {
  bool isSwitched = false;

  @override
  void initState() {
    super.initState();
    isSwitched = widget.initialValue;
  }

  void toggleSwitch() {
    setState(() {
      isSwitched = !isSwitched;
    });
    widget.onChanged(isSwitched);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleSwitch,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 40,
        height: 21,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black, width: 2),
          color: BaseColors.lightGreen,
        ),
        child: Align(
          alignment: isSwitched ? Alignment.centerRight : Alignment.centerLeft,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 19,
            height: 19,
            margin: const EdgeInsets.all(1),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
