import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello World App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomeScreen(),
      routes: {
        '/report': (context) => ReportScreen(),
        '/createUser': (context) => CreateUserScreen(), 
      }
    );
  }
}
 
class HomeScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 🔍 Search Bar
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            SizedBox(height: 16),

            // 🔘 Two Buttons in a Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/report');
                    },
                    child: Text("Report"),
                  ),
                ),
                SizedBox(width: 16), // Space between buttons
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/createUser');
                    },
                    child: Text("Create User"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
class ReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Simple list of dummy reports
    final reports = ['Sales Report', 'User Report', 'Error Logs'];

    return Scaffold(
      appBar: AppBar(title: Text("Reports")),
      body: ListView.builder(
        itemCount: reports.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.description),
            title: Text(reports[index]),
          );
        },
      ),
    );
  }
}
class CreateUserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Just a placeholder for now
    return Scaffold(
      appBar: AppBar(title: Text("Create User")),
      body: Center(
        child: Text("Create User Form goes here"),
      ),
    );
  }
}


