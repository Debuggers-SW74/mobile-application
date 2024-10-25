import 'package:flutter/material.dart';
import 'package:movil_application/profile_management/pages/registration_screen.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({Key? key}) : super(key: key);

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  String? selectedUserType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FastPorte'),
        backgroundColor: Colors.blue[900],
      ),
      body: SafeArea( // Añadido SafeArea para mejor manejo del espacio
        child: SingleChildScrollView( // Añadido para evitar overflow
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Manejo seguro de la imagen
                Image.asset(
                  'assets/images/logo.png',
                  height: 100,
                  errorBuilder: (context, error, stackTrace) {
                    print('Error loading image: $error');
                    return const Icon(Icons.error);
                  },
                ),
                const SizedBox(height: 20),
                const Text(
                  'Select Your Type Of Profile!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildUserTypeButton(
                      icon: Icons.person,
                      label: 'Driver',
                      onTap: () {
                        setState(() {
                          selectedUserType = 'Driver';
                        });
                      },
                      isSelected: selectedUserType == 'Driver',
                    ),
                    _buildUserTypeButton(
                      icon: Icons.business,
                      label: 'Supervisor',
                      onTap: () {
                        setState(() {
                          selectedUserType = 'Supervisor';
                        });
                      },
                      isSelected: selectedUserType == 'Supervisor',
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: selectedUserType != null
                      ? () {
                          try {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegistrationScreen(
                                  userType: selectedUserType!,
                                ),
                              ),
                            );
                          } catch (e) {
                            print('Navigation error: $e');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Error: $e'),
                              ),
                            );
                          }
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[900],
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 15,
                    ),
                  ),
                  child: const Text(
                    'CONTINUE',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserTypeButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: isSelected ? Colors.blue[900] : Colors.grey[300],
            child: Icon(icon, size: 40, color: Colors.white),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.blue[900] : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}