import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircleAvatar(
          radius: 55,
        ),
        Text(
          'Posty',
          style: GoogleFonts.berkshireSwash(
              fontSize: 48, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
