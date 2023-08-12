import 'package:e_bill/admin_panel/ResponsiveLayouts/desktop_layout.dart';
import 'package:e_bill/admin_panel/ResponsiveLayouts/mobile_layout.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if(constraints.maxWidth<1000){
          return MobileLayout();
        }
        else {
        return DesktopLayout();
        }
      },
    );
  }
}