import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const url = 'https://kieqcshbnagdastfxdkp.supabase.co';
  const key = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9....';
  await Supabase.initialize(url: url, anonKey: key);
  runApp(_App());
}

class _App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Realtime Tips — Preview')),
        body: const SafeArea(
          child: Center(child: Text('... بانتظار أي Tip جديد ...')),
        ),
      ),
    );
  }
}
