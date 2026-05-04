import 'package:flutter/material.dart';

class LeagueAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LeagueAppBar({
    required this.onAdminTap,
    required this.isAdminLoggedIn,
    super.key,
  });

  final VoidCallback onAdminTap;
  final bool isAdminLoggedIn;

  @override
  Size get preferredSize => const Size.fromHeight(88);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 88,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleSpacing: 20,
      title: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0x26FFFFFF),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0x3DFFFFFF)),
            ),
            child: const Icon(Icons.shield_outlined, color: Colors.white),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TSHWANE REGIONAL',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.1,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'FOOTBALL ASSOCIATION',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF17944A), Color(0xFF0B5D2A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      actions: [
        TextButton.icon(
          onPressed: onAdminTap,
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color(0x1FFFFFFF),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: const BorderSide(color: Color(0x40FFFFFF)),
            ),
          ),
          icon: Icon(
            isAdminLoggedIn
                ? Icons.admin_panel_settings
                : Icons.lock_open_outlined,
            color: Colors.white,
          ),
          label: Text(
            isAdminLoggedIn ? 'Admin' : 'Login',
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(width: 12),
      ],
    );
  }
}
