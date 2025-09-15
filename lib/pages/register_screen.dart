import 'package:flutter/material.dart';
import '../service/auth_service.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/custom_button.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool isObscure = true;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    final name = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (name.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Username ve password boş olamaz")),
      );
      return;
    }

    final response = await AuthService().register(name, password);

    if (response.containsKey("error")) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Kayıt başarısız: ${response['error']}")),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Kayıt başarılı!")));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 89, 30, 253),
      body: Center(
        child: Container(
          width: width * 0.5,
          height: height * 0.65,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 56, 56, 56),
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(110, 0, 0, 0),
                spreadRadius: 1,
                blurRadius: 8,
                offset: Offset(4, 4),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(
            vertical: height * 0.06,
            horizontal: height * 0.05,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_outlined),
                  ),
                ],
              ),
              Text(
                "Register",
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
              SizedBox(height: height * 0.07),
              CustomTextfield(
                controller: usernameController,
                hint: "Enter a username",
                obscureText: false,
                widget: const Icon(Icons.person),
              ),
              SizedBox(height: height * 0.05),
              CustomTextfield(
                controller: passwordController,
                hint: "Enter a password",
                obscureText: isObscure,
                widget: IconButton(
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                  icon: Icon(Icons.remove_red_eye),
                  color: Colors.black,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.transparent,
                    ),
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                ),
              ),
              SizedBox(height: height * 0.07),

              CustomButton(text: "Register", onTap: _handleRegister),
            ],
          ),
        ),
      ),
    );
  }
}
