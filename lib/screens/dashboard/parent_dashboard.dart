import 'package:flutter/material.dart';
import 'package:mindforge_app/widgets/premium_app_bar.dart';

class ParentDashboardScreen extends StatelessWidget {
  const ParentDashboardScreen({super.key});

  final Map<String, dynamic> _parentInfo = const {
    'name': 'Mr. Sharma',
    'email': 'sharma@parent.mindforge.guru',
    'phone': '+91 98765 43210',
    'children': ['Rahul Sharma'],
  };

  final Map<String, dynamic> _childInfo = const {
    'name': 'Rahul Sharma',
    'class': 'Class 10',
    'rollNumber': 'STU101',
    'teacher': 'Priya Singh',
    'attendance': '92%',
    'homeworkCompleted': '85%',
    'lastTestScore': '78/100',
    'behavior': 'Good',
  };

  final List<Map<String, dynamic>> _feeDetails = const [
    {
      'month': 'January 2024',
      'amount': '₹2,500',
      'dueDate': '10 Jan 2024',
      'status': 'Paid',
      'paymentDate': '05 Jan 2024',
      'receiptNo': 'RCPT001',
    },
    {
      'month': 'February 2024',
      'amount': '₹2,500',
      'dueDate': '10 Feb 2024',
      'status': 'Paid',
      'paymentDate': '08 Feb 2024',
      'receiptNo': 'RCPT002',
    },
    {
      'month': 'March 2024',
      'amount': '₹2,500',
      'dueDate': '10 Mar 2024',
      'status': 'Pending',
      'paymentDate': '',
      'receiptNo': '',
    },
  ];

