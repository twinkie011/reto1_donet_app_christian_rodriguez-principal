// Importaciones necesarias para la aplicación
import 'package:flutter/material.dart'; // Importa el paquete de Material Design para usar sus widgets.
import 'package:firebase_auth/firebase_auth.dart'; // Importa Firebase Authentication para la gestión de usuarios.
import 'package:reto1_donet_app_christian_rodriguez/pages/login.dart'; // Importa la página de inicio de sesión.

/// Clase principal para la pantalla de registro que extiende StatefulWidget.
class Registrate extends StatefulWidget {
  const Registrate({super.key}); // Constructor con clave opcional.

  @override
  State<Registrate> createState() => _RegistrateState(); // Crea el estado asociado a esta pantalla.
}

/// Clase de estado para Registrate.
class _RegistrateState extends State<Registrate> {
  // Controladores para los campos de texto.
  final TextEditingController _nombreController = TextEditingController(); // Controlador para el nombre.
  final TextEditingController _correoController = TextEditingController(); // Controlador para el correo electrónico.
  final TextEditingController _passwordController = TextEditingController(); // Controlador para la contraseña.
  final TextEditingController _confirmPasswordController = TextEditingController(); // Controlador para confirmar contraseña.

  // Instancia de FirebaseAuth para manejar la autenticación.
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Variables booleanas para validar los requisitos de la contraseña.
  bool _hasUpperCase = false; // Indica si hay al menos una letra mayúscula.
  bool _hasDigit = false; // Indica si hay al menos un dígito.
  bool _hasMinLength = false; // Indica si la contraseña tiene un mínimo de 6 caracteres.

  // Método que se llama al iniciar el estado.
  @override
  void initState() {
    super.initState(); // Llama al método de inicialización de la clase padre.
    _passwordController.addListener(_validatePassword); // Agrega un listener para validar la contraseña cuando cambia.
  }

  /// Método para validar los requisitos de la contraseña.
  void _validatePassword() {
    String password = _passwordController.text; // Obtiene el texto actual de la contraseña.
    setState(() {
      // Actualiza el estado según los requisitos de la contraseña.
      _hasUpperCase = password.contains(RegExp(r'[A-Z]')); // Verifica si hay al menos una letra mayúscula.
      _hasDigit = password.contains(RegExp(r'[0-9]')); // Verifica si hay al menos un dígito.
      _hasMinLength = password.length >= 6; // Verifica si la longitud es de al menos 6 caracteres.
    });
  }

  /// Método para registrar un nuevo usuario.
  Future<void> _registrar() async {
    // Verifica si las contraseñas coinciden.
    if (_passwordController.text != _confirmPasswordController.text) {
      // Muestra un mensaje de error si las contraseñas no coinciden.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Las contraseñas no coinciden')),
      );
      return; // Sale del método si las contraseñas no coinciden.
    }

    // Verifica que la contraseña cumpla con los requisitos.
    if (_hasUpperCase && _hasDigit && _hasMinLength) {
      try {
        // Intenta crear un nuevo usuario con correo y contraseña.
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: _correoController.text, // Correo ingresado.
          password: _passwordController.text, // Contraseña ingresada.
        );

        // Envía un correo de verificación al nuevo usuario.
        await userCredential.user?.sendEmailVerification();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Se ha enviado un correo de verificación')),
        );

