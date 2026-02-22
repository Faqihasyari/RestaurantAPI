import 'package:flutter/material.dart';
import 'package:permission1/core/widgets/listPage/error_view.dart';
import 'package:provider/provider.dart';
import '../providers/reminder_provider.dart';
import '../../core/utils/result_state.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pengaturan')),
      body: Consumer<ReminderProvider>(
        builder: (context, provider, _) {
          final state = provider.state;

          if (state is Loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ErrorState<void>) {
            return ErrorView(
              message: state.message,
              onRetry: () {
                provider.toggle(!provider.isEnabled);
              },
            );
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.notifications_active),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Daily Reminder',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Aktifkan notifikasi rekomendasi restoran harian',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: provider.isEnabled,
                      onChanged: (value) {
                        provider.toggle(value);
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
