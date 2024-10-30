import 'package:flutter/material.dart'; // Importa el paquete de Flutter Material para usar widgets de interfaz.
import 'package:firebase_auth/firebase_auth.dart'; // Importa Firebase Auth para la autenticación de usuarios.

class UpdatePasswordPage extends StatefulWidget { // Define un widget con estado para actualizar la contraseña.
  const UpdatePasswordPage({super.key}); // Constructor del widget.

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState(); // Crea el estado asociado al widget.
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> { // Estado del widget UpdatePasswordPage.
  final _auth = FirebaseAuth.instance; // Instancia de FirebaseAuth para gestionar la autenticación.
  final _newPasswordController = TextEditingController(); // Controlador para la nueva contraseña.
  final _confirmPasswordController = TextEditingController(); // Controlador para confirmar la nueva contraseña.
  final _formKey = GlobalKey<FormState>(); // Clave global para el formulario, necesaria para la validación.

  // Variables para validar requisitos de la contraseña.
  bool isLengthValid = false; // Indica si la contraseña tiene la longitud válida.
  bool hasUppercase = false; // Indica si la contraseña tiene al menos una letra mayúscula.
  bool hasNumber = false; // Indica si la contraseña tiene al menos un número.

  @override
  void dispose() { // Método para liberar recursos.
    _newPasswordController.dispose(); // Libera el controlador de la nueva contraseña.
    _confirmPasswordController.dispose(); // Libera el controlador de confirmación de contraseña.
    super.dispose(); // Llama al método dispose de la clase base.
  }

  void _checkPassword(String password) { // Método para verificar los requisitos de la contraseña.
    setState(() { // Actualiza el estado del widget.
      isLengthValid = password.length >= 6; // Comprueba la longitud.
      hasUppercase = password.contains(RegExp(r'[A-Z]')); // Comprueba si tiene letras mayúsculas.
      hasNumber = password.contains(RegExp(r'\d')); // Comprueba si tiene números.
    });
  }

  Future<void> _updatePassword() async { // Método para actualizar la contraseña.
    if (_formKey.currentState!.validate()) { // Valida el formulario.
      try {
        User? user = _auth.currentUser; // Obtiene el usuario actual.
        await user?.updatePassword(_newPasswordController.text); // Intenta actualizar la contraseña.
        // Muestra un mensaje de éxito.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Contraseña actualizada exitosamente'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context); // Vuelve a la pantalla anterior.
      } on FirebaseAuthException catch (e) { // Maneja las excepciones de FirebaseAuth.
        String message = 'Ocurrió un error'; // Mensaje por defecto.
        if (e.code == 'weak-password') { // Si la contraseña es débil.
          message = 'La contraseña es demasiado débil';
        } else if (e.code == 'requires-recent-login') { // Si se requiere inicio de sesión reciente.
          message = 'Por seguridad, inicia sesión nuevamente';
        }
        // Muestra un mensaje de error.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) { // Método para construir la interfaz de usuario.
    return Scaffold( // Estructura básica de la pantalla.
      appBar: AppBar(
        backgroundColor: Colors.transparent, // AppBar transparente.
        title: const Text("Actualizar contraseña"), // Título de la AppBar.
        elevation: 0, // Sin sombra.
      ),
      body: Container(
        color: Colors.white, // Fondo blanco.
        padding: const EdgeInsets.all(24.0), // Espaciado interno.
        child: Center(
          child: SingleChildScrollView( // Permite desplazamiento si el contenido es largo.
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Centra el contenido verticalmente.
              crossAxisAlignment: CrossAxisAlignment.start, // Alinea el contenido a la izquierda.
              children: [
                const Text(
                  'Actualiza tu contraseña', // Título principal.
                  style: TextStyle(
                    fontSize: 24, // Tamaño de fuente.
                    fontWeight: FontWeight.bold, // Negrita.
                    color: Colors.black87, // Color del texto.
                  ),
                ),
                const SizedBox(height: 16), // Espaciado vertical.
                Form( // Formulario para la validación de los campos.
                  key: _formKey, // Asigna la clave global.
                  child: Column(
                    children: [
                      TextFormField( // Campo para la nueva contraseña.
                        controller: _newPasswordController, // Asigna el controlador.
                        obscureText: true, // Oculta el texto ingresado.
                        onChanged: _checkPassword, // Verifica la contraseña mientras se escribe.
                        decoration: InputDecoration(
                          labelText: 'Nueva Contraseña', // Etiqueta del campo.
                          labelStyle: const TextStyle(color: Colors.grey), // Estilo de la etiqueta.
                          prefixIcon: const Icon(Icons.lock), // Ícono a la izquierda.
                          border: OutlineInputBorder( // Borde del campo.
                            borderRadius: BorderRadius.circular(10), // Bordes redondeados.
                          ),
                        ),
                        validator: (value) { // Valida el campo de contraseña.
                          if (value == null || value.isEmpty) {
                            return 'Ingrese una nueva contraseña'; // Mensaje si está vacío.
                          } else if (value.length < 6) {
                            return 'La contraseña debe tener al menos 6 caracteres'; // Mensaje si es corta.
                          }
                          return null; // Si es válida.
                        },
                      ),
                      const SizedBox(height: 16), // Espaciado vertical.
                      Column( // Columna para mostrar requisitos de la contraseña.
                        crossAxisAlignment: CrossAxisAlignment.start, // Alinea a la izquierda.
                        children: [
                          Row( // Fila para el requisito de longitud.
                            children: [
                              Icon(
                                isLengthValid ? Icons.check_circle : Icons.cancel, // Icono de verificación.
                                color: isLengthValid ? Colors.green : Colors.red, // Color según validez.
                              ),
                              const SizedBox(width: 8), // Espacio entre íconos y texto.
                              const Text('Al menos 6 caracteres'), // Texto del requisito.
                            ],
                          ),
                          Row( // Fila para el requisito de mayúscula.
                            children: [
                              Icon(
                                hasUppercase ? Icons.check_circle : Icons.cancel, // Icono de verificación.
                                color: hasUppercase ? Colors.green : Colors.red, // Color según validez.
                              ),
                              const SizedBox(width: 8), // Espacio entre íconos y texto.
                              const Text('Una letra mayúscula'), // Texto del requisito.
                            ],
                          ),
                          Row( // Fila para el requisito de número.
                            children: [
                              Icon(
                                hasNumber ? Icons.check_circle : Icons.cancel, // Icono de verificación.
                                color: hasNumber ? Colors.green : Colors.red, // Color según validez.
                              ),
                              const SizedBox(width: 8), // Espacio entre íconos y texto.
                              const Text('Un número'), // Texto del requisito.
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 24), // Espaciado vertical.
                      TextFormField( // Campo para confirmar la nueva contraseña.
                        controller: _confirmPasswordController, // Asigna el controlador.
                        obscureText: true, // Oculta el texto ingresado.
                        decoration: InputDecoration(
                          labelText: 'Confirmar Contraseña', // Etiqueta del campo.
                          labelStyle: const TextStyle(color: Colors.grey), // Estilo de la etiqueta.
                          prefixIcon: const Icon(Icons.lock), // Ícono a la izquierda.
                          border: OutlineInputBorder( // Borde del campo.
                            borderRadius: BorderRadius.circular(10), // Bordes redondeados.
                          ),
                        ),
                        validator: (value) { // Valida el campo de confirmación de contraseña.
                          if (value != _newPasswordController.text) { // Comprueba que coincidan.
                            return 'Las contraseñas no coinciden'; // Mensaje si no coinciden.
                          }
                          return null; // Si son válidas.
                        },
                      ),
                      const SizedBox(height: 40), // Espaciado vertical.
                      SizedBox( // Contenedor para el botón de actualización.
                        width: double.infinity, // Ancho completo.
                        child: ElevatedButton( // Botón elevado para actualizar la contraseña.
                          onPressed: _updatePassword, // Acción al presionar el botón.
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink.shade700, // Color de fondo del botón.
                            padding: const EdgeInsets.symmetric(vertical: 16), // Espaciado interno del botón.
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12), // Bordes redondeados.
                            ),
                          ),
                          child: const Text(
                            'Actualizar Contraseña', // Texto del botón.
                            style: TextStyle(fontSize: 18, color: Colors.white), // Estilo del texto del botón.
                          ),
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
    );
  }
}
