import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reto1_donet_app_christian_rodriguez/pages/login.dart';

class Registrate extends StatefulWidget {
  const Registrate({super.key});

  @override
  State<Registrate> createState() => _RegistrateState();
}

class _RegistrateState extends State<Registrate> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController(); // Nuevo controlador para confirmar contraseña

  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _hasUpperCase = false;
  bool _hasDigit = false;
  bool _hasMinLength = false;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_validatePassword);
  }

  void _validatePassword() {
    String password = _passwordController.text;
    setState(() {
      _hasUpperCase = password.contains(RegExp(r'[A-Z]'));
      _hasDigit = password.contains(RegExp(r'[0-9]'));
      _hasMinLength = password.length >= 6;
    });
  }

  Future<void> _registrar() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Las contraseñas no coinciden')),
      );
      return;
    }

    if (_hasUpperCase && _hasDigit && _hasMinLength) {
      try {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: _correoController.text,
          password: _passwordController.text,
        );

        await userCredential.user?.sendEmailVerification();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Se ha enviado un correo de verificación')),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } on FirebaseAuthException catch (e) {
        String message = 'Error: ${e.message}';
        if (e.code == 'weak-password') {
          message = 'La contraseña es demasiado débil.';
        } else if (e.code == 'email-already-in-use') {
          message = 'El correo electrónico ya está en uso.';
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('La contraseña no cumple con los requisitos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Registro"),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const Text(
                "Crea una cuenta",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Regístrate Ahora",
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              const SizedBox(height: 24),
              _buildTextField(_nombreController, Icons.person, "Nombre"),
              const SizedBox(height: 16),
              _buildTextField(_correoController, Icons.email, "Correo Electrónico"),
              const SizedBox(height: 16),
              _buildTextField(_passwordController, Icons.lock, "Contraseña", obscureText: true),
              const SizedBox(height: 16),
              _buildTextField(_confirmPasswordController, Icons.lock, "Confirmar Contraseña", obscureText: true), // Nuevo campo de confirmar contraseña
              const SizedBox(height: 16),
              _buildPasswordRequirements(),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _registrar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink[400],
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 48),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(90.0)),
                ),
                child: const Text(
                  'Registrarse',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    IconData icon,
    String hintText,
    {bool obscureText = false,}
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.withOpacity(.2),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          icon: Icon(icon),
          border: InputBorder.none,
          hintText: hintText,
        ),
      ),
    );
  }

  Widget _buildPasswordRequirements() {
    return Column(
      children: [
        _buildRequirementText("Al menos una letra mayúscula", _hasUpperCase),
        _buildRequirementText("Al menos un dígito", _hasDigit),
        _buildRequirementText("Mínimo 6 caracteres", _hasMinLength),
      ],
    );
  }

  Widget _buildRequirementText(String text, bool isValid) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check_circle : Icons.cancel,
          color: isValid ? Colors.green : Colors.red,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            color: isValid ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
