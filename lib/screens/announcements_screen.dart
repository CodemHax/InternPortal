import 'package:flutter/material.dart';

class AnnouncementsScreen extends StatefulWidget {
  const AnnouncementsScreen({super.key});

  @override
  State<AnnouncementsScreen> createState() => AnnouncementsScreenState();
}

class AnnouncementsScreenState extends State<AnnouncementsScreen> {
  final List<Map<String, dynamic>> announcements = [
    {
      'id': 1,
      'title': '🎉 New Reward Tier Unlocked!',
      'message': 'Congratulations! The "Super Fundraiser" reward is now available. Raise ₹25,000 to unlock exclusive benefits and recognition.',
      'date': DateTime.now().subtract(const Duration(hours: 2)),
      'type': 'reward',
      'priority': 'high',
      'icon': Icons.emoji_events,
      'color': Colors.amber,
    },
    {
      'id': 2,
      'title': '📊 Weekly Leaderboard Update',
      'message': 'Great job this week! You\'re currently ranked #2 on the leaderboard. Keep up the excellent work to reach the top position!',
      'date': DateTime.now().subtract(const Duration(days: 1)),
      'type': 'leaderboard',
      'priority': 'medium',
      'icon': Icons.leaderboard,
      'color': Colors.blue,
    },
    {
      'id': 3,
      'title': '🎯 Monthly Challenge',
      'message': 'Join our October fundraising challenge! Top 3 fundraisers will receive special recognition and bonus rewards. Challenge ends in 15 days.',
      'date': DateTime.now().subtract(const Duration(days: 3)),
      'type': 'challenge',
      'priority': 'high',
      'icon': Icons.flag,
      'color': Colors.green,
    },
    {
      'id': 4,
      'title': '💡 Fundraising Tip',
      'message': 'Share your personal story! Donors are more likely to contribute when they understand your motivation and connection to the cause.',
      'date': DateTime.now().subtract(const Duration(days: 5)),
      'type': 'tip',
      'priority': 'low',
      'icon': Icons.lightbulb,
      'color': Colors.orange,
    },
    {
      'id': 5,
      'title': '🔄 Platform Update',
      'message': 'We\'ve improved the referral tracking system. Your referral code analytics are now more detailed and update in real-time.',
      'date': DateTime.now().subtract(const Duration(days: 7)),
      'type': 'update',
      'priority': 'medium',
      'icon': Icons.system_update,
      'color': Colors.purple,
    },
    {
      'id': 6,
      'title': '🎊 Milestone Celebration',
      'message': 'Amazing news! Our intern community has collectively raised over ₹1,00,000 this month. Thank you for your incredible contribution!',
      'date': DateTime.now().subtract(const Duration(days: 10)),
      'type': 'milestone',
      'priority': 'high',
      'icon': Icons.celebration,
      'color': Colors.pink,
    },
  ];

  String formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return '${difference.inMinutes}m ago';
      }
      return '${difference.inHours}h ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else {
      return '${difference.inDays}d ago';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Announcements'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.mark_email_read),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('All announcements marked as read'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            tooltip: 'Mark all as read',
          ),
        ],
      ),
      body: Column(
        children: [
          buildSummaryHeader(),
          Expanded(
            child: buildAnnouncementsList(),
          ),
        ],
      ),
    );
  }

  Widget buildSummaryHeader() {
    final highPriorityCount = announcements
        .where((announcement) => announcement['priority'] == 'high')
        .length;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Theme.of(context).primaryColor, Colors.purple.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Stay Updated',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${announcements.length} announcements',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          if (highPriorityCount > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '$highPriorityCount urgent',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildAnnouncementsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: announcements.length,
      itemBuilder: (context, index) {
        return buildAnnouncementCard(announcements[index]);
      },
    );
  }

  Widget buildAnnouncementCard(Map<String, dynamic> announcement) {
    final priority = announcement['priority'] as String;
    final isUrgent = priority == 'high';

    return Card(
      elevation: isUrgent ? 6 : 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: isUrgent
            ? const BorderSide(color: Colors.red, width: 1)
            : BorderSide.none,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          showAnnouncementDetail(announcement);
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: announcement['color'].withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      announcement['icon'],
                      color: announcement['color'],
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          announcement['title'],
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Text(
                              formatDate(announcement['date']),
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.grey[600],
                              ),
                            ),
                            if (isUrgent) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  'URGENT',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: Colors.grey[400],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                announcement['message'],
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[700],
                  height: 1.4,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showAnnouncementDetail(Map<String, dynamic> announcement) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        builder: (_, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: announcement['color'].withOpacity(0.1),
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: announcement['color'].withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            announcement['icon'],
                            color: announcement['color'],
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                announcement['title'],
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Text(
                                formatDate(announcement['date']),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: Colors.grey[600],
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    announcement['message'],
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          height: 1.6,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
