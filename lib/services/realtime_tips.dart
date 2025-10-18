<<<<<<< HEAD
﻿import 'dart:async';
=======
import 'dart:async';
>>>>>>> dca0643640c4a7f787f430aac91a36625b6f8a0c
import 'package:supabase_flutter/supabase_flutter.dart';

class RealtimeTipsService {
  RealtimeTipsService._();
  static final instance = RealtimeTipsService._();

  final _controller = StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get stream => _controller.stream;

  RealtimeChannel? _channel;

  Future<void> init() async {
    final supabase = Supabase.instance.client;
    _channel?.unsubscribe();
    _channel = supabase.channel('tips')
      ..onPostgresChanges(
        event: PostgresChangeEvent.insert,
        schema: 'public',
        table: 'tips',
        callback: (payload) {
          final row = payload.newRecord;
          if (row != null) _controller.add(row);
        },
      )
      ..subscribe();
  }

  void dispose() {
    _channel?.unsubscribe();
    _controller.close();
  }
}
