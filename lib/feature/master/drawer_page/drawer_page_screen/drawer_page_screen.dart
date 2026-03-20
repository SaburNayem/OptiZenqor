import 'package:flutter/material.dart';
import 'package:optizenqor/feature/master/drawer_page/drawer_page_controller/drawer_page_controller.dart';

class DrawerPageScreen extends StatelessWidget {
  const DrawerPageScreen({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    final data = const DrawerPageController().fromTitle(title);

    return Scaffold(
      appBar: AppBar(
        title: Text(data.title),
        backgroundColor: _appBarColor(data.title),
        foregroundColor: Colors.white,
      ),
      body: _bodyFor(data.title),
    );
  }

  Widget _bodyFor(String title) {
    switch (title) {
      case 'Order History':
        return _OrderHistoryBody();
      case 'Support':
        return _SupportBody();
      case 'Review':
        return _ReviewBody();
      case 'Help':
        return _HelpBody();
      case 'About Us':
        return _AboutUsBody();
      default:
        return const SizedBox.shrink();
    }
  }

  Color _appBarColor(String title) {
    if (title == 'Support') {
      return Colors.transparent;
    }
    if (title == 'Help' || title == 'Review' || title == 'Order History') {
      return Colors.blueAccent;
    }
    return Colors.teal;
  }
}

class _OrderHistoryBody extends StatelessWidget {
  final List<Map<String, dynamic>> orders = const <Map<String, dynamic>>[
    <String, dynamic>{
      'orderId': '#123456',
      'date': 'March 8, 2025',
      'time': '10:30 AM',
      'total': '\$45.99',
      'status': 'Delivered',
      'items': <Map<String, String>>[
        <String, String>{'name': 'Burger', 'price': '\$10.99'},
        <String, String>{'name': 'Fries', 'price': '\$5.99'},
        <String, String>{'name': 'Soda', 'price': '\$3.99'},
      ],
    },
    <String, dynamic>{
      'orderId': '#123457',
      'date': 'March 5, 2025',
      'time': '02:15 PM',
      'total': '\$28.50',
      'status': 'Cancelled',
      'items': <Map<String, String>>[
        <String, String>{'name': 'Pizza', 'price': '\$15.00'},
        <String, String>{'name': 'Garlic Bread', 'price': '\$5.50'},
        <String, String>{'name': 'Water', 'price': '\$2.00'},
      ],
    },
    <String, dynamic>{
      'orderId': '#123458',
      'date': 'March 1, 2025',
      'time': '07:45 PM',
      'total': '\$60.00',
      'status': 'Processing',
      'items': <Map<String, String>>[
        <String, String>{'name': 'Sushi', 'price': '\$30.00'},
        <String, String>{'name': 'Miso Soup', 'price': '\$10.00'},
        <String, String>{'name': 'Green Tea', 'price': '\$5.00'},
      ],
    },
  ];

  const _OrderHistoryBody();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildOrderSection('Processing', Colors.orange),
          _buildOrderSection('Delivered', Colors.green),
          _buildOrderSection('Cancelled', Colors.red),
        ],
      ),
    );
  }

  Widget _buildOrderSection(String status, Color color) {
    final filteredOrders = orders.where((Map<String, dynamic> order) {
      return order['status'] == status;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            status,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        ...filteredOrders.map((Map<String, dynamic> order) {
          final items = order['items'] as List<Map<String, String>>;
          return Card(
            child: ExpansionTile(
              title: Text(order['orderId'] as String),
              subtitle: Text(
                '${order['date']} • ${order['time']} • ${order['total']}',
              ),
              children: items.map((Map<String, String> item) {
                return ListTile(
                  title: Text(item['name']!),
                  trailing: Text(item['price']!),
                );
              }).toList(),
            ),
          );
        }),
      ],
    );
  }
}

class _SupportBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(color: const Color(0xFF20B2AA)),
        SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 20),
              const Text(
                'Contact Support',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'We\'re here to help! Reach out to us via email, phone, or submit a support ticket.',
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
              const SizedBox(height: 20),
              _card(
                icon: Icons.email,
                title: 'Email',
                subtitle: 'support@yourapp.com',
              ),
              _card(
                icon: Icons.phone,
                title: 'Phone',
                subtitle: '+1 234 567 890',
              ),
              _card(
                icon: Icons.chat,
                title: 'Live Chat',
                subtitle: 'Available 24/7 in the app.',
              ),
              const SizedBox(height: 20),
              const Text(
                'Submit a Support Ticket',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                maxLines: 4,
                decoration: const InputDecoration(labelText: 'Your Message'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _card({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Card(
      color: Colors.white.withValues(alpha: 0.15),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.white70)),
      ),
    );
  }
}

