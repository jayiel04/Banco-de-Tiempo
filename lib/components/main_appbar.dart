import 'package:flutter/material.dart';
import '../constants/app_color.dart';

class MainAppbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  final int gemas;
  final String userName;
  final int focusSeconds;
  final int restSeconds;
  final VoidCallback? onAvatarTap;

  const MainAppbar({
    super.key,
    required this.gemas,
    required this.userName,
    required this.focusSeconds,
    required this.restSeconds,
    this.onAvatarTap,
  });

  String _formatTime(int seconds) {
    final h = seconds ~/ 3600;
    final m = (seconds % 3600) ~/ 60;
    if (h > 0) return '${h}h ${m}m';
    return '${m}m';
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const SizedBox.shrink(),
      actions: [
        GestureDetector(
          onTap: onAvatarTap,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
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
            ],
          ),
        ),
        const SizedBox(width: 12),
        const Icon(Icons.timer_outlined, size: 18, color: AppColor.timeColor),
        const SizedBox(width: 4),
        Text(
          _formatTime(focusSeconds),
          style: const TextStyle(fontSize: 13, color: AppColor.timeColor),
        ),
        const SizedBox(width: 10),
        const Icon(Icons.free_breakfast, size: 18, color: AppColor.gemColor),
        const SizedBox(width: 4),
        Text(
          _formatTime(restSeconds),
          style: const TextStyle(fontSize: 13, color: AppColor.gemColor),
        ),
        const SizedBox(width: 10),
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
        const SizedBox(width: 8),
      ],
    );
  }
}
