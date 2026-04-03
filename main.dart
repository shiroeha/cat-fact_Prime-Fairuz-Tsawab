import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'locator.dart';
import 'providers/fact_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FactProvider()),
      ],
      child: MaterialApp(
        title: 'Cat Facts',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FactProvider>();

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 221, 216, 216),
      appBar: AppBar(title: const Text('Cat Facts Generator'), backgroundColor: Color.fromARGB(255, 252, 200, 132),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: Card(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: provider.isLoading
                        ? const CircularProgressIndicator()
                        : Text(
                            provider.currentFact,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 18),
                          ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.read<FactProvider>().getRandomFact(), 
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 255, 209, 148),
                foregroundColor: Color.fromARGB(255, 0, 0, 0)
              ),
              child: const Text('Ambil Fakta Baru'),
            ),
            ElevatedButton(
              onPressed: () => context.read<FactProvider>().saveCurrentFact(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 41, 105, 148),
                foregroundColor: Color.fromARGB(255, 223, 223, 223)
              ),
              child: const Text('Simpan Fakta Ini'),
            ),
            const Divider(height: 32),
            const Text('Fakta Tersimpan:', style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              flex: 2,
              child: ListView.builder(
                itemCount: provider.savedFacts.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(provider.savedFacts[index]),
                    leading: const Icon(Icons.check),
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