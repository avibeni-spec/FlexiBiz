import 'package:flutter/material.dart';
import '../state/mock_appointments.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime selectedDate = DateTime.now();

  static const double _slotHeight = 80;
  static const int _snapMinutes = 15;

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  int _snapToQuarter(int minute) {
    return ((minute / _snapMinutes).round() * _snapMinutes).clamp(0, 45);
  }

  bool _hasConflict(Appointment moving, DateTime newStart) {
    final newEnd = newStart.add(moving.duration);

    for (final a in MockAppointments.all) {
      if (a == moving) continue;
      if (!_isSameDay(a.dateTime, newStart)) continue;

      final existingStart = a.dateTime;
      final existingEnd = a.endTime;

      if (newStart.isBefore(existingEnd) &&
          newEnd.isAfter(existingStart)) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final appointments = MockAppointments.all
        .where((a) => _isSameDay(a.dateTime, selectedDate))
        .toList()
      ..sort((a, b) => a.dateTime.compareTo(b.dateTime));

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Day Timeline",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text(
                    "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                    style: const TextStyle(color: Colors.white54),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Expanded(
                child: ListView.builder(
                  itemCount: 13, // 08–20
                  itemBuilder: (context, index) {
                    final hour = 8 + index;

                    final slotAppointments =
                        appointments.where((a) => a.dateTime.hour == hour);

                    return SizedBox(
                      height: _slotHeight,
                      child: DragTarget<Appointment>(
                        onAcceptWithDetails: (details) async {
                          final moving = details.data;

                          final RenderBox box =
                              context.findRenderObject() as RenderBox;
                          final localOffset =
                              box.globalToLocal(details.offset);
                          final relativeY = localOffset.dy % _slotHeight;

                          final rawMinute =
                              ((relativeY / _slotHeight) * 60).round();
                          final snappedMinute =
                              _snapToQuarter(rawMinute);

                          final newStart = DateTime(
                            selectedDate.year,
                            selectedDate.month,
                            selectedDate.day,
                            hour,
                            snappedMinute,
                          );

                          if (_hasConflict(moving, newStart)) {
                            await _showConflictDialog(context);
                            return;
                          }

                          final confirmed = await _confirmMoveDialog(
                            context,
                            moving,
                            newStart,
                          );

                          if (confirmed) {
                            setState(() {
                              MockAppointments.replace(
                                moving,
                                Appointment(
                                  dateTime: newStart,
                                  duration: moving.duration,
                                  client: moving.client,
                                  service: moving.service,
                                  status: moving.status,
                                ),
                              );
                            });
                          }
                        },
                        builder: (context, candidate, rejected) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1A1A1A),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 64,
                                  child: Text(
                                    "${hour.toString().padLeft(2, '0')}:00",
                                    style: const TextStyle(
                                      color: Colors.white54,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: slotAppointments.isEmpty
                                      ? const Text(
                                          "—",
                                          style: TextStyle(
                                              color: Colors.white38),
                                        )
                                      : Column(
                                          children: slotAppointments
                                              .map(_tile)
                                              .toList(),
                                        ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tile(Appointment a) {
    final blocks = (a.duration.inMinutes / 60).ceil();

    return Draggable<Appointment>(
      data: a,
      childWhenDragging:
          Opacity(opacity: 0.4, child: _tileContent(a)),
      feedback: _dragPreview(a),
      child: SizedBox(
        height: 60.0 * blocks,
        child: _tileContent(a),
      ),
    );
  }

  Widget _tileContent(Appointment a) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Text(
            "${a.timeLabel} (${a.duration.inMinutes}m)",
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              "${a.client} • ${a.service}",
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dragPreview(Appointment a) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          "${a.timeLabel} (${a.duration.inMinutes}m)",
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Future<bool> _confirmMoveDialog(
    BuildContext context,
    Appointment a,
    DateTime newStart,
  ) async {
    return (await showDialog<bool>(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("Confirm Move"),
            content: Text(
              "Move ${a.client} to "
              "${newStart.hour.toString().padLeft(2, '0')}:"
              "${newStart.minute.toString().padLeft(2, '0')} "
              "for ${a.duration.inMinutes} minutes?",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text("Confirm"),
              ),
            ],
          ),
        )) ??
        false;
  }

  Future<void> _showConflictDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (_) => const AlertDialog(
        title: Text("Time Conflict"),
        content: Text("Another appointment overlaps this time."),
      ),
    );
  }
}