import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String data = "Hola";
  String displayText = '';
  double fontSize = 20.0;
  Color textColor = Colors.black;
  bool isTextVisible = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
      body: Column(
          children: [
            // Área de visualización de texto
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              alignment: Alignment.center,
              child: isTextVisible 
                ? Text(
                    'Este es un texto de ejemplo',
                    style: TextStyle(
                      fontSize: fontSize,
                      color: textColor,
                    ),
                  )
                : const SizedBox.shrink(),
            ),
            
            const SizedBox(height: 20),

            // Grilla de botones (3 filas x 2 columnas)
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              childAspectRatio: 2.5,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: [
                // Primera fila
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isTextVisible = true;
                    });
                  },
                  child: const Text('Mostrar texto'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isTextVisible = false;
                    });
                  },
                  child: const Text('Borrar texto'),
                ),
                
                // Segunda fila
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      fontSize += 2.0;
                    });
                  },
                  child: const Text('Agrandar letra'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      fontSize = fontSize > 10 ? fontSize - 2.0 : fontSize;
                    });
                  },
                  child: const Text('Disminuir letra'),
                ),
                
                // Tercera fila
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      textColor = Colors.blue;
                    });
                  },
                  child: const Text('Pintar de azul'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      textColor = Colors.red;
                    });
                  },
                  child: const Text('Pintar de rojo'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
