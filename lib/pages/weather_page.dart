import 'package:flutter/material.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(centerTitle: true, title: Text("W E A T H E R")),
    );
  }
}
