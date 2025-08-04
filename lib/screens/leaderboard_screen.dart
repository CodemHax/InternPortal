import 'package:flutter/material.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => LeaderboardScreenState();
}

class LeaderboardScreenState extends State<LeaderboardScreen> {
  final List<Map<String, dynamic>> leaderboardData = [
    {
      'name': 'Priya Patel',
      'amount': 18500,
      'referrals': 23,
      'rank': 1,
      'avatar': 'PP',
      'color': Colors.amber,
    },
    {
      'name': 'Altaf B',
      'amount': 12500,
      'referrals': 15,
      'rank': 2,
      'avatar': 'AB',
      'color': Colors.blue,
      'isCurrentUser': true,
    },
    {
      'name': 'Ananya Singh',
      'amount': 11200,
      'referrals': 18,
      'rank': 3,
      'avatar': 'AS',
      'color': Colors.orange,
    },
    {
      'name': 'Vikram Kumar',
      'amount': 9800,
      'referrals': 12,
      'rank': 4,
      'avatar': 'VK',
      'color': Colors.green,
    },
    {
      'name': 'Sneha Reddy',
      'amount': 8600,
      'referrals': 14,
      'rank': 5,
      'avatar': 'SR',
      'color': Colors.purple,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          buildPodiumHeader(),
          Expanded(
            child: buildLeaderboardList(),
          ),
        ],
      ),
    );
  }

  Widget buildPodiumHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Colors.blue.shade700,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Text(
            'Top Fundraisers',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (leaderboardData.length > 1)
                buildPodiumPosition(leaderboardData[1], 2),
              if (leaderboardData.isNotEmpty)
                buildPodiumPosition(leaderboardData[0], 1),
              if (leaderboardData.length > 2)
                buildPodiumPosition(leaderboardData[2], 3),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildPodiumPosition(Map<String, dynamic> user, int position) {
    final heights = {1: 120.0, 2: 90.0, 3: 70.0};
    final colors = {
      1: Colors.amber,
      2: Colors.grey[400],
      3: const Color(0xFFCD7F32)
    };
    final icon = {
      1: Icons.emoji_events,
      2: Icons.military_tech,
      3: Icons.workspace_premium
    };

    return Column(
      children: [
        if (position == 1)
          Icon(Icons.star, color: Colors.yellowAccent[700], size: 30),
        const SizedBox(height: 4),
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white,
          child: Text(
            user['avatar'],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: user['color'],
              fontSize: 20,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          user['name'].split(' ')[0],
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '₹${user['amount']}',
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: heights[position],
          width: 80,
          decoration: BoxDecoration(
            color: colors[position],
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(12),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              )
            ],
          ),
          child: Icon(
            icon[position],
            color: Colors.white,
            size: 40,
          ),
        ),
      ],
    );
  }

  Widget buildLeaderboardList() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: leaderboardData.length,
        itemBuilder: (context, index) {
          return buildLeaderboardItem(leaderboardData[index], index);
        },
      ),
    );
  }

  Widget buildLeaderboardItem(Map<String, dynamic> user, int index) {
    final bool isCurrentUser = user['isCurrentUser'] ?? false;

    return Card(
      elevation: isCurrentUser ? 8 : 3,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: isCurrentUser
            ? BorderSide(color: Theme.of(context).primaryColor, width: 2)
            : BorderSide(color: Colors.grey[200]!),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: isCurrentUser
              ? LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor.withOpacity(0.05),
                    Colors.white,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: getRankColor(user['rank']).withOpacity(0.1),
                shape: BoxShape.circle,
                border: Border.all(color: getRankColor(user['rank'])),
              ),
              child: Center(
                child: Text(
                  '#${user['rank']}',
                  style: TextStyle(
                    color: getRankColor(user['rank']),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          user['name'],
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                        ),
                      ),
                      if (isCurrentUser) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'You',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.people_outline,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${user['referrals']} referrals',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '₹${user['amount'].toStringAsFixed(0)}',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: getRankColor(user['rank']),
                      ),
                ),
                Text(
                  'raised',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color getRankColor(int rank) {
    switch (rank) {
      case 1:
        return Colors.amber[700]!;
      case 2:
        return Colors.grey[600]!;
      case 3:
        return Colors.brown[600]!;
      default:
        return Colors.blue[800]!;
    }
  }
}
