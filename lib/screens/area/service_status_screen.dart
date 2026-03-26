import 'package:flutter/material.dart';
import '../../theme/colours.dart';
import '../../theme/typography.dart';
import '../../widgets/common/status_badge.dart';

class ServiceStatusScreen extends StatefulWidget {
  const ServiceStatusScreen({super.key});

  @override
  State<ServiceStatusScreen> createState() => _ServiceStatusScreenState();
}

class _ServiceStatusScreenState extends State<ServiceStatusScreen> {
  int? _selectedDayOffset;

  static const List<_CalendarEvent> _mockEvents = [
    _CalendarEvent(dayOffset: 3, type: _EventType.due, title: 'Water Bill Due', time: '23:59'),
    _CalendarEvent(dayOffset: 5, type: _EventType.maintenance, title: 'Planned Water Maintenance', time: '08:00 to 14:00'),
    _CalendarEvent(dayOffset: 7, type: _EventType.outage, title: 'Scheduled Power Outage', time: '06:00 to 12:00'),
    _CalendarEvent(dayOffset: 12, type: _EventType.due, title: 'Electricity Bill Due', time: '23:59'),
  ];

  _CalendarEvent? get _selectedEvent {
    if (_selectedDayOffset == null) return null;
    for (final event in _mockEvents) {
      if (event.dayOffset == _selectedDayOffset) return event;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return Scaffold(
      backgroundColor: AppColours.voidBlack,
      body: Stack(
        children: [
          // Atmospheric gradient orbs
          IgnorePointer(
            child: Stack(
              children: [
                Positioned(
                  top: -40,
                  right: -60,
                  child: Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          AppColours.primaryPurple.withValues(alpha: 0.12),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 200,
                  left: -80,
                  child: Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          AppColours.deepViolet.withValues(alpha: 0.10),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Main content
          SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Semantics(
                header: true,
                child: Text(
                  'Your Area',
                  style: AppTypography.headlineMedium,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.location_on, size: 14, color: AppColours.textSecondary),
                  const SizedBox(width: 4),
                  Text(
                    'Sunnyside, Tshwane',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColours.textSecondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Municipal Calendar
              SizedBox(
                height: 80,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(14, (index) {
                      final day = now.add(Duration(days: index));
                      final isToday = index == 0;
                      final isSelected = _selectedDayOffset == index;
                      final event = _mockEvents.cast<_CalendarEvent?>().firstWhere(
                        (e) => e!.dayOffset == index,
                        orElse: () => null,
                      );

                      return Semantics(
                        button: true,
                        label: 'Select ${_dayAbbreviation(day.weekday)} ${day.day}',
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedDayOffset = _selectedDayOffset == index ? null : index;
                            });
                          },
                          child: Container(
                          width: 48,
                          margin: EdgeInsets.only(right: index < 13 ? 8 : 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _dayAbbreviation(day.weekday),
                                style: AppTypography.bodySmall.copyWith(
                                  color: AppColours.textTertiary,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isToday
                                      ? AppColours.primaryPurple
                                      : isSelected
                                          ? AppColours.elevatedSurface
                                          : Colors.transparent,
                                  border: isSelected && !isToday
                                      ? Border.all(color: AppColours.primaryPurple, width: 1.5)
                                      : null,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  '${day.day}',
                                  style: AppTypography.amountMedium.copyWith(
                                    color: isToday
                                        ? AppColours.textPrimary
                                        : AppColours.textSecondary,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              if (event != null)
                                Container(
                                  width: 4,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: event.dotColour,
                                  ),
                                )
                              else
                                const SizedBox(width: 4, height: 4),
                            ],
                          ),
                        ),
                      ),
                      );
                    }),
                  ),
                ),
              ),

              // Event detail card
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                height: _selectedEvent != null ? null : 0,
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(),
                child: _selectedEvent != null
                    ? Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColours.surface,
                            border: Border.all(color: AppColours.borderSubtle),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              StatusBadge(
                                label: _selectedEvent!.typeLabel,
                                color: _selectedEvent!.dotColour,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                _selectedEvent!.title,
                                style: AppTypography.amountMedium.copyWith(
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _selectedEvent!.time,
                                style: AppTypography.bodySmall.copyWith(
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),

              const SizedBox(height: 24),

              // Service Health
              Text(
                'Service Health',
                style: AppTypography.amountMedium,
              ),
              const SizedBox(height: 12),

              _HealthRow(
                icon: Icons.check_circle,
                iconColour: AppColours.emerald,
                service: 'Water Supply',
                status: 'Operating normally',
                statusColour: AppColours.emerald,
              ),
              const SizedBox(height: 12),
              _HealthRow(
                icon: Icons.warning_rounded,
                iconColour: AppColours.amber,
                service: 'Electricity',
                status: 'Stage 2 Load Shedding',
                statusColour: AppColours.amber,
              ),
              const SizedBox(height: 12),
              _HealthRow(
                icon: Icons.check_circle,
                iconColour: AppColours.emerald,
                service: 'Waste Collection',
                status: 'On schedule',
                statusColour: AppColours.emerald,
              ),

              const SizedBox(height: 24),

              // Active Alerts
              Text(
                'Active Alerts',
                style: AppTypography.amountMedium,
              ),
              const SizedBox(height: 12),

              _AlertCard(
                borderColour: AppColours.amber,
                badge: const StatusBadge(label: 'Load Shedding', color: AppColours.amber),
                title: 'Stage 2 Load Shedding',
                area: 'Sunnyside, Block 4',
                description: '16:00 to 18:30 today',
              ),
              const SizedBox(height: 12),
              _AlertCard(
                borderColour: AppColours.info,
                badge: const StatusBadge(label: 'Maintenance', color: AppColours.info),
                title: 'Planned Maintenance',
                area: 'Sunnyside',
                description: '28 March 08:00 to 14:00',
              ),
              const SizedBox(height: 12),
              _AlertCard(
                borderColour: AppColours.crimson,
                badge: const StatusBadge(label: 'Notice', color: AppColours.crimson),
                title: 'Tariff Increase Notice',
                area: 'City of Tshwane',
                description: 'New rates effective 1 July 2026',
              ),
            ],
          ),
        ),
          ),
        ],
      ),
    );
  }

  String _dayAbbreviation(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'Mon';
      case DateTime.tuesday:
        return 'Tue';
      case DateTime.wednesday:
        return 'Wed';
      case DateTime.thursday:
        return 'Thu';
      case DateTime.friday:
        return 'Fri';
      case DateTime.saturday:
        return 'Sat';
      case DateTime.sunday:
        return 'Sun';
      default:
        return '';
    }
  }
}

