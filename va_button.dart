
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class VAButton extends StatefulWidget{
  const VAButton({super.key});
  @override
  State<VAButton> createState()=>_VAButtonState();
}

class _VAButtonState extends State<VAButton>{
  bool busy = false;
  String? last;

  Future<void> _ping() async {
    final base = dotenv.env['VA_BASE'] ?? 'http://127.0.0.1:8080';
    setState(()=>busy=true);
    try{
      final r = await http.get(Uri.parse('$base/health')).timeout(const Duration(seconds:8));
      setState(()=>last = r.statusCode==200 ? 'VA OK' : 'VA ${r.statusCode}');
    }catch(e){
      setState(()=>last = 'VA offline');
    } finally {
      setState(()=>busy=false);
    }
  }

  @override
  Widget build(BuildContext context){
    return FloatingActionButton.extended(
      onPressed: busy ? null : _ping,
      icon: busy ? const SizedBox(width:16, height:16, child: CircularProgressIndicator(strokeWidth:2)) : const Icon(Icons.mic),
      label: Text(last ?? 'المساعد الصوتي'),
    );
  }
}
