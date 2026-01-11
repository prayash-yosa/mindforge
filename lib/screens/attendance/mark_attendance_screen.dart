import 'package:flutter/material.dart';
import 'package:mindforge_app/widgets/premium_app_bar.dart';

class MarkAttendanceScreen extends StatefulWidget {
  const MarkAttendanceScreen({super.key});

  @override
  State<MarkAttendanceScreen> createState() => _MarkAttendanceScreenState();
}

class _MarkAttendanceScreenState extends State<MarkAttendanceScreen> {
  final List<Map<String, dynamic>> _students = [
    {
      'id': '1',
      'name': 'Rahul Sharma',
      'rollNumber': '101',
      'isPresent': true,
      'attendance': '92%',
    },
    {
      'id': '2',
      'name': 'Priya Patel',
      'rollNumber': '102',
      'isPresent': true,
      'attendance': '88%',
    },
    {
      'id': '3',
      'name': 'Amit Kumar',
      'rollNumber': '103',
      'isPresent': false,
      'attendance': '95%',
    },
    {
      'id': '4',
      'name': 'Sneha Singh',
      'rollNumber': '104',
      'isPresent': true,
      'attendance': '82%',
    },
    {
      'id': '5',
      'name': 'Rohan Mehta',
      'rollNumber': '105',
      'isPresent': true,
      'attendance': '90%',
    },
    {
      'id': '6',
      'name': 'Anjali Gupta',
      'rollNumber': '106',
      'isPresent': null, // Not marked yet
      'attendance': '85%',
    },
  ];

  final DateTime _selectedDate = DateTime.now();
  int _presentCount = 0;
  int _absentCount = 0;

  @override
  void initState() {
    super.initState();
    _calculateCounts();
  }

  void _calculateCounts() {
    _presentCount = _students.where((s) => s['isPresent'] == true).length;
    _absentCount = _students.where((s) => s['isPresent'] == false).length;
  }

  void _toggleAttendance(int index) {
    setState(() {
      final student = _students[index];
      if (student['isPresent'] == null) {
        student['isPresent'] = true;
      } else if (student['isPresent'] == true) {
        student['isPresent'] = false;
      } else {
        student['isPresent'] = null;
      }
      _calculateCounts();
    });
  }

  void _markAllPresent() {
    setState(() {
      for (var student in _students) {
        student['isPresent'] = true;
      }
      _calculateCounts();
    });
  }

  void _markAllAbsent() {
    setState(() {
      for (var student in _students) {
        student['isPresent'] = false;
      }
      _calculateCounts();
    });
  }

  void _clearAll() {
    setState(() {
      for (var student in _students) {
        student['isPresent'] = null;
      }
      _calculateCounts();
    });
  }

  void _submitAttendance() {
    // In real app, save to backend
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Attendance marked successfully!'),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PremiumAppBar(
        title: 'Mark Attendance',
        showBackButton: true,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            // Date and Stats Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF0A2F69).withOpacity(0.05),
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade200),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Today\'s Attendance',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () {
                          // Date picker would go here
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildAttendanceStat('Total', _students.length.toString(), Icons.group),
                      ),
                      Expanded(
                        child: _buildAttendanceStat('Present', _presentCount.toString(), Icons.check_circle, Colors.green),
                      ),
                      Expanded(
                        child: _buildAttendanceStat('Absent', _absentCount.toString(), Icons.cancel, Colors.red),
                      ),
                      Expanded(
                        child: _buildAttendanceStat('Pending', (_students.length - _presentCount - _absentCount).toString(), Icons.pending, Colors.orange),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Quick Action Buttons
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade200),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(child: _buildActionButton('Mark All Present', Icons.check, Colors.green, _markAllPresent)),
                  Flexible(child: _buildActionButton('Mark All Absent', Icons.close, Colors.red, _markAllAbsent)),
                  Flexible(child: _buildActionButton('Clear All', Icons.refresh, Colors.orange, _clearAll)),
                ],
              ),
            ),

            // Students List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _students.length,
                itemBuilder: (context, index) {
                  final student = _students[index];
                  return _buildStudentAttendanceCard(student, index);
                },
              ),
            ),

            // Submit Button
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Colors.grey.shade200),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submitAttendance,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0A2F69),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Submit Attendance',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendanceStat(String title, String value, IconData icon, [Color? color]) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: (color ?? const Color(0xFF0A2F69)).withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 20, color: color ?? const Color(0xFF0A2F69)),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: color ?? const Color(0xFF0A2F69),
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(String label, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentAttendanceCard(Map<String, dynamic> student, int index) {
    final isPresent = student['isPresent'];
    Color statusColor = Colors.grey;
    IconData statusIcon = Icons.pending;
    String statusText = 'Pending';

    if (isPresent == true) {
      statusColor = Colors.green;
      statusIcon = Icons.check_circle;
      statusText = 'Present';
    } else if (isPresent == false) {
      statusColor = Colors.red;
      statusIcon = Icons.cancel;
      statusText = 'Absent';
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Student Info
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF0A2F69).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                student['rollNumber'],
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0A2F69),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  student['name'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Overall: ${student['attendance']}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),

          // Attendance Status
          GestureDetector(
            onTap: () => _toggleAttendance(index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: statusColor.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(statusIcon, size: 16, color: statusColor),
                  const SizedBox(width: 6),
                  Text(
                    statusText,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: statusColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}