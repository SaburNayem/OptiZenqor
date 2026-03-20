import 'package:flutter/material.dart';

void main() {
  runApp(const OptiZenqorApp());
}

class OptiZenqorApp extends StatelessWidget {
  const OptiZenqorApp({super.key});

  @override
  Widget build(BuildContext context) {
    const canvas = Color(0xFFF6F1E8);
    const ink = Color(0xFF102A43);
    const coral = Color(0xFFF26B5B);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OptiZenqor',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: coral,
          brightness: Brightness.light,
          surface: Colors.white,
        ),
        scaffoldBackgroundColor: canvas,
        textTheme: Typography.blackMountainView.copyWith(
          headlineLarge: const TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.w800,
            color: ink,
            height: 1.05,
          ),
          headlineSmall: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: ink,
          ),
          titleLarge: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: ink,
          ),
          bodyLarge: const TextStyle(fontSize: 16, height: 1.5, color: ink),
          bodyMedium: TextStyle(
            fontSize: 14,
            height: 1.45,
            color: ink.withValues(alpha: 0.75),
          ),
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
      ),
      home: const DashboardPage(),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  static const _focusTasks = <FocusTask>[
    FocusTask(
      title: 'Prepare sprint priorities',
      duration: '45 min deep work',
      progress: 0.8,
    ),
    FocusTask(
      title: 'Review team check-in notes',
      duration: '20 min reflection',
      progress: 0.45,
    ),
    FocusTask(
      title: 'Finish habit analytics flow',
      duration: '60 min build',
      progress: 0.6,
    ),
  ];

  static const _habits = <HabitStat>[
    HabitStat(label: 'Focus blocks', streak: '12 days', value: 0.82),
    HabitStat(label: 'Water intake', streak: '9 days', value: 0.68),
    HabitStat(label: 'Sleep target', streak: '7 days', value: 0.74),
  ];

  static const _timeline = <TimelineItem>[
    TimelineItem(
      time: '08:30',
      title: 'Morning alignment',
      subtitle: 'Check goals, blockers, and schedule adjustments.',
    ),
    TimelineItem(
      time: '11:00',
      title: 'Momentum review',
      subtitle: 'Measure focus score and celebrate completed work.',
    ),
    TimelineItem(
      time: '16:30',
      title: 'Reset routine',
      subtitle: 'Wrap tasks, note wins, and plan tomorrow.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final wide = constraints.maxWidth >= 920;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: wide
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 6,
                              child: _PrimaryColumn(theme: theme),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              flex: 4,
                              child: _SideColumn(
                                habits: _habits,
                                timeline: _timeline,
                              ),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _PrimaryColumn(theme: theme),
                            const SizedBox(height: 20),
                            _SideColumn(habits: _habits, timeline: _timeline),
                          ],
                        ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _PrimaryColumn extends StatelessWidget {
  const _PrimaryColumn({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _HeroCard(),
        const SizedBox(height: 20),
        Text('Today\'s focus map', style: theme.textTheme.headlineSmall),
        const SizedBox(height: 12),
        const _TaskGrid(),
        const SizedBox(height: 20),
        const _InsightStrip(),
      ],
    );
  }
}

class _SideColumn extends StatelessWidget {
  const _SideColumn({required this.habits, required this.timeline});

