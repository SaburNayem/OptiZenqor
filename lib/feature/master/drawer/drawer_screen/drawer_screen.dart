import 'package:flutter/material.dart';
import 'package:optizenqor/app_route/app_route.dart';
import 'package:optizenqor/core/constant/app_color.dart';
import 'package:optizenqor/feature/master/drawer/drawer_controller/drawer_controller.dart';

class MasterDrawerScreen extends StatelessWidget {
  const MasterDrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = const MasterDrawerController().data;

    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            color: AppColor.primary,
            padding: const EdgeInsets.fromLTRB(20, 52, 20, 24),
            child: Column(
              children: <Widget>[
                Container(
                  width: 86,
                  height: 86,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Icon(
                    Icons.shopping_bag_rounded,
                    color: AppColor.primary,
                    size: 38,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  data.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(data.email, style: const TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: data.items.length,
              itemBuilder: (BuildContext context, int index) {
                final String item = data.items[index];

                return ListTile(
                  leading: Icon(_iconFor(item)),
                  title: Text(item),
                  onTap: () {
                    Navigator.pop(context);
                    if (item == 'Logout') {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRoute.signIn,
                        (Route<dynamic> route) => false,
                      );
                      return;
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('$item page is ready to add next'),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  IconData _iconFor(String item) {
    switch (item) {
      case 'Order History':
        return Icons.history;
      case 'Support':
        return Icons.support_agent;
      case 'Review':
        return Icons.reviews;
      case 'Help':
        return Icons.help_outline;
      case 'About Us':
        return Icons.info_outline;
      case 'Logout':
        return Icons.logout;
      default:
        return Icons.chevron_right;
    }
  }
}
