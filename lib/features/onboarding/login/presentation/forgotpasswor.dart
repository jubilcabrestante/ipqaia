import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ipqaia/gen/assets.gen.dart';

@RoutePage()
class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Forgot Password",
                  style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Color(0xFFFF4D00)),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 390,
                  child: TextField(
                    decoration: const InputDecoration(labelText: "PSU Email", border: OutlineInputBorder()),
                  ),
                ),
                const SizedBox(height: 20),

                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF4D00),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    child: const Text("Send Reset Link", style: TextStyle(color: Colors.black)),
                  ),
                ),
                TextButton(
                  onPressed: () => context.router.pop(),
                  child: const Text("Back to Login", style: TextStyle(color: Color(0xFF0062CA))),
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(Assets.images.background.path, fit: BoxFit.cover, colorBlendMode: BlendMode.darken, color: Colors.black.withOpacity(0.6)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(Assets.images.logo.path, height: 300),
                    const SizedBox(height: 10),
                    const Text("IPQAIA", style: TextStyle(fontSize: 70, fontWeight: FontWeight.bold, color: Colors.white)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
