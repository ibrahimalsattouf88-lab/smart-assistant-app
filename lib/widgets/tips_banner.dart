import 'package:flutter/material.dart';
import '../services/realtime_tips.dart';

class TipsBanner extends StatefulWidget {
  const TipsBanner({super.key});
  @override
  State<TipsBanner> createState() => _TipsBannerState();
}

class _TipsBannerState extends State<TipsBanner> {
  Map<String, dynamic>? _lastTip;

  @override
  void initState() {
    super.initState();
    RealtimeTipsService.instance.init();
    RealtimeTipsService.instance.stream.listen((tip) {
      if (!mounted) return;
      setState(() => _lastTip = tip);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${tip['title'] ?? 'نصيحة'} — ${tip['content'] ?? ''}'),
          duration: const Duration(seconds: 4),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_lastTip == null) return const SizedBox.shrink();
    return Card(
      margin: const EdgeInsets.all(12),
      child: ListTile(
        leading: const Icon(Icons.lightbulb),
        title: Text(_lastTip?['title'] ?? 'نصيحة'),
        subtitle: Text(_lastTip?['content'] ?? ''),
        trailing: Text(((_lastTip?['level']) ?? 'info').toString(),
            style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
