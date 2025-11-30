import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Settings'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Theme',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                RadioListTile<ThemeMode>(
                  title: const Text('System'),
                  value: ThemeMode.system,
                  groupValue: themeProvider.themeMode,
                  onChanged: (value) {
                    if (value != null) {
                      themeProvider.setThemeMode(value);
                    }
                  },
                ),
                RadioListTile<ThemeMode>(
                  title: const Text('Light'),
                  value: ThemeMode.light,
                  groupValue: themeProvider.themeMode,
                  onChanged: (value) {
                    if (value != null) {
                      themeProvider.setThemeMode(value);
                    }
                  },
                ),
                RadioListTile<ThemeMode>(
                  title: const Text('Dark'),
                  value: ThemeMode.dark,
                  groupValue: themeProvider.themeMode,
                  onChanged: (value) {
                    if (value != null) {
                      themeProvider.setThemeMode(value);
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Accent Color',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8.0),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: [
                    _buildColorOption(context, Colors.deepPurple, themeProvider),
                    _buildColorOption(context, Colors.blue, themeProvider),
                    _buildColorOption(context, Colors.green, themeProvider),
                    _buildColorOption(context, Colors.orange, themeProvider),
                    _buildColorOption(context, Colors.pink, themeProvider),
                    _buildColorOption(context, Colors.teal, themeProvider),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildColorOption(
      BuildContext context, Color color, ThemeProvider themeProvider) {
    final bool isSelected = themeProvider.primaryColor == color;
    return GestureDetector(
      onTap: () {
        themeProvider.setPrimaryColor(color);
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: isSelected
              ? Border.all(
                  color: Theme.of(context).colorScheme.onSurface,
                  width: 2.0,
                )
              : null,
        ),
      ),
    );
  }
}