  final List<HabitStat> habits;
  final List<TimelineItem> timeline;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _PanelCard(
          title: 'Habit consistency',
          child: Column(
            children: habits
                .map(
                  (habit) => Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: _HabitTile(habit: habit),
                  ),
                )
                .toList(),
          ),
        ),
        const SizedBox(height: 20),
        _PanelCard(
          title: 'Daily rhythm',
          child: Column(
            children: timeline
                .map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 18),
                    child: _TimelineTile(item: item),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(36),
        gradient: const LinearGradient(
          colors: [Color(0xFF11324D), Color(0xFF1E5F74), Color(0xFF9BB89D)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(999),
              ),
              child: const Text(
                'OPTIMIZE YOUR ENERGY',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'OptiZenqor',
              style: theme.textTheme.titleLarge?.copyWith(
                color: Colors.white,
                letterSpacing: 0.4,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'OptiZenqor keeps your goals, habits, and focus sessions in one calm command center.',
              style: theme.textTheme.headlineLarge?.copyWith(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Track progress, protect deep work, and turn daily routines into visible momentum.',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: Colors.white.withValues(alpha: 0.88),
              ),
            ),
            const SizedBox(height: 26),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: const [
                _MetricChip(label: 'Focus score', value: '86%'),
                _MetricChip(label: 'Completed today', value: '7 tasks'),
                _MetricChip(label: 'Current streak', value: '12 days'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TaskGrid extends StatelessWidget {
  const _TaskGrid();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 1080
            ? 3
            : constraints.maxWidth >= 680
            ? 2
            : 1;
        if (columns == 1) {
          return Column(
            children: DashboardPage._focusTasks
                .map(
                  (task) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _TaskCard(task: task),
                  ),
                )
                .toList(),
          );
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: DashboardPage._focusTasks.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: columns == 2 ? 0.95 : 1.02,
          ),
          itemBuilder: (context, index) {
            return _TaskCard(task: DashboardPage._focusTasks[index]);
          },
        );
      },
    );
  }
}

class _TaskCard extends StatelessWidget {
  const _TaskCard({required this.task});

  final FocusTask task;

  @override
  Widget build(BuildContext context) {
    final progressPercent = (task.progress * 100).round();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFFFDE6D8),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.bolt_rounded, color: Color(0xFFF26B5B)),
            ),
            const SizedBox(height: 18),
            Text(task.title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(task.duration),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                value: task.progress,
                minHeight: 10,
                backgroundColor: const Color(0xFFF1E8DE),
                valueColor: const AlwaysStoppedAnimation(Color(0xFF1E5F74)),
              ),
            ),
            const SizedBox(height: 8),
            Text('$progressPercent% ready to complete'),
          ],
        ),
      ),
    );
  }
}

class _InsightStrip extends StatelessWidget {
  const _InsightStrip();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8F1),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0xFFE7DAC8)),
      ),
      child: Wrap(
        spacing: 18,
        runSpacing: 18,
        alignment: WrapAlignment.spaceBetween,
        children: const [
          _InsightTile(
            title: 'Energy peak',
            value: '10:00 AM',
            icon: Icons.sunny,
          ),
          _InsightTile(
            title: 'Most stable habit',
            value: 'Focus blocks',
            icon: Icons.track_changes,
          ),
          _InsightTile(
            title: 'Recovery reminder',
            value: 'Stretch in 18 min',
            icon: Icons.self_improvement,
          ),
        ],
      ),
    );
  }
}

class _PanelCard extends StatelessWidget {
  const _PanelCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 18),
            child,
          ],
        ),
      ),
    );
  }
}

class _HabitTile extends StatelessWidget {
  const _HabitTile({required this.habit});

  final HabitStat habit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                habit.label,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontSize: 17),
              ),
            ),
            Text(habit.streak, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: habit.value,
            minHeight: 9,
            backgroundColor: const Color(0xFFF1E8DE),
            valueColor: const AlwaysStoppedAnimation(Color(0xFF9BB89D)),
          ),
        ),
      ],
    );
  }
}

class _TimelineTile extends StatelessWidget {
  const _TimelineTile({required this.item});

  final TimelineItem item;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 58,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFFDE6D8),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text(
            item.time,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Color(0xFF9F3E33),
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.title, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 6),
              Text(item.subtitle),
            ],
          ),
        ),
      ],
    );
  }
}

class _MetricChip extends StatelessWidget {
  const _MetricChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.72),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _InsightTile extends StatelessWidget {
  const _InsightTile({
    required this.title,
    required this.value,
    required this.icon,
  });

  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: const Color(0xFF1E5F74)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 4),
                Text(value, style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FocusTask {
  const FocusTask({
    required this.title,
    required this.duration,
    required this.progress,
  });

  final String title;
  final String duration;
  final double progress;
}

class HabitStat {
  const HabitStat({
    required this.label,
    required this.streak,
    required this.value,
  });

  final String label;
  final String streak;
  final double value;
}

class TimelineItem {
  const TimelineItem({
    required this.time,
    required this.title,
    required this.subtitle,
  });

  final String time;
  final String title;
  final String subtitle;
}
