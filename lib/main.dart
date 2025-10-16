
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _idx = 0;
  final _tabs = const [
    Center(child: Text('الرئيسية')),
    Center(child: Text('محاسبة')),
    Center(child: Text('تخصصات')),
    Center(child: Text('إعدادات')),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('المعاون الذكي')),
        body: _tabs[_idx],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _idx,
          onTap: (i) => setState(() => _idx = i),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
            BottomNavigationBarItem(icon: Icon(Icons.calculate), label: 'محاسبة'),
            BottomNavigationBarItem(icon: Icon(Icons.extension), label: 'تخصصات'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'إعدادات'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // Placeholder: VA start/resolve flow (to be wired to VA server endpoints)
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('VA session started')));
          },
          child: const Icon(Icons.mic),
        ),
      ),
    );
  }
}
