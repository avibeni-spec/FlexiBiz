import 'package:flutter/material.dart';

class FlexoraAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const FlexoraAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      toolbarHeight: 56,

      title: ClipRect(
        child: Align(
          alignment: Alignment.center,
          heightFactor: 0.45, // ✅ חיתוך padding אנכי
          child: Image.asset(
            'assets/flexora_icon.png',
            height: 48, // ✅ גודל נראה בפועל
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}