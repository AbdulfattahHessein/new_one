import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_one/src/api/api_services.dart';
import 'package:new_one/src/models/Account.dart';
import 'package:new_one/src/models/ApiResponse.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

final apiService = ApiService();

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fetch Data Example'),
      ),
      body: Center(
        child: FutureBuilder<ApiResponse<Account>>(
          future: apiService.getAllAccounts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final apiResponse = snapshot.data!;
              if (apiResponse.succeeded!) {
                return ListView.builder(
                  itemCount: apiResponse.data!.length,
                  itemBuilder: (context, index) {
                    final dataItem = apiResponse.data![index];
                    return ListTile(
                      title: Text(dataItem.id.toString()),
                      subtitle: Text(dataItem.email!),
                    );
                  },
                );
              } else {
                return Text('API request failed: ${apiResponse.message}');
              }
            } else if (snapshot.hasError) {
              return Text('Error fetching data: ${snapshot.error}');
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

abstract class JsonSerializable {
  Map<String, dynamic> toJson();
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
