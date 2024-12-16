import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tomatin/controllers/user_controller.dart';
import 'package:tomatin/data/services/location_services.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserController userController = Get.find<UserController>();
  final LocationServices locationServices = LocationServices();
  bool isFetchingLocation = true;
  String? locationError;
  bool isEditing = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  void toggleEditMode() {
    setState(() {
      if (isEditing) {
        userController.updateUserData(
          name: nameController.text,
          email: emailController.text,
          username: usernameController.text,
        );
      }
      isEditing = !isEditing;
    });
  }

  Future<void> fetchLocation() async {
    try {
      await locationServices.getCurrentLocation();
    } catch (e) {
      locationError = e.toString();
    } finally {
      setState(() {
        isFetchingLocation = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchLocation();
    userController.fetchUserData();

    if (userController.user != null) {
      nameController.text = userController.user?.name ?? "";
      emailController.text = userController.user?.email ?? "";
      usernameController.text = userController.user?.username ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF191d26),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SingleChildScrollView(
            child: Obx(() {
              if (userController.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (userController.user == null) {
                return Center(
                  child: Text(
                    userController.errorMessage.value,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }

              final user = userController.user!;

              final locationText = isFetchingLocation
                  ? "Mengambil lokasi..."
                  : locationError != null
                      ? "Error: $locationError"
                      : '${locationServices.currentLocation?.latitude ?? "-"} , ${locationServices.currentLocation?.longitude ?? "-"}';

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(isEditing ? 'Edit Profil' : 'Profil & Akun',
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                      )),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: user.avatar != null
                              ? NetworkImage(user.avatarUrl)
                              : const AssetImage('assets/profile_pic.png')
                                  as ImageProvider,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 10,
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.white,
                            child: IconButton(
                              icon: Icon(isEditing ? Icons.check : Icons.edit),
                              onPressed: toggleEditMode,
                              color: const Color(0xFF235347),
                              iconSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Text('....................................',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.w500)),
                  _buildTextField(
                    Icons.person,
                    user.name ?? "Nama",
                    nameController,
                    isEditing,
                  ),
                  _buildTextField(
                    Icons.location_on,
                    locationText,
                    null,
                    false,
                  ),
                  _buildTextField(
                    Icons.face,
                    user.username ?? "Username",
                    usernameController,
                    isEditing,
                  ),
                  _buildTextField(
                    Icons.email,
                    user.email ?? "Email",
                    emailController,
                    isEditing,
                  ),
                  const Text('....................................',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      userController.logout();
                    },
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
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(IconData icon, String hint,
      TextEditingController? controller, bool isEditable) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        enabled: isEditable,
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