class _HealthRow extends StatelessWidget {
  final IconData icon;
  final Color iconColour;
  final String service;
  final String status;
  final Color statusColour;

  const _HealthRow({
    required this.icon,
    required this.iconColour,
    required this.service,
    required this.status,
    required this.statusColour,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColours.surface,
        border: Border.all(color: AppColours.borderSubtle),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, size: 24, color: iconColour),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service,
                  style: AppTypography.amountMedium.copyWith(
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  status,
                  style: AppTypography.bodySmall.copyWith(
                    fontSize: 13,
                    color: statusColour,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AlertCard extends StatelessWidget {
  final Color borderColour;
  final StatusBadge badge;
  final String title;
  final String area;
  final String description;

  const _AlertCard({
    required this.borderColour,
    required this.badge,
    required this.title,
    required this.area,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColours.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border(
          left: BorderSide(color: borderColour, width: 4),
          top: BorderSide(color: AppColours.borderSubtle),
          right: BorderSide(color: AppColours.borderSubtle),
          bottom: BorderSide(color: AppColours.borderSubtle),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          badge,
          const SizedBox(height: 8),
          Text(
            title,
            style: AppTypography.amountMedium.copyWith(
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            area,
            style: AppTypography.bodySmall.copyWith(
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: AppTypography.bodySmall.copyWith(
              fontSize: 13,
              color: AppColours.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}

enum _EventType { due, maintenance, outage }

class _CalendarEvent {
  final int dayOffset;
  final _EventType type;
  final String title;
  final String time;

  const _CalendarEvent({
    required this.dayOffset,
    required this.type,
    required this.title,
    required this.time,
  });

  Color get dotColour {
    switch (type) {
      case _EventType.due:
        return AppColours.amber;
      case _EventType.maintenance:
        return AppColours.info;
      case _EventType.outage:
        return AppColours.crimson;
    }
  }

  String get typeLabel {
    switch (type) {
      case _EventType.due:
        return 'Due Date';
      case _EventType.maintenance:
        return 'Maintenance';
      case _EventType.outage:
        return 'Outage';
    }
  }
}
