import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'widgets/va_fab.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manus VA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const HomeShell(),
    );
  }
}

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});
  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _i = 0;
  final _pages = const [PageAccounting(), PageAssistant(), PageFX(), PageTips()];
  final _titles = const ['المحاسبة', 'مساعد شخصي', 'العملات', 'نصائح'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titles[_i])),
      body: _pages[_i],
      floatingActionButton: const VaFab(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _i,
        onDestinationSelected: (v) => setState(() => _i = v),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.receipt_long), label: 'محاسبة'),
          NavigationDestination(icon: Icon(Icons.assistant), label: 'مساعد'),
          NavigationDestination(icon: Icon(Icons.currency_exchange), label: 'عملات'),
          NavigationDestination(icon: Icon(Icons.lightbulb), label: 'نصائح'),
        ],
      ),
    );
  }
}

class PageAccounting extends StatelessWidget {
  const PageAccounting({super.key});
  @override
  Widget build(BuildContext context) =>
      const _CenterText('لوحة محاسبة: ملخص/مبيعات/مخزون');
}

class PageAssistant extends StatelessWidget {
  const PageAssistant({super.key});
  @override
  Widget build(BuildContext context) =>
      const _CenterText('المساعد الشخصي: مهام وتذكيرات');
}

class PageFX extends StatelessWidget {
  const PageFX({super.key});
  @override
  Widget build(BuildContext context) =>
      const _CenterText('العملات: أسعار فورية + تحليلات');
}

class PageTips extends StatelessWidget {
  const PageTips({super.key});
  @override
  Widget build(BuildContext context) =>
      const _CenterText('نصائح ذكية مخصّصة');
}

class _CenterText extends StatelessWidget {
  final String text;
  const _CenterText(this.text, {super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text, style: Theme.of(context).textTheme.headlineSmall),
    );
  }
}
