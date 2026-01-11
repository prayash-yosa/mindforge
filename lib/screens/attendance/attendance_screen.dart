import 'package:flutter/material.dart';
import 'package:mindforge_app/widgets/premium_app_bar.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentMonth = DateTime.now();
    final daysInMonth = DateTime(currentMonth.year, currentMonth.month + 1, 0).day;
    
    // Mock attendance data for current month
    final attendanceData = {
      1: 'P', 2: 'P', 3: 'P', 4: 'P', 5: 'P', 6: 'H', 7: 'H', // H = Holiday
      8: 'P', 9: 'P', 10: 'P', 11: 'P', 12: 'P', 13: 'L', 14: 'P', // L = Late
      15: 'P', 16: 'P', 17: 'P', 18: 'A', 19: 'P', 20: 'P', 21: 'H', // A = Absent
      22: 'P', 23: 'P', 24: 'P', 25: 'P', 26: 'P', 27: 'L', 28: 'P',
      29: 'P', 30: 'P',
    };

    // Calculate statistics
    final totalDays = attendanceData.length;
    final presentDays = attendanceData.values.where((status) => status == 'P').length;
    final absentDays = attendanceData.values.where((status) => status == 'A').length;
    final lateDays = attendanceData.values.where((status) => status == 'L').length;
    final holidayDays = attendanceData.values.where((status) => status == 'H').length;
    final attendancePercentage = (presentDays / totalDays * 100).toInt();

    return Scaffold(
      appBar: PremiumAppBar(
        title: 'Attendance',
        showBackButton: true,
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Current Month Stats
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0A2F69).withOpacity(0.05),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFF0A2F69).withOpacity(0.1),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${_getMonthName(currentMonth.month)} ${currentMonth.year}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: _getAttendanceColor(attendancePercentage),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '$attendancePercentage%',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      
                      // Attendance Stats Grid - Fixed sizing
                      Row(
                        children: [
                          Expanded(child: _buildStatCard('Present', presentDays.toString(), Icons.check_circle, Colors.green)),
                          const SizedBox(width: 8),
                          Expanded(child: _buildStatCard('Absent', absentDays.toString(), Icons.cancel, Colors.red)),
                          const SizedBox(width: 8),
                          Expanded(child: _buildStatCard('Late', lateDays.toString(), Icons.access_time, Colors.orange)),
                          const SizedBox(width: 8),
                          Expanded(child: _buildStatCard('Holiday', holidayDays.toString(), Icons.beach_access, Colors.blue)),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Monthly Calendar
                const Text(
                  'Monthly Calendar',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Your attendance for ${_getMonthName(currentMonth.month)}',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),

                const SizedBox(height: 16),

                // Calendar Grid
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    children: [
                      // Day headers
                      Row(
                        children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'].map((day) => 
                          Expanded(
                            child: Center(
                              child: Text(
                                day,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                          ),
                        ).toList(),
                      ),

                      const SizedBox(height: 8),

                      // Calendar days
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 7,
                          childAspectRatio: 1,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                        ),
                        itemCount: daysInMonth + _getEmptyCellsCount(currentMonth),
                        itemBuilder: (context, index) {
                          // First row might have empty cells
                          final emptyCells = _getEmptyCellsCount(currentMonth);
                          if (index < emptyCells) {
                            return Container(); // Empty cell
                          }
                          
                          final day = index - emptyCells + 1;
                          final status = attendanceData[day];
                          final isToday = day == currentMonth.day;
                          
                          return Container(
                            decoration: BoxDecoration(
                              color: isToday 
                                  ? const Color(0xFF0A2F69).withOpacity(0.1)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isToday ? const Color(0xFF0A2F69) : Colors.transparent,
                                width: 1.5,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  day.toString(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: isToday ? FontWeight.w700 : FontWeight.normal,
                                    color: isToday ? const Color(0xFF0A2F69) : Colors.grey.shade800,
                                  ),
                                ),
                                if (status != null) ...[
                                  const SizedBox(height: 2),
                                  Container(
                                    width: 16,
                                    height: 16,
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(status),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        status,
                                        style: const TextStyle(
                                          fontSize: 8,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Attendance Legend
                const Text(
                  'Legend',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),

                Wrap(
                  spacing: 16,
                  runSpacing: 12,
                  children: [
                    _buildLegendItem('P - Present', Colors.green),
                    _buildLegendItem('A - Absent', Colors.red),
                    _buildLegendItem('L - Late', Colors.orange),
                    _buildLegendItem('H - Holiday', Colors.blue),
                  ],
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: color.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String text, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade700,
          ),
        ),
      ],
    );
  }

  Color _getAttendanceColor(int percentage) {
    if (percentage >= 90) return Colors.green;
    if (percentage >= 75) return Colors.orange;
    return Colors.red;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'P': return Colors.green;
      case 'A': return Colors.red;
      case 'L': return Colors.orange;
      case 'H': return Colors.blue;
      default: return Colors.grey;
    }
  }

  String _getMonthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }

  // Helper function to get number of empty cells before first day of month
  int _getEmptyCellsCount(DateTime currentMonth) {
    final firstDayOfMonth = DateTime(currentMonth.year, currentMonth.month, 1);
    return firstDayOfMonth.weekday - 1; // Sunday = 0, Monday = 1, etc.
  }
}