import 'package:flutter/material.dart';
import '../constants/app_color.dart';

class MainAppbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  final int gemas;
  final String userName;

  const MainAppbar({super.key, required this.gemas, required this.userName});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const SizedBox.shrink(),
      actions: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: const Color(0xFFDDD6FE),
            borderRadius: BorderRadius.circular(2),
            border: Border.all(
              color: AppColor.secundaryColor,
              width: 2,
            ),
          ),
          child: const Icon(Icons.person, size: 22, color: AppColor.primaryColor),
        ),
        const SizedBox(width: 8),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(userName, style: const TextStyle(fontSize: 15)),
          ],
        ),
        const SizedBox(width: 12),
        Container(
          width: 28,
          height: 28,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/gema.png'),
            ),
          ),
        ),
        const SizedBox(width: 6),
        Text('$gemas', style: const TextStyle(fontSize: 15, color: AppColor.gemColor)),
        const SizedBox(width: 12),
      ],
    );
  }
}
