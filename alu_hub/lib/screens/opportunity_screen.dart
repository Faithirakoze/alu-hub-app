import 'package:flutter/material.dart';
import '../models/mock_data.dart';

class OpportunityScreen extends StatefulWidget {
  final Opportunity opportunity;
  const OpportunityScreen({super.key, required this.opportunity});

  @override
  State<OpportunityScreen> createState() => _OpportunityScreenState();
}

class _OpportunityScreenState extends State<OpportunityScreen> {
  late bool _hasRSVPd;
  late int _registeredCount;

  @override
  void initState() {
    super.initState();
    _hasRSVPd = widget.opportunity.hasRSVPd;
    _registeredCount = widget.opportunity.registeredCount;
  }

  void _toggleRSVP() {
    setState(() {
      if (_hasRSVPd) {
        _hasRSVPd = false;
        _registeredCount--;
      } else {
        _hasRSVPd = true;
        _registeredCount++;
      }
      widget.opportunity.hasRSVPd = _hasRSVPd;
    });
  }

  double get _fillRatio =>
      (_registeredCount / widget.opportunity.totalSlots).clamp(0.0, 1.0);

  Color get _categoryColor {
    switch (widget.opportunity.category.toUpperCase()) {
      case 'CAREER':   return const Color(0xFF4A90D9);
      case 'FINANCE':  return const Color(0xFFF5A623);
      case 'SOCIAL':   return const Color(0xFF7ED321);
      case 'WELLNESS': return const Color(0xFF9B59B6);
      default:         return const Color(0xFF4A90D9);
    }
  }

  @override
  Widget build(BuildContext context) {
    final op = widget.opportunity;

    return Scaffold(
      backgroundColor: const Color(0xFF0F1C30),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 220,
                pinned: true,
                backgroundColor: const Color(0xFF1B2B4B),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.share_outlined, color: Colors.white),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(
                      op.isBookmarked ? Icons.favorite : Icons.favorite_border,
                      color: op.isBookmarked ? Colors.red : Colors.white,
                    ),
                    onPressed: () => setState(() => op.isBookmarked = !op.isBookmarked),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              _categoryColor.withOpacity(0.6),
                              const Color(0xFF1B2B4B),
                            ],
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.event,
                            size: 64,
                            color: Colors.white.withOpacity(0.3),
                          ),
                        ),
                      ),
                      // Bottom fade
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 80,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                const Color(0xFF0F1C30),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Main content
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tags row
                      Wrap(
                        spacing: 8,
                        children: [
                          _TagChip(label: op.category, color: _categoryColor),
                          if (op.tier.isNotEmpty)
                            _TagChip(label: op.tier, color: const Color(0xFFF5A623)),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Title
                      Text(
                        op.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Date
                      _InfoRow(
                        icon: Icons.calendar_today_outlined,
                        text: op.date,
                      ),
                      const SizedBox(height: 8),

                      // Location
                      _InfoRow(
                        icon: Icons.location_on_outlined,
                        text: op.location,
                      ),
                      const SizedBox(height: 16),

                      // Divider
                      Divider(color: Colors.white.withOpacity(0.1)),
                      const SizedBox(height: 12),

                      // Organizer row
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: _categoryColor.withOpacity(0.3),
                            child: Icon(Icons.groups, color: _categoryColor, size: 20),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  op.organizer,
                                  style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
                                ),
                                const Text('Organizer', style: TextStyle(color: Colors.white38, fontSize: 11)),
                              ],
                            ),
                          ),
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              side: BorderSide(color: Colors.white.withOpacity(0.3)),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text('Follow', style: TextStyle(fontSize: 12)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Hashtags
                      Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        children: op.tags.map((tag) => Text(
                          tag,
                          style: TextStyle(color: _categoryColor, fontSize: 13),
                        )).toList(),
                      ),
                      const SizedBox(height: 20),

                      // About section
                      const Text(
                        'About this opportunity',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        op.description,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Registered count + progress
                      Row(
                        children: [
                          Text(
                            '$_registeredCount registered',
                            style: const TextStyle(color: Colors.white70, fontSize: 13),
                          ),
                          const Spacer(),
                          Text(
                            'Out of ${op.totalSlots} spots',
                            style: const TextStyle(color: Colors.white38, fontSize: 12),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: _fillRatio,
                          backgroundColor: Colors.white12,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            _fillRatio > 0.8 ? Colors.redAccent : const Color(0xFFF5A623),
                          ),
                          minHeight: 6,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${((_fillRatio) * 100).toStringAsFixed(0)}% full',
                        style: const TextStyle(color: Colors.white38, fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // RSVP button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              decoration: BoxDecoration(
                color: const Color(0xFF0F1C30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _toggleRSVP,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _hasRSVPd
                        ? Colors.white12
                        : const Color(0xFFF5A623),
                    foregroundColor: _hasRSVPd ? Colors.white : Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _hasRSVPd ? Icons.check_circle : Icons.add,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _hasRSVPd ? 'You\'re registered!' : '+ RSVP Now',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class _TagChip extends StatelessWidget {
  final String label;
  final Color color;
  const _TagChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Text(label, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600)),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.white38, size: 16),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text, style: const TextStyle(color: Colors.white70, fontSize: 13)),
        ),
      ],
    );
  }
}
