import 'package:flutter/material.dart';

class StudentDashboardScreen extends StatelessWidget {
  const StudentDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
          ),
        ],
      ),

      body: SingleChildScrollView( // Make entire screen scrollable
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Compact Profile Card
              _compactProfileCard(context),
              const SizedBox(height: 16),
              
              // Compact Stats Row
              _compactStatsRow(context),
              const SizedBox(height: 24),
              
              const Text(
                "Quick Access",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              
              // Grid - NOT in Expanded, so it shows all items
              _gridMenu(),
              
              // Add some bottom padding
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _compactProfileCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.person,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Rahul Sharma",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "Class 10 • ID: STU10417",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: Colors.grey.shade400,
          ),
        ],
      ),
    );
  }

  Widget _compactStatsRow(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _compactStatItem("Subjects", "06", Icons.book_outlined, context),
          _compactStatItem("Homework", "04", Icons.assignment_outlined, context),
          _compactStatItem("Attendance", "92%", Icons.calendar_today_outlined, context),
        ],
      ),
    );
  }

  Widget _compactStatItem(String title, String value, IconData icon, BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: Theme.of(context).colorScheme.primary,
                size: 18,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _gridMenu() {
    final List<Map<String, dynamic>> items = [
      {
        "title": "Subjects",
        "icon": Icons.book_outlined,
        "color": Colors.blue.shade600,
        "badge": "6",
        "gradient": LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blue.shade50, Colors.blue.shade100],
        ),
      },
      {
        "title": "Homework",
        "icon": Icons.assignment_outlined,
        "color": Colors.green.shade600,
        "badge": "4 Pending",
        "gradient": LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.green.shade50, Colors.green.shade100],
        ),
      },
      {
        "title": "Attendance",
        "icon": Icons.calendar_today_outlined,
        "color": Colors.orange.shade600,
        "badge": null,
        "gradient": LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.orange.shade50, Colors.orange.shade100],
        ),
      },
      {
        "title": "Syllabus",
        "icon": Icons.library_books_outlined,
        "color": Colors.purple.shade600,
        "badge": null,
        "gradient": LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.purple.shade50, Colors.purple.shade100],
        ),
      },
      {
        "title": "Contact Us",
        "icon": Icons.phone_outlined,
        "color": Colors.teal.shade600,
        "badge": null,
        "gradient": LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.teal.shade50, Colors.teal.shade100],
        ),
      },
    ];

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(), // Disable grid's own scroll
      shrinkWrap: true, // Important: makes grid take only needed height
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.1,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return _buildModernCard(item, context);
      },
    );
  }

  Widget _buildModernCard(Map<String, dynamic> item, BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Tapped: ${item["title"]}");
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: item["gradient"],
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Background pattern
            Positioned(
              top: -10,
              right: -10,
              child: Opacity(
                opacity: 0.05,
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: item["color"],
                  ),
                ),
              ),
            ),
            
            // Card content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Icon and badge row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Icon(
                          item["icon"],
                          color: item["color"],
                          size: 26,
                        ),
                      ),
                      
                      // Badge
                      if (item["badge"] != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.95),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            item["badge"],
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: item["color"],
                            ),
                          ),
                        ),
                    ],
                  ),
                  
                  // Title
                  Text(
                    item["title"],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey.shade800,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}