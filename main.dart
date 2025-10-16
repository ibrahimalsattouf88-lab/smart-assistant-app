
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'src/sections.dart';
import 'src/va_button.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MaeawinApp());
}

class MaeawinApp extends StatelessWidget {
  const MaeawinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'المعاون',
      theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int idx = 0;
  static const _tabs = [
    ('الرئيسية', Icons.home),
    ('المحاسبة', Icons.calculate),
    ('العملات', Icons.currency_exchange),
    ('النصائح', Icons.lightbulb),
    ('مساعدة', Icons.person),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('المعاون')),
      body: IndexedStack(
        index: idx,
        children: const [
          SectionHome(), SectionAccounting(), SectionForex(), SectionAdvice(), SectionPersonal()
        ],
      ),
      floatingActionButton: const VAButton(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: idx,
        onDestinationSelected: (i)=>setState(()=>idx=i),
        destinations: [
          for (final t in _tabs) NavigationDestination(icon: Icon(t.$2), label: t.$1)
        ],
      ),
    );
  }
}