        // Redirige al usuario a la página de inicio de sesión.
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } on FirebaseAuthException catch (e) {
        // Captura errores específicos de Firebase Authentication.
        String message = 'Error: ${e.message}'; // Mensaje de error genérico.
        if (e.code == 'weak-password') {
          message = 'La contraseña es demasiado débil.'; // Mensaje si la contraseña es débil.
        } else if (e.code == 'email-already-in-use') {
          message = 'El correo electrónico ya está en uso.'; // Mensaje si el correo ya está en uso.
        }
        // Muestra el mensaje de error correspondiente.
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
      }
    } else {
      // Si la contraseña no cumple con los requisitos, muestra un mensaje de error.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('La contraseña no cumple con los requisitos')),
      );
    }
  }

  // Método para construir la interfaz de usuario de la pantalla de registro.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Color de fondo transparente.
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Barra de aplicación transparente.
        title: const Text("Registro"), // Título de la barra de aplicación.
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0), // Padding horizontal.
          child: Column(
            children: [
              const Text(
                "Crea una cuenta", // Título principal.
                style: TextStyle(
                  fontSize: 32, // Tamaño de fuente.
                  fontWeight: FontWeight.bold, // Peso de fuente.
                  color: Colors.black, // Color de texto.
                ),
              ),
              const SizedBox(height: 8), // Espacio entre los textos.
              const Text(
                "Regístrate Ahora", // Subtítulo.
                style: TextStyle(fontSize: 24, color: Colors.white), // Estilo del subtítulo.
              ),
              const SizedBox(height: 24), // Espacio adicional.
              // Construcción de campos de texto.
              _buildTextField(_nombreController, Icons.person, "Nombre"), // Campo para el nombre.
              const SizedBox(height: 16), // Espacio entre campos.
              _buildTextField(_correoController, Icons.email, "Correo Electrónico"), // Campo para el correo.
              const SizedBox(height: 16), // Espacio entre campos.
              _buildTextField(_passwordController, Icons.lock, "Contraseña", obscureText: true), // Campo para la contraseña.
              const SizedBox(height: 16), // Espacio entre campos.
              _buildTextField(_confirmPasswordController, Icons.lock, "Confirmar Contraseña", obscureText: true), // Campo para confirmar la contraseña.
              const SizedBox(height: 16), // Espacio entre campos.
              _buildPasswordRequirements(), // Muestra los requisitos de la contraseña.
              const SizedBox(height: 24), // Espacio adicional.
              // Botón de registro.
              ElevatedButton(
                onPressed: _registrar, // Método que se ejecuta al presionar el botón.
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink[400], // Color de fondo del botón.
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 48), // Padding del botón.
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(90.0)), // Esquina redondeada del botón.
                ),
                child: const Text(
                  'Registrarse', // Texto del botón.
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white), // Estilo del texto.
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Método para construir un campo de texto con icono y texto de sugerencia.
  Widget _buildTextField(
    TextEditingController controller, // Controlador para el campo de texto.
    IconData icon, // Icono para el campo de texto.
    String hintText, // Texto sugerido para el campo.
    {bool obscureText = false,} // Indica si el texto debe ser oculto (para contraseñas).
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), // Padding del contenedor.
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8), // Esquinas redondeadas.
        color: Colors.grey.withOpacity(.2), // Color de fondo con opacidad.
      ),
      child: TextFormField(
        controller: controller, // Asigna el controlador.
        obscureText: obscureText, // Define si el texto es oculto.
        decoration: InputDecoration(
          icon: Icon(icon), // Icono del campo de texto.
          border: InputBorder.none, // Sin borde visible.
          hintText: hintText, // Texto sugerido.
        ),
      ),
    );
  }

  /// Método para construir los requisitos de la contraseña.
  Widget _buildPasswordRequirements() {
    return Column(
      children: [
        // Cada línea muestra un requisito de contraseña.
        _buildRequirementText("Al menos una letra mayúscula", _hasUpperCase), // Requisito de letra mayúscula.
        _buildRequirementText("Al menos un dígito", _hasDigit), // Requisito de dígito.
        _buildRequirementText("Mínimo 6 caracteres", _hasMinLength), // Requisito de longitud mínima.
      ],
    );
  }

  /// Método para construir la visualización de un requisito de contraseña.
  Widget _buildRequirementText(String text, bool isValid) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check_circle : Icons.cancel, // Icono de verificación o cancelación.
          color: isValid ? Colors.green : Colors.red, // Color según el estado de validación.
        ),
        const SizedBox(width: 8), // Espacio entre el icono y el texto.
        Text(
          text, // Texto del requisito.
          style: TextStyle(
            color: isValid ? Colors.green : Colors.red, // Color del texto según la validación.
            fontWeight: FontWeight.bold, // Peso del texto.
          ),
        ),
      ],
    );
  }
}
