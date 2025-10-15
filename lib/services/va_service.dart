import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class VAService {
  VAService();

  String get _base {
    final b = dotenv.env['VA_PUBLIC_BASE'] ?? '';
    return b.endsWith('/') ? b.substring(0, b.length - 1) : b;
  }

  String? _sessionId;

  Future<String> startSession() async {
    final r = await http.post(
      Uri.parse('$_base/va/start-session'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({}),
    );
    if (r.statusCode != 200) {
      throw Exception('start-session failed: ${r.body}');
    }
    final data = jsonDecode(r.body);
    // دعم مفاتيح مختلفة للاسم
    _sessionId = data['sessionId'] ?? data['id'] ?? data['session_id'];
    if (_sessionId == null) throw Exception('No sessionId returned');
    return _sessionId!;
  }

  Future<void> appendTranscript(String text, {String lang = 'ar-SY'}) async {
    if (_sessionId == null) {
      await startSession();
    }
    final body = {
      'sessionId': _sessionId,
      'content': text,
      'language': lang,
    };
    final r = await http.post(
      Uri.parse('$_base/va/append-transcript'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    if (r.statusCode != 200) {
      throw Exception('append-transcript failed: ${r.body}');
    }
  }

  Future<Map<String, dynamic>> resolve() async {
    final r = await http.post(
      Uri.parse('$_base/va/resolve'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'sessionId': _sessionId}),
    );
    if (r.statusCode != 200) {
      throw Exception('resolve failed: ${r.body}');
    }
    return (jsonDecode(r.body) as Map<String, dynamic>);
  }

  Future<void> issue() async {
    final r = await http.post(
      Uri.parse('$_base/va/issue'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'sessionId': _sessionId}),
    );
    if (r.statusCode != 200) {
      throw Exception('issue failed: ${r.body}');
    }
  }

  Future<void> end() async {
    if (_sessionId == null) return;
    await http.post(
      Uri.parse('$_base/va/end-session'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'sessionId': _sessionId}),
    );
    _sessionId = null;
  }
}
