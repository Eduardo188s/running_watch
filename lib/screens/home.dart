import 'package:flutter/material.dart';
import 'exercise.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(12),
          children: [

            // 🏁 Encabezado
            const Text(
              '¡Hola, Atleta!',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            const Text(
              '¡Vas increíble! 💪🏽',
              style: TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            // 🔄 Progreso simplificado
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _miniProgress('Días', 3, 5),
                _miniProgress('Min', 90, 150),
                _miniProgress('Km', 12, 20),
              ],
            ),

            const SizedBox(height: 20),

            // 🏃 Botón de ejercicio
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WatchExercisePage()),
                );
              },
              icon: const Icon(Icons.directions_run, size: 20),
              label: const Text('Ejercicio'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),

            const SizedBox(height: 20),

            // ✨ Frase motivacional
            const Text(
              '“Sé mejor que ayer.”',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _miniProgress(String label, int current, int total) {
    final percent = (current / total).clamp(0.0, 1.0);
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 40,
              width: 40,
              child: CircularProgressIndicator(
                value: percent,
                strokeWidth: 5,
                backgroundColor: Colors.grey.shade800,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.cyan),
              ),
            ),
            Text(
              '$current',
              style: const TextStyle(fontSize: 12, color: Colors.white),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.white70)),
      ],
    );
  }
}
