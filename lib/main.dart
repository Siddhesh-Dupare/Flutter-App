import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> users = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRandomUsers();
  }

  Future<void> fetchRandomUsers() async {
    setState(() => isLoading = true);

    final response =
        await http.get(Uri.parse('https://randomuser.me/api/?results=20'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'] as List;

      setState(() {
        users = results
        .map((user) => {
              'name':
                  '${user['name']['title'] as String} ${user['name']['first'] as String} ${user['name']['last'] as String}',
              'email': user['email'] as String,
              'picture': user['picture']['thumbnail'] as String,
        })
      .toList();
  isLoading = false;
});

    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: fetchRandomUsers,
          )
        ],
      ),
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
                SizedBox(width: 16),
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
            SizedBox(height: 16),

            // 👤 List of Random Users
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final user = users[index];
                        return Card(
                          elevation: 3,
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(user['picture']!),
                            ),
                            title: Text(user['name']!),
                            subtitle: Text(user['email']!),
                          ),
                        );
                      },
                    ),
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
    return Scaffold(
      appBar: AppBar(title: Text("Create User")),
      body: Center(
        child: Text("Create User Form goes here"),
      ),
    );
  }
}
