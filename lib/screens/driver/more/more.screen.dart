import 'package:fastporte/common/constants/app.colors.constant.dart';
import 'package:fastporte/widgets/app_bar/logged.app_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ClientMoreScreen extends StatefulWidget {
  const ClientMoreScreen({super.key});

  @override
  State<ClientMoreScreen> createState() => ClientMoreScreenState();
}

class ClientMoreScreenState extends State<ClientMoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LoggedAppBar(title: 'Support'),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Do you need help?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Icon(
                Icons.help_outline,
                size: 100,
                color: Colors.blueGrey,
              ),
              const SizedBox(height: 30),
              _buildContactInfo(
                icon: Icons.email_outlined,
                text: 'FastPorte_support@gmail.com',
              ),
              const SizedBox(height: 10),
              _buildContactInfo(
                icon: Icons.person_outline,
                text: '+51 964203761',
              ),
              const SizedBox(height: 30),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialIconButton(
                    icon: FontAwesomeIcons.whatsapp,
                    color: Colors.green,
                  ),
                  SizedBox(width: 15),
                  SocialIconButton(
                    icon: FontAwesomeIcons.facebook,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 15),
                  SocialIconButton(
                    icon: FontAwesomeIcons.instagram,
                    color: Colors.pink,
                  ),
                ],
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  _launchWhatsApp();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'SEND US A MESSAGE',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactInfo({required IconData icon, required String text}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      margin: const EdgeInsets.symmetric(horizontal: 50),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.black54),
          const SizedBox(width: 10),
          Text(
            text,
            style: const TextStyle(fontSize: 14, color: Colors.black54),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  void _launchWhatsApp() async {
    const phoneNumber = '+51964203761';
    const message = 'Hello, I need help with FastPorte.';
    final Uri url = Uri.parse('https://wa.me/$phoneNumber?text=${Uri.encodeFull(message)}');

    try {
      await launchUrl(url);
    } catch (e) {
      print('Could not launch $url: $e');
    }
  }

}

class SocialIconButton extends StatelessWidget {
  const SocialIconButton({
    super.key,
    required this.icon,
    required this.color,
  });

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: Colors.grey[200],
      child: Icon(
        icon,
        color: color,
        size: 30,
      ),
    );
  }
}
