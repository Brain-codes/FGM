// ignore_for_file: prefer_const_constructors

import 'package:FGM/shared/constants/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({super.key, this.title = ''});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: InkWell(
        borderRadius: BorderRadius.circular(80),
        onTap: () => Navigator.of(context).pop(),
        child: SvgPicture.asset(
          AppIcons.backArrow,
          fit: BoxFit.scaleDown,
        ),
      ),
      centerTitle: true,
      // title: Text(
      //   title,
      //   style: GoogleFonts.outfit(
      //     color: Color(0xff161616),
      //     fontWeight: FontWeight.w600,
      //     fontSize: 16,
      //   ),
      // ),
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 56);
}
