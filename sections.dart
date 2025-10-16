
import 'package:flutter/material.dart';

class SectionHome extends StatelessWidget{
  const SectionHome({super.key});
  @override
  Widget build(BuildContext context){
    return const Center(child: Text('واجهة بسيطة + لمحات استخدام'));
  }
}
class SectionAccounting extends StatelessWidget{
  const SectionAccounting({super.key});
  @override
  Widget build(BuildContext context){
    return const Center(child: Text('قسم المحاسبة'));
  }
}
class SectionForex extends StatelessWidget{
  const SectionForex({super.key});
  @override
  Widget build(BuildContext context){
    return const Center(child: Text('أسعار الصرف'));
  }
}
class SectionAdvice extends StatelessWidget{
  const SectionAdvice({super.key});
  @override
  Widget build(BuildContext context){
    return const Center(child: Text('نصائح ذكية'));
  }
}
class SectionPersonal extends StatelessWidget{
  const SectionPersonal({super.key});
  @override
  Widget build(BuildContext context){
    return const Center(child: Text('مساعد شخصي'));
  }
}
