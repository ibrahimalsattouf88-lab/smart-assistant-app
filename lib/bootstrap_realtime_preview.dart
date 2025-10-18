import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _ClientHome(),
    );
  }
}

class Tip {
  final String level, title, content;
  Tip(this.level, this.title, this.content);
}

Future<List<Tip>> _fetchTips() async {
  final url = dotenv.env['SUPABASE_URL']!;
  final anon = dotenv.env['SUPABASE_ANON_KEY']!;
  final endpoint = Uri.parse(
      '$url/rest/v1/tips?select=level,title,content,created_at&order=created_at.desc&limit=20');

  final resp = await http.get(
    endpoint,
    headers: {
      'apikey': anon,
      'Authorization': 'Bearer $anon',
      'Accept': 'application/json',
    },
  );
  if (resp.statusCode != 200) {
    throw Exception('HTTP ${resp.statusCode} ${resp.body}');
  }
  final data = jsonDecode(resp.body) as List;
  return data
      .map((e) => Tip(e['level'] ?? '', e['title'] ?? '', e['content'] ?? ''))
      .toList();
}

class _ClientHome extends StatefulWidget {
  const _ClientHome({super.key});
  @override
  State<_ClientHome> createState() => _ClientHomeState();
}

class _ClientHomeState extends State<_ClientHome> {
  List<Tip> _tips = [];
  Timer? _t;
  bool _first = true;

  Future<void> _refresh() async {
    try {
      final list = await _fetchTips();
      if (!mounted) return;
      setState(() {
        _tips = list;
      });
    } catch (_) {
      // تجاهل أخطاء الشبكة أثناء المعاينة
    }
  }

  @override
  void initState() {
    super.initState();
    _refresh();
    _t = Timer.periodic(const Duration(seconds: 5), (_) => _refresh());
  }

  @override
  void dispose() {
    _t?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final body = _tips.isEmpty
        ? Center(
            child: Text(
              _first
                  ? '... بانتظار أي Tip جديد'
                  : 'لا توجد Tips حالياً',
              style: const TextStyle(fontSize: 16),
            ),
          )
        : ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: _tips.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (ctx, i) {
              final t = _tips[i];
              Color c;
              switch (t.level) {
                case 'warning':
                  c = const Color(0xFFFFE08A);
                  break;
                case 'error':
                  c = const Color(0xFFFFC1C1);
                  break;
                default:
                  c = const Color(0xFFE7F5FF);
              }
              return Container(
                decoration: BoxDecoration(
                  color: c,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(t.title,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 6),
                    Text(t.content),
                    const SizedBox(height: 2),
                    Text('level: ${t.level}',
                        style:
                            const TextStyle(fontSize: 12, color: Colors.black54)),
                  ],
                ),
              );
            },
          );

    _first = false;

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: SafeArea(
          child: Material(
            color: Colors.white,
            elevation: 2,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text(
                'Realtime Tips — Preview',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ),
      body: body,
    );
  }
}