  final List<Map<String, dynamic>> _recentActivities = const [
    {
      'title': 'Homework Submitted',
      'description': 'Mathematics: Quadratic Equations',
      'time': '2 hours ago',
      'icon': Icons.assignment_turned_in,
      'color': Colors.green,
    },
    {
      'title': 'Attendance Marked',
      'description': 'Present for today\'s class',
      'time': '1 day ago',
      'icon': Icons.check_circle,
      'color': Colors.blue,
    },
    {
      'title': 'Test Result',
      'description': 'Science Test: 78/100 marks',
      'time': '3 days ago',
      'icon': Icons.assignment,
      'color': Colors.orange,
    },
    {
      'title': 'Fee Reminder',
      'description': 'March fee payment pending',
      'time': '5 days ago',
      'icon': Icons.payments,
      'color': Colors.red,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final pendingFees = _feeDetails
        .where((fee) => fee['status'] == 'Pending')
        .length;
    final totalPaid = _feeDetails
        .where((fee) => fee['status'] == 'Paid')
        .length;

    return Scaffold(
      appBar: PremiumAppBar(
        title: "Parent Dashboard",
        showBackButton: false,
        actions: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF0A2F69).withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: Icon(
                Icons.help_outline,
                size: 20,
                color: const Color(0xFF0A2F69),
              ),
              padding: EdgeInsets.zero,
              onPressed: () {
                _showHelpDialog(context);
              },
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0A2F69).withOpacity(0.05),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFF0A2F69).withOpacity(0.1),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0A2F69),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.family_restroom,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome, ${_parentInfo['name']}",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Parent of ${_childInfo['name']}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(
                                  Icons.email,
                                  size: 14,
                                  color: Colors.grey.shade600,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  _parentInfo['email'],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Child Information
                const Text(
                  "Child Information",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),

                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade200),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: const Color(0xFF0A2F69).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.school,
                              color: Color(0xFF0A2F69),
                              size: 30,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _childInfo['name'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "${_childInfo['class']} • Roll No: ${_childInfo['rollNumber']}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                Text(
                                  "Teacher: ${_childInfo['teacher']}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        childAspectRatio: 2.3,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        children: [
                          _buildChildStat(
                            'Attendance',
                            _childInfo['attendance'],
                            Icons.calendar_today,
                            Colors.green,
                          ),
                          _buildChildStat(
                            'Homework',
                            _childInfo['homeworkCompleted'],
                            Icons.assignment,
                            Colors.blue,
                          ),
                          _buildChildStat(
                            'Last Test',
                            _childInfo['lastTestScore'],
                            Icons.assessment,
                            Colors.orange,
                          ),
                          _buildChildStat(
                            'Behavior',
                            _childInfo['behavior'],
                            Icons.emoji_events,
                            Colors.purple,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Fee Status
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Fee Status",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: pendingFees > 0
                            ? Colors.red.withOpacity(0.1)
                            : Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: pendingFees > 0
                              ? Colors.red.withOpacity(0.3)
                              : Colors.green.withOpacity(0.3),
                        ),
                      ),
                      child: Text(
                        pendingFees > 0 ? '$pendingFees Pending' : 'All Paid',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: pendingFees > 0 ? Colors.red : Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Fee Details
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade200),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _buildFeeStat(
                              'Total Paid',
                              '$totalPaid',
                              Colors.green,
                            ),
                          ),
                          Expanded(
                            child: _buildFeeStat(
                              'Pending',
                              '$pendingFees',
                              Colors.red,
                            ),
                          ),
                          Expanded(
                            child: _buildFeeStat(
                              'Total',
                              '${_feeDetails.length}',
                              Color(0xFF0A2F69),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ..._feeDetails.map((fee) => _buildFeeItem(fee)),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: pendingFees > 0
                              ? () {
                                  _showPaymentDialog(context);
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0A2F69),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Pay Fees Now',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Recent Activities
                const Text(
                  "Recent Activities",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),

                // Activities List
                ..._recentActivities
                    .map((activity) => _buildActivityItem(activity))
                    ,

                const SizedBox(height: 30),

                // Help Button
                Center(
                  child: TextButton.icon(
                    onPressed: () {
                      _showHelpDialog(context);
                    },
                    icon: const Icon(
                      Icons.help_outline,
                      color: Color(0xFF0A2F69),
                    ),
                    label: const Text(
                      'Need Help? Contact Support',
                      style: TextStyle(fontSize: 15, color: Color(0xFF0A2F69)),
                    ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChildStat(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: color),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeeStat(String title, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        Text(
          title,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  Widget _buildFeeItem(Map<String, dynamic> fee) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fee['month'],
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Amount: ${fee['amount']}',
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                ),
                Text(
                  'Due: ${fee['dueDate']}',
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: fee['status'] == 'Paid'
                      ? Colors.green.withOpacity(0.1)
                      : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: fee['status'] == 'Paid'
                        ? Colors.green.withOpacity(0.3)
                        : Colors.red.withOpacity(0.3),
                  ),
                ),
                child: Text(
                  fee['status'],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: fee['status'] == 'Paid' ? Colors.green : Colors.red,
                  ),
                ),
              ),
              if (fee['status'] == 'Paid') ...[
                const SizedBox(height: 4),
                Text(
                  'Paid on: ${fee['paymentDate']}',
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                ),
                Text(
                  'Receipt: ${fee['receiptNo']}',
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> activity) {
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
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: activity['color'].withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(activity['icon'], color: activity['color']),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity['title'],
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  activity['description'],
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          Text(
            activity['time'],
            style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }

  void _showPaymentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Pay Fees"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Selected Month: March 2024",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              const Text(
                "Amount: ₹2,500",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 16),
              const Text(
                "Payment Method",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              ...['Credit/Debit Card', 'UPI', 'Net Banking', 'Cash']
                  .map(
                    (method) => RadioListTile<String>(
                      title: Text(method),
                      value: method,
                      groupValue: 'UPI',
                      onChanged: (value) {},
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  )
                  ,
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Payment successful! Receipt will be emailed."),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0A2F69),
            ),
            child: const Text(
              "Confirm Payment",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.help_outline, color: Color(0xFF0A2F69)),
            SizedBox(width: 8),
            Text("Help & Support"),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Need assistance? We're here to help!",
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 16),
              const Text(
                "Contact Options:",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              _buildHelpOption(
                Icons.phone,
                "Call Support",
                "+91 12345 67890",
                "Available 9AM - 6PM",
              ),
              _buildHelpOption(
                Icons.email,
                "Email Support",
                "support@mindforge.guru",
                "Response within 24 hours",
              ),
              _buildHelpOption(
                Icons.chat,
                "Live Chat",
                "Chat with us",
                "Available 10AM - 4PM",
              ),
              const SizedBox(height: 16),
              const Text(
                "Frequently Asked Questions:",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              ...[
                    "How to check my child's attendance?",
                    "When are fees due?",
                    "How to contact the teacher?",
                    "Where can I see homework status?",
                  ]
                  .map(
                    (question) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.help_outline,
                            size: 16,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              question,
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  ,
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpOption(
    IconData icon,
    String title,
    String value,
    String subtitle,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF0A2F69).withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF0A2F69).withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF0A2F69).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: const Color(0xFF0A2F69)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF0A2F69),
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
