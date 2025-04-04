import 'package:flutter/material.dart';

class ReusableButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget label;
  const ReusableButton(
      {super.key, required this.onPressed, required this.label});

  @override
  Widget build(BuildContext context) {
    //TODO: fix button disappear when the state is disabled
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 55),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4 /*10*/),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        disabledBackgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      ),
      onPressed: onPressed,
      child: label,
    );
  }
}
