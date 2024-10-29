import 'package:flutter/material.dart';
import 'package:movil_application/common/widgets/home.dart';
import 'package:movil_application/profile_management/domain/services/auth_service.dart';
import 'package:movil_application/profile_management/pages/role_selection_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  void _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    var user = await _authService.login(email, password);

    if (user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid email or password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                Image.asset(
                  'assets/images/logo.png',
                  height: 80,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Welcome, Let\'s Get Started!',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    labelText: 'Email Address / Username',
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.visibility),
                      onPressed: () {},
                    ),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _login,
                  child: Text('LOGIN'),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('Forgot Your Password?'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const RoleSelectionScreen(),
                      ),
                    );
                  },
                  child: const Text('No Account Yet? Create Account'),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required bool obscureText,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
