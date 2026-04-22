import 'package:flutter/material.dart';
import 'package:flutter_application_helmy/components/mytextfield.dart';
import 'package:flutter_application_helmy/pages/dashboard.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController txtUsername = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();

  String statuslogin = "";
  bool isLoading = false;

  void _login() async {
    setState(() {
      statuslogin = "";
      isLoading = true;
    });

    // Simulate delay
    await Future.delayed(const Duration(milliseconds: 1000));

    if (txtUsername.text.isEmpty || txtPassword.text.isEmpty) {
      setState(() {
        statuslogin = "Mohon isi semua field!";
        isLoading = false;
      });
      return;
    }

    if (txtUsername.text == "admin" && txtPassword.text == "admin123") {
      // Navigate to dashboard
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashboardPage()),
        );
      }
    } else {
      setState(() {
        statuslogin = "Username atau password salah!";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff4facfe), Color(0xff00f2fe)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  // LOGO
                  Image.asset(
                    "assets/logo.png",
                    height: 120,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Welcome Back",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),
                  // CARD LOGIN
                  Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 20,
                          color: Colors.black26,
                          offset: const Offset(0, 10),
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Mytextfield(
                          label: "Username",
                          hint: "Masukkan username",
                          textEditingController: txtUsername,
                          isPPassword: false,
                          icon: Icons.person_outline,
                          fontSize: 14,
                        ),
                        const SizedBox(height: 15),
                        Mytextfield(
                          label: "Password",
                          hint: "Masukkan password",
                          textEditingController: txtPassword,
                          isPPassword: true,
                          icon: Icons.lock_outline,
                          fontSize: 14,
                        ),
                        const SizedBox(height: 25),
                        // BUTTON LOGIN
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: isLoading ? null : _login,
                            child: isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text(
                                    "LOGIN",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        if (statuslogin.isNotEmpty)
                          Text(
                            statuslogin,
                            style: TextStyle(
                              color: statuslogin.contains('salah') || statuslogin.contains('field') 
                                  ? Colors.red 
                                  : Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    txtUsername.dispose();
    txtPassword.dispose();
    super.dispose();
  }
}
