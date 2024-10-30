import 'package:flutter/material.dart'; // Importa el paquete de Flutter Material para usar widgets de interfaz.
import 'package:firebase_auth/firebase_auth.dart'; // Importa Firebase Auth para la autenticación de usuarios.

class ForgotPasswordPage extends StatefulWidget { // Define un widget con estado para la recuperación de contraseña.
  const ForgotPasswordPage({super.key}); // Constructor del widget.

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState(); // Crea el estado asociado al widget.
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> { // Estado del widget ForgotPasswordPage.
  final TextEditingController _emailController = TextEditingController(); // Controlador para el campo de correo electrónico.
  final FirebaseAuth _auth = FirebaseAuth.instance; // Instancia de FirebaseAuth para gestionar la autenticación.

  void _sendPasswordResetEmail() async { // Método para enviar el correo de restablecimiento de contraseña.
    if (_emailController.text.isNotEmpty) { // Comprueba que el campo de correo no esté vacío.
      try {
        // Intenta enviar el correo de restablecimiento de contraseña.
        await _auth.sendPasswordResetEmail(email: _emailController.text);
        ScaffoldMessenger.of(context).showSnackBar( // Muestra un mensaje de éxito.
          const SnackBar(
              content: Text('Se ha enviado un correo para restablecer tu contraseña')),
        );
        Navigator.pop(context); // Vuelve a la pantalla de inicio de sesión.
      } on FirebaseAuthException catch (e) { // Maneja las excepciones de FirebaseAuth.
        ScaffoldMessenger.of(context).showSnackBar( // Muestra un mensaje de error.
          SnackBar(content: Text('Error: ${e.message}')),
        );
      }
    } else {
      // Si el campo de correo está vacío, muestra un mensaje de advertencia.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor ingresa tu correo electrónico')),
      );
    }
  }

  @override
  Widget build(BuildContext context) { // Método para construir la interfaz de usuario.
    return Scaffold( // Estructura básica de la pantalla.
      appBar: AppBar(
        title: const Text('Restablecer Contraseña'), // Título de la AppBar.
        backgroundColor: Colors.transparent, // AppBar transparente.
        centerTitle: true, // Centrar el título en la AppBar.
        elevation: 4.0, // Añadir sombra a la AppBar.
      ),
      body: Container( // Contenedor para el cuerpo de la pantalla.
        color: Colors.transparent, // Fondo transparente.
        child: Center( // Centro de la pantalla.
          child: SingleChildScrollView( // Permite desplazamiento si el contenido es largo.
            padding: const EdgeInsets.symmetric(horizontal: 24.0), // Espaciado horizontal.
            child: Column( // Columna para organizar los widgets verticalmente.
              mainAxisAlignment: MainAxisAlignment.center, // Centrar verticalmente los widgets.
              crossAxisAlignment: CrossAxisAlignment.center, // Centrar horizontalmente los widgets.
              children: [
                const SizedBox(height: 40), // Espaciado superior.
                const Text(
                  'Recupera tu cuenta', // Título principal.
                  style: TextStyle(
                    fontSize: 32, // Tamaño de fuente.
                    fontWeight: FontWeight.bold, // Negrita.
                    color: Colors.black, // Color del texto.
                  ),
                ),
                const SizedBox(height: 10), // Espacio vertical.
                const Text(
                  'Ingresa tu correo electrónico para poder recuperar tu contraseña', // Subtítulo.
                  style: TextStyle(
                    fontSize: 16, // Tamaño de fuente.
                    color: Colors.black, // Color del texto.
                  ),
                  textAlign: TextAlign.center, // Centrar el texto.
                ),
                const SizedBox(height: 40), // Espacio vertical.
                _buildEmailInput(), // Campo de entrada para el correo electrónico.
                const SizedBox(height: 30), // Espacio vertical.
                _buildSendButton(), // Botón para enviar el enlace de restablecimiento.
                const SizedBox(height: 20), // Espacio vertical.
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailInput() { // Método para construir el campo de entrada de correo electrónico.
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0), // Espaciado interno del contenedor.
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2), // Color de fondo con opacidad.
        borderRadius: BorderRadius.circular(30), // Bordes redondeados.
        border: Border.all(color: Colors.black.withOpacity(0.5)), // Borde sutil.
      ),
      child: TextFormField( // Campo de texto.
        controller: _emailController, // Asigna el controlador.
        style: const TextStyle(color: Colors.black), // Color del texto.
        decoration: const InputDecoration(
          hintText: 'Correo Electrónico', // Texto de sugerencia.
          hintStyle: TextStyle(color: Colors.black), // Estilo del texto de sugerencia.
          border: InputBorder.none, // Sin borde.
          prefixIcon: Icon(Icons.email, color: Colors.black), // Ícono a la izquierda.
        ),
      ),
    );
  }

  Widget _buildSendButton() { // Método para construir el botón de envío.
    return ElevatedButton( // Botón elevado.
      onPressed: _sendPasswordResetEmail, // Acción al presionar el botón.
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.pink, // Color de fondo del botón.
        padding: const EdgeInsets.symmetric( // Espaciado interno del botón.
          horizontal: 50,
          vertical: 15,
        ),
        shape: RoundedRectangleBorder( // Forma del botón.
          borderRadius: BorderRadius.circular(30), // Bordes redondeados.
        ),
        elevation: 5, // Sombra para el botón.
      ),
      child: const Text( // Texto del botón.
        'Enviar enlace',
        style: TextStyle(
          fontSize: 18, // Tamaño de fuente del texto del botón.
          color: Colors.white, // Color del texto.
        ),
      ),
    );
  }
}
