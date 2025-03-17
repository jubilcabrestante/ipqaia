import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ipqaia/core/shared/app_containers/app_body_container.dart';
import 'package:ipqaia/core/shared/app_containers/app_header_container.dart';
import 'package:ipqaia/core/shared/app_custom_button.dart';

// Create Account Screen
@RoutePage()
class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  AccountScreenState createState() => AccountScreenState();
}

class AccountScreenState extends State<AccountScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String? selectedGender;
  String? selectedRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        centerTitle: false,
        title: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: AppHeaderContainer(
            child: Row(
              children: [
                AppCustomButton(
                  ontab: () {
                    // context.router.push(const )
                  },
                  text: "List of Articles",
                ),
                Gap(20),
                AppCustomButton(
                  ontab: () {
                    // context.router.push(const )
                  },
                  text: "Manage SDG's",
                )
              ],
            ),
          ),
        ),
      ),
      body: AppBodyContainer(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Input Fields
              buildTextField("Full Name", fullNameController),
              const SizedBox(height: 15),
              buildTextField("Email", emailController),
              const SizedBox(height: 15),
              buildTextField("Age", ageController),
              const SizedBox(height: 15),

              // Dropdown Fields in a Row
              Row(
                children: [
                  Expanded(
                    child: buildDropdownField(
                      "Role",
                      ["Staff", "Admin"],
                      selectedRole,
                      (value) {
                        setState(() {
                          selectedRole = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: buildDropdownField(
                      "Gender",
                      ["Male", "Female"],
                      selectedGender,
                      (value) {
                        setState(() {
                          selectedGender = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              // Password Fields
              buildTextField("Password", passwordController, obscureText: true),
              const SizedBox(height: 15),
              buildTextField("Confirm Password", confirmPasswordController,
                  obscureText: true),
              const SizedBox(height: 20),

              // Confirm Button
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle account creation logic
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 160, 82),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
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
      ),
    );
  }

  // 🔹 Generic Text Field
  Widget buildTextField(String hint, TextEditingController controller,
      {bool obscureText = false}) {
    return TextFormField(
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
    );
  }

  // 🔹 Fixed Dropdown Field
  Widget buildDropdownField(String hint, List<String> items,
      String? selectedItem, ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      value: items.contains(selectedItem)
          ? selectedItem
          : null, // Ensure value is in the list
      hint: Text(hint),
      items:
          items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.orange.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
