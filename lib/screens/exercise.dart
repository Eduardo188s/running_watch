// watch_exercise_page.dart

import 'package:flutter/material.dart';
import 'package:running_watch/screens/start_running.dart';

class WatchExercisePage extends StatefulWidget {
  const WatchExercisePage({super.key});

  @override
  State<WatchExercisePage> createState() => _WatchExercisePageState();
}

class _WatchExercisePageState extends State<WatchExercisePage> {
  final Color bgColor = const Color(0xFF0B0F1A);
  final Color primaryText = Colors.white;
  final Color secondaryText = const Color(0xFFA8B2D1);
  final Color startColor = const Color(0xFF00E676);
  final Color stopColor = const Color(0xFFFF1744);
  final Color iconColor = const Color(0xFF64B5F6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.directions_run, size: 46, color: iconColor),
                const SizedBox(height: 14),
                Text(
                  'Listo para correr',
                  style: TextStyle(fontSize: 18, color: secondaryText),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    // Navegar a la pantalla con la actividad corriendo
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WatchActivityRunningPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: bgColor,
                    backgroundColor: startColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  ),
                  child: const Text('Comenzar', style: TextStyle(fontSize: 15)),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Volver', style: TextStyle(color: secondaryText)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
