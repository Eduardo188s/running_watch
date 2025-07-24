import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WatchActivityRunningPage extends StatefulWidget {
  const WatchActivityRunningPage({super.key});

  @override
  State<WatchActivityRunningPage> createState() => _WatchActivityRunningPageState();
}

class _WatchActivityRunningPageState extends State<WatchActivityRunningPage> {
  late Timer _timer;
  int _elapsedSeconds = 0;
  late DateTime _startTime;

  @override
  void initState() {
    super.initState();
    _startTime = DateTime.now();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedSeconds++;
      });

      if (_elapsedSeconds % 60 == 0) {
        _show10MinAlert();
      }
    });
  }

  void _show10MinAlert() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.black87,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text(
          '¡Sigue así!',
          style: TextStyle(
            color: Colors.white,
            fontStyle: FontStyle.italic, 
            fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'Has completado 10 minutos 🎉',
          style: TextStyle(
            color: Colors.white70,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold
            ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK', style: TextStyle(color: Colors.cyanAccent)),
          ),
        ],
      ),
    );
  }

  void _showSaveDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black87,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text(
          'Guardar actividad',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: const Text(
          '¿Deseas guardar esta actividad?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cierra diálogo
              Navigator.of(context).pop(); // Vuelve a pantalla anterior sin guardar
            },
            child: const Text('Descartar', style: TextStyle(color: Colors.redAccent)),
          ),
          TextButton(
            onPressed: () {
              _saveActivity();
              Navigator.of(context).pop(); // Cierra diálogo
              Navigator.of(context).pop(); // Vuelve a pantalla anterior
            },
            child: const Text('Guardar', style: TextStyle(color: Colors.greenAccent)),
          ),
        ],
      ),
    );
  }

  void _saveActivity() {
    // Aquí puedes agregar almacenamiento real.
    print('Actividad guardada: Duración $_elapsedSeconds segundos, Calorías: ${_estimateCalories()} kcal');
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatTime(int totalSeconds) {
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  String _formatHour(DateTime time) => DateFormat('HH:mm').format(time);
  String _formatDate(DateTime date) => DateFormat('dd MMM yyyy').format(date);

  int _estimateCalories() => (_elapsedSeconds / 60 * 6).toInt(); // 6 kcal/min aprox.
  String _estimatePace() => (_elapsedSeconds / 60 / 1.5).toStringAsFixed(1); // 1.5 km mock

  Widget _infoTile({required IconData icon, required String label, required String value}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue, size: 18),
          const SizedBox(width: 10),
          Text(label, style: const TextStyle(color: Colors.white70)),
          const Spacer(),
          Text(value, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.directions_run, size: 42, color: Colors.greenAccent),
                const SizedBox(height: 8),
                const Text('Actividad en curso',
                    style: TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold, 
                      color: Colors.white)),
                const SizedBox(height: 12),
                Text(
                  _formatTime(_elapsedSeconds),
                  style: const TextStyle(fontSize: 36, color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                _infoTile(icon: Icons.access_time, label: 'Hora inicio', value: _formatHour(_startTime)),
                _infoTile(icon: Icons.date_range, label: 'Fecha', value: _formatDate(_startTime)),
                _infoTile(icon: Icons.local_fire_department, label: 'Calorías', value: '${_estimateCalories()} kcal'),
                _infoTile(icon: Icons.speed, label: 'Ritmo prom.', value: '${_estimatePace()} min/km'),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _timer.cancel();
                    _showSaveDialog();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text('Detener', style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                    )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
