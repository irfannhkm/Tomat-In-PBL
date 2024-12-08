import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF191d26),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Profil',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                    )),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage('assets/profile_pic.png'),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 10,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.edit,
                            color: Colors.green,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // const Text('....................................',
                //     style: TextStyle(
                //         color: Colors.white,
                //         fontSize: 35,
                //         fontWeight: FontWeight.w500)),
                _buildTextField(Icons.person, "Nama"),
                _buildTextField(Icons.location_on, "Lokasi"),
                _buildTextField(Icons.cloud, "Iklim"),
                _buildTextField(Icons.email, "Email"),
                // const Text('....................................',
                //     style: TextStyle(
                //         color: Colors.white,
                //         fontSize: 35,
                //         fontWeight: FontWeight.w500)),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Keluar',
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF191d26),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(IconData icon, String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.white),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white),
          filled: true,
          fillColor: const Color(0xFF2e343b),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
