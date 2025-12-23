import 'package:flutter/material.dart';

import 'examples/basic_form_example.dart';
import 'examples/registration_example.dart';
import 'examples/login_example.dart';
import 'examples/custom_fields_example.dart';
import 'examples/validation_example.dart';

void main() {
  runApp(const FinalFormsExampleApp());
}

class FinalFormsExampleApp extends StatelessWidget {
  const FinalFormsExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinalForms Examples',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ExampleListScreen(),
    );
  }
}

class ExampleListScreen extends StatelessWidget {
  const ExampleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final examples = [
      ('Basic Form', const BasicFormExample()),
      ('Registration Form', const RegistrationExample()),
      ('Login Form', const LoginExample()),
      ('Custom Fields', const CustomFieldsExample()),
      ('Validation Demo', const ValidationExample()),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('FinalForms Examples'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.separated(
        itemCount: examples.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final (title, widget) = examples[index];
          return ListTile(
            title: Text(title),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => Scaffold(
                  appBar: AppBar(
                    title: Text(title),
                    backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  body: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: widget,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
