import 'package:flutter/material.dart';

import 'package:managementt/components/task_velocity_chart.dart';
import 'package:managementt/components/project_health_section.dart';
import 'package:managementt/components/team_task_distribution.dart';
import 'package:managementt/components/top_contributors.dart';
import 'package:managementt/components/priority_breakdown.dart';
import 'package:managementt/components/deadlines_at_risk.dart';

class AnalyticsPage extends StatefulWidget {
  @override
  _AnalyticsPageState createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // we are not using the default AppBar so we can create a custom header
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // header with gradient
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Analytics',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Performance overview · Mar 9, 2026',
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 5),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(Icons.search, color: Colors.white),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        _StatCard(
                          color: Color(0xFF2ECC71),
                          label: 'Completion Rate',
                          value: '26%',
                          subtitle: '5 of 19 tasks',
                        ),
                        _StatCard(
                          color: Color(0xFF3498DB),
                          label: 'On‑Time Rate',
                          value: '58%',
                          subtitle: '8 tasks overdue',
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        _StatCard(
                          color: Color(0xFFF39C12),
                          label: 'Team Velocity',
                          value: '3.2',
                          subtitle: 'tasks completed / week',
                        ),
                        _StatCard(
                          color: Color(0xFF9B59B6),
                          label: 'Task Coverage',
                          value: '100%',
                          subtitle: '19 of 19 assigned',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Task Velocity Trend Chart
              const TaskVelocityChart(),
              const SizedBox(height: 16),
              // Project Health Section
              const ProjectHealthSection(),
              const SizedBox(height: 24),

              // Team Task Distribution
              const TeamTaskDistribution(),
              const SizedBox(height: 16),
              // Top Contributors
              const TopContributors(),
              const SizedBox(height: 24),
              // Priority Breakdown
              const PriorityBreakdown(),
              const SizedBox(height: 24),
              // Deadlines at Risk
              const DeadlinesAtRisk(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

// small card widget for the four metrics
class _StatCard extends StatelessWidget {
  final Color color;
  final String label;
  final String value;
  final String subtitle;

  const _StatCard({
    required this.color,
    required this.label,
    required this.value,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width - 56) / 2,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
