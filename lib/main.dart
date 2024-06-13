import 'package:autofill_test/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:url_launcher/link.dart';

void main() {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final String beforeUrl = Uri.base.replace(
    fragment: null,
    path: '/before',
  ).toString();
  final String afterUrl = Uri.base.replace(
    fragment: null,
    path: '/after',
  ).toString();

  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Autofill Test')),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            AutofillGroup(
              child: Column(
                children: [
                  TextField(
                    controller: emailController,
                    autofillHints: const [AutofillHints.email],
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: passwordController,
                    autofillHints: const [AutofillHints.password],
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                emailController.clear();
                passwordController.clear();
              },
              child: const Text('Clear'),
            ),
            if (kIsWeb) ...[
              const SizedBox(height: 16),
              const Text(kFlutterInfo),
              Text(
                'Built ${GetTimeAgo.parse(DateTime.fromMillisecondsSinceEpoch(kBuildDate))}\n',
              ),
              Row(
                children: [
                  Text('View app built with #51009'),
                  LinkButton(label: 'before', url: beforeUrl),
                  Text('/'),
                  LinkButton(label: 'after', url: afterUrl),
                  Text('/'),
                  LinkButton(label: 'PR', url: 'https://github.com/flutter/engine/pull/51009', target: LinkTarget.blank,),
                ],
              ),
            ],
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerLeft,
              child: LinkButton(
                label: 'View repository',
                url: 'https://github.com/Rexios80/flutter_autofill_test',
                target: LinkTarget.blank,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class LinkButton extends StatelessWidget {
  final String label;
  final String url;
  final LinkTarget target;

  const LinkButton({super.key, required this.label, required this.url, this.target = LinkTarget.self});

  @override
  Widget build(BuildContext context) {
    return Link(
      builder:(context, followLink) {
        return TextButton(
          onPressed: followLink,
          child: Text(label),
        );
      },
      target: target,
      uri: Uri.parse(url),
    );
  }
}
