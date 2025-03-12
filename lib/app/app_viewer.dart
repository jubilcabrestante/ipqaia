import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String selectedMenu = "Account"; // Default selected menu

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Static Side Menu
          Container(
            width: 250,
            color: Colors.orange.shade200,
            child: Column(
              children: [
                const SizedBox(height: 20),
                _buildMenuItem("Dashboard", Icons.home),
                _buildMenuItem("Academic Offerings", Icons.school),
                _buildMenuItem("Accreditation and COPC", Icons.assignment),
                _buildMenuItem("Student Life and Facilities", Icons.people),
                _buildMenuItem("Personnel Profile", Icons.person),
                _buildMenuItem("SDG", Icons.public),
                _buildMenuItem("Account", Icons.account_circle), // Selected by default
                
                const Spacer(), // Push logout to bottom
                _buildMenuItem("Logout", Icons.exit_to_app),
                const SizedBox(height: 20),
              ],
            ),
          ),

          // Main Content Area
          Expanded(
            child: selectedMenu == "Account"
                ? CreateAccountScreen() // Only show Create Account for now
                : Center(child: Text("$selectedMenu Page Coming Soon...")),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String title, IconData icon) {
    bool isSelected = selectedMenu == title;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMenu = title;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.redAccent : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? Colors.white : Colors.black),
            const SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Create Account Screen
class CreateAccountScreen extends StatelessWidget {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(30),
        width: 700,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back Button
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    // Handle back action
                  },
                ),
                const Text(
                  "Account",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.orangeAccent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Title
            const Center(
              child: Text(
                "Create New Account",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Input Fields
            Row(
              children: [
                Expanded(child: buildTextField("First Name", firstNameController)),
                const SizedBox(width: 10),
                Expanded(child: buildTextField("Last Name", lastNameController)),
              ],
            ),
            buildTextField("Email", emailController),
            Row(
              children: [
                Expanded(child: buildTextField("Role", roleController)),
                const SizedBox(width: 10),
                Expanded(child: buildTextField("Age", ageController)),
              ],
            ),
            buildTextField("Gender", genderController),
            buildTextField("Password", passwordController, obscureText: true),
            buildTextField("Confirm Password", confirmPasswordController, obscureText: true),
            
            const SizedBox(height: 20),

            // Confirm Button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  // Handle account creation logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Confirm",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String hint, TextEditingController controller, {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.orange.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}