import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  final String internName = "Altaf B";
  final String referralCode = "altaf2025";
  final double totalDonations = 12500.0;
  final int totalReferrals = 15;

  final List<Map<String, dynamic>> rewards = [
    {
      'title': 'Rising Star',
      'description': 'First ₹1,000 raised',
      'amount': 1000,
      'unlocked': true,
      'icon': Icons.star,
      'color': Colors.orange,
    },
    {
      'title': 'Champion',
      'description': 'Raised ₹10,000',
      'amount': 10000,
      'unlocked': true,
      'icon': Icons.emoji_events,
      'color': Colors.amber,
    },
    {
      'title': 'Super Fundraiser',
      'description': 'Raise ₹25,000',
      'amount': 25000,
      'unlocked': false,
      'icon': Icons.workspace_premium,
      'color': Colors.purple,
    },
    {
      'title': 'Legend',
      'description': 'Raise ₹50,000',
      'amount': 50000,
      'unlocked': false,
      'icon': Icons.military_tech,
      'color': Colors.red,
    },
  ];

  void copyReferralCode() {
    Clipboard.setData(ClipboardData(text: referralCode));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Referral code copied to clipboard!'),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void shareReferralCode() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sharing your referral code: $referralCode'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: () {},
            tooltip: 'Profile',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildWelcomeCard(),
            const SizedBox(height: 24),
            buildStatsCards(),
            const SizedBox(height: 24),
            buildReferralCard(),
            const SizedBox(height: 24),
            buildRewardsSection(),
          ],
        ),
      ),
    );
  }

  Widget buildWelcomeCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Colors.blue.shade400, Colors.blue.shade600],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                size: 30,
                color: Colors.blue,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back,',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                  Text(
                    internName,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Let\'s make a difference today!',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withOpacity(0.9),
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

  Widget buildStatsCards() {
    return Row(
      children: [
        Expanded(
          child: buildStatCard(
            title: 'Total Raised',
            value: '₹${totalDonations.toStringAsFixed(0)}',
            icon: Icons.monetization_on,
            color: Colors.green,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: buildStatCard(
            title: 'Your Referrals',
            value: totalReferrals.toString(),
            icon: Icons.group_add,
            color: Colors.orange,
          ),
        ),
      ],
    );
  }

  Widget buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 36, color: color),
            const SizedBox(height: 12),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildReferralCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.share, color: Theme.of(context).primaryColor),
                const SizedBox(width: 8),
                Text(
                  'Your Referral Code',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    referralCode,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                          color: Colors.grey[800],
                        ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: copyReferralCode,
                        icon: const Icon(Icons.copy_outlined),
                        tooltip: 'Copy code',
                        color: Theme.of(context).primaryColor,
                      ),
                      IconButton(
                        onPressed: shareReferralCode,
                        icon: const Icon(Icons.share_outlined),
                        tooltip: 'Share code',
                        color: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Share this code with your network to boost your impact!',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[700],
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRewardsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rewards & Achievements',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...rewards.map((reward) => buildRewardCard(reward)).toList(),
      ],
    );
  }

  Widget buildRewardCard(Map<String, dynamic> reward) {
    final bool unlocked = reward['unlocked'];
    final double progress = totalDonations / reward['amount'];
    
    return Card(
      elevation: unlocked ? 4 : 1,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: unlocked
              ? LinearGradient(
                  colors: [
                    reward['color'].withOpacity(0.1),
                    Colors.white,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          border: unlocked
              ? Border.all(color: reward['color'].withOpacity(0.5), width: 1)
              : Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: unlocked
                    ? reward['color'].withOpacity(0.2)
                    : Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                reward['icon'],
                color: unlocked ? reward['color'] : Colors.grey[600],
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        reward['title'],
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: unlocked ? Colors.grey[800] : Colors.grey[600],
                            ),
                      ),
                      if (unlocked) ...[
                        const SizedBox(width: 8),
                        Icon(
                          Icons.check_circle,
                          color: reward['color'],
                          size: 20,
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    reward['description'],
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  if (!unlocked) ...[
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: progress.clamp(0.0, 1.0),
                      backgroundColor: Colors.grey[300],
                      valueColor:
                          AlwaysStoppedAnimation<Color>(reward['color']),
                      minHeight: 6,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '₹${totalDonations.toStringAsFixed(0)} / ₹${reward['amount']}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
