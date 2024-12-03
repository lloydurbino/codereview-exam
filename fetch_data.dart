import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  String data = 'Loading...';
  bool isLoading = false;

  Future<void> fetchData() async {
    isLoading = true;
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      data = jsonResponse['title'];
    } else {
      data = 'Failed to load data';
    }
    isLoading = false;
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main View'),
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Text(
                data,
                textAlign: TextAlign.center,
              ),
      ),
    );
  }
}
