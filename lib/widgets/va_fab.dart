import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../services/va_service.dart';

class VaFab extends StatefulWidget {
  const VaFab({super.key});
  @override
  State<VaFab> createState() => _VaFabState();
}

class _VaFabState extends State<VaFab> {
  final _va = VAService();
  final _stt = stt.SpeechToText();
  bool _listening = false;

  Future<void> _toggle() async {
    if (_listening) {
      await _stt.stop();
      setState(() => _listening = false);

      final r = await _va.resolve();
      final ok = await showDialog<bool>(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('تأكيد العملية'),
              content: Text('المسار: ${r['route'] ?? r['handler'] ?? 'غير معروف'}'),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('إلغاء')),
                FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('تنفيذ')),
              ],
            ),
          ) ?? false;

      if (ok) {
        await _va.issue();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('✓ تم التنفيذ')),
          );
        }
      }
      await _va.end();
      return;
    }

    final mic = await Permission.microphone.request();
    if (!mic.isGranted) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('امنح إذن الميكروفون')),
        );
      }
      return;
    }

    await _va.startSession();

    final okInit = await _stt.initialize();
    if (!okInit) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تعذّر بدء التعرف الصوتي')),
        );
      }
      return;
    }

    setState(() => _listening = true);
    _stt.listen(
      localeId: 'ar_SY',
      partialResults: true,
      listenMode: stt.ListenMode.dictation,
      onResult: (res) async {
        final text = res.recognizedWords.trim();
        if (text.isNotEmpty) {
          await _va.appendTranscript(text, lang: 'ar-SY');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: _toggle,
      icon: Icon(_listening ? Icons.stop : Icons.mic),
      label: Text(_listening ? 'إيقاف' : 'تكلّم'),
    );
  }
}
