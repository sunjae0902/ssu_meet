import 'package:flutter/material.dart';

import 'package:ssu_meet/pages/responsive_page.dart';

class ViewPurchased extends StatelessWidget {
  const ViewPurchased({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(239, 239, 239, 1),
        shadowColor: const Color.fromRGBO(158, 156, 156, 1),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.keyboard_arrow_left,
            color: Color(0xff717171),
            size: 30,
          ),
        ),
      ),
    );
  }
}
