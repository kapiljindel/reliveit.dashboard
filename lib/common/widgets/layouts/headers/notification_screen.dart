import 'package:dashboard/features/stream/screens/banner/all_banners/banners.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Report {
  final String reason;
  final String seriesId;
  final String status;
  final dynamic timestamp;

  Report({
    required this.reason,
    required this.seriesId,
    required this.status,
    required this.timestamp,
  });

  factory Report.fromMap(Map<String, dynamic> data) {
    return Report(
      reason: data['reason'] ?? '',
      seriesId: data['seriesId'] ?? '',
      status: data['status'] ?? '',
      timestamp: data['timestamp'],
    );
  }
}

class ReportDropdown extends StatefulWidget {
  const ReportDropdown({super.key});

  @override
  State<ReportDropdown> createState() => _ReportDropdownState();
}

class _ReportDropdownState extends State<ReportDropdown> {
  List<Report> recentReports = [];

  @override
  void initState() {
    super.initState();
    fetchReports();
  }

  Future<void> fetchReports() async {
    final prefs = await SharedPreferences.getInstance();
    final uid = prefs.getString('user_uid');
    if (uid == null) return;

    final snapshot =
        await FirebaseFirestore.instance
            .collection('reports')
            .where('uid', isEqualTo: uid)
            .orderBy('timestamp', descending: true)
            .limit(10)
            .get();

    final fetchedReports =
        snapshot.docs.map((doc) => Report.fromMap(doc.data())).toList();

    setState(() {
      recentReports = fetchedReports;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          // Close on tap outside
          Positioned.fill(
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(color: Colors.transparent),
            ),
          ),

          // Report dropdown panel
          Positioned(
            top: 70,
            right: 20,
            child: Container(
              width: 400,
              height: 550,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Recent Reports',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  const Divider(),

                  // Report list
                  Expanded(
                    child:
                        recentReports.isEmpty
                            ? const Center(child: Text("No reports found."))
                            : ListView.builder(
                              itemCount: recentReports.length,
                              itemBuilder: (context, index) {
                                final report = recentReports[index];
                                final isCompleted =
                                    report.status.toLowerCase() == 'completed';

                                return ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 4,
                                  ),
                                  leading: const Icon(
                                    Icons.report_problem,
                                    color: Colors.redAccent,
                                  ),
                                  title: Text(report.reason),
                                  subtitle: Text(
                                    'Series ID: ${report.seriesId}',
                                  ),
                                  trailing: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          isCompleted
                                              ? Colors.green[100]
                                              : Colors.red[100],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      report.status,
                                      style: TextStyle(
                                        color:
                                            isCompleted
                                                ? Colors.green[800]
                                                : Colors.red[800],
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                  ),

                  const Divider(),

                  // View All button
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const BannersScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'View All Reports',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
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
