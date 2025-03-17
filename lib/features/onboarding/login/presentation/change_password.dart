import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ipqaia/gen/assets.gen.dart';

@RoutePage()
class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});


  Widget _buildTextField(String label, {bool obscureText = false, Widget? suffixIcon}) {
    return SizedBox(
      width: 280,
      child: TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Text(
                  "Change Password",
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 128, 0),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50),
                _buildTextField(
                  "Enter new Password",
                  obscureText: true,
                  suffixIcon: const Icon(Icons.visibility),
                ),
                const SizedBox(height: 15),
                _buildTextField(
                  "Confirm new Password",
                  obscureText: true,
                  suffixIcon: const Icon(Icons.visibility_off),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 180,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 128, 0),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: const Text("Confirm", style: TextStyle(color: Colors.black)),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Assets.images.background.path),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.6),
                        BlendMode.darken,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(Assets.images.logo.path, height: 200),
                      const SizedBox(height: 10),
                      const Text(
                        "IPQAIA",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