class _ReviewBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Center(
            child: Text(
              'Tell us what you think!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Rate the App',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.star, color: Colors.amber),
              Icon(Icons.star, color: Colors.amber),
              Icon(Icons.star, color: Colors.amber),
              Icon(Icons.star, color: Colors.amber),
              Icon(Icons.star_border, color: Colors.amber),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'What needs improvement?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          TextFormField(
            maxLines: 4,
            decoration: const InputDecoration(
              hintText: 'Describe the issue or improvements...',
            ),
          ),
        ],
      ),
    );
  }
}

class _HelpBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'How can we help you?',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _faq(
            'How do I reset my password?',
            'Go to settings > Account > Reset Password.',
          ),
          _faq(
            'How can I update the app?',
            'Check the Play Store/App Store for updates.',
          ),
          _faq(
            'How do I change my username?',
            'Go to settings > Edit Profile > Change Username.',
          ),
          _faq(
            'How do I enable notifications?',
            'Go to settings > Notifications and enable alerts.',
          ),
          _faq(
            'App is crashing?',
            'Try restarting your device or reinstalling the app.',
          ),
          _faq(
            'Cannot login?',
            'Check your internet connection and reset password if needed.',
          ),
          _faq(
            'Why is my screen freezing?',
            'Ensure your app is updated and restart your phone.',
          ),
        ],
      ),
    );
  }

  Widget _faq(String question, String answer) {
    return Card(
      child: ExpansionTile(
        title: Text(question),
        children: <Widget>[
          Padding(padding: const EdgeInsets.all(16), child: Text(answer)),
        ],
      ),
    );
  }
}

class _AboutUsBody extends StatelessWidget {
  final List<Map<String, String>> teamMembers = const <Map<String, String>>[
    <String, String>{'name': 'Md Nayem Hossen', 'role': 'Founder & CEO'},
    <String, String>{'name': 'Jannatul Mawa', 'role': 'Co-Founder & COO'},
    <String, String>{'name': 'Samia Islam', 'role': 'CMO'},
    <String, String>{'name': 'Asaduzzaman', 'role': 'CTO'},
    <String, String>{'name': 'Ariyan Shakib', 'role': 'Lead Designer'},
    <String, String>{'name': 'Chinmoy Roy', 'role': 'Project Manager'},
  ];

  const _AboutUsBody();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const CircleAvatar(radius: 30, child: Icon(Icons.storefront)),
          const SizedBox(height: 10),
          const Text(
            'Your App Name',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          const Text(
            'Version: 1.0.0',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'This app is designed to help users with [your app’s purpose]. We aim to provide the best experience for our users.',
          ),
          const SizedBox(height: 20),
          _section('Our Mission', const <Widget>[
            Text(
              'To provide the best experience for our users by delivering innovative solutions that simplify their daily tasks.',
            ),
          ]),
          _section('App Features', const <Widget>[
            ListTile(leading: Icon(Icons.thumb_up), title: Text('Easy to Use')),
            ListTile(leading: Icon(Icons.security), title: Text('Secure')),
            ListTile(
              leading: Icon(Icons.speed),
              title: Text('Fast Performance'),
            ),
            ListTile(
              leading: Icon(Icons.support_agent),
              title: Text('24/7 Support'),
            ),
          ]),
          _section(
            'Our Team',
            teamMembers.map((Map<String, String> member) {
              return ListTile(
                leading: const CircleAvatar(child: Icon(Icons.person)),
                title: Text(member['name']!),
                subtitle: Text(member['role']!),
              );
            }).toList(),
          ),
          _section('Contact Us', const <Widget>[
            ListTile(
              title: Text('Email'),
              subtitle: Text('support@yourapp.com'),
            ),
            ListTile(title: Text('Phone'), subtitle: Text('+1 234 567 890')),
            ListTile(title: Text('Website'), subtitle: Text('www.yourapp.com')),
            ListTile(
              title: Text('Address'),
              subtitle: Text('123 App Street, Tech City'),
            ),
          ]),
        ],
      ),
    );
  }

  Widget _section(String title, List<Widget> children) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...children,
          ],
        ),
      ),
    );
  }
}
