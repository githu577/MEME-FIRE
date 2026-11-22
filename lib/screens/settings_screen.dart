import 'package:flutter/material.dart';

import '../services/supabase_service.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Card(
            child: ListTile(
              leading: Icon(Icons.security),
              title: Text('Account Security'),
              subtitle: Text(
                'Authentication managed by Supabase',
              ),
            ),
          ),

          const Card(
            child: ListTile(
              leading: Icon(Icons.palette),
              title: Text('Appearance'),
              subtitle: Text('Dark theme'),
            ),
          ),

          const SizedBox(height: 20),

          FilledButton.icon(
            onPressed: () async {
              try {
                await SupabaseService.logout();

                if (context.mounted) {
                  Navigator.popUntil(
                    context,
                    (route) => route.isFirst,
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                    SnackBar(
                      content: Text(
                        'Sign out failed: $e',
                      ),
                    ),
                  );
                }
              }
            },
            icon: const Icon(Icons.logout),
            label: const Text('Sign Out'),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }
}
