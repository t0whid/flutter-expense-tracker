import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/app_snackbar.dart';

class CreditsScreen extends StatelessWidget {
  const CreditsScreen({super.key});

  static final Uri _linkedinUrl = Uri.parse('https://www.linkedin.com/in/t0wh1d/');
  static final Uri _facebookUrl = Uri.parse('https://www.facebook.com/t0wh1d');
  static final Uri _emailUri = Uri(
    scheme: 'mailto',
    path: 'towhid.hasan.zahor@gmail.com',
  );
  static final Uri _phoneUri = Uri(
    scheme: 'tel',
    path: '+8801521256487',
  );

  Future<void> _openLink(BuildContext context, Uri uri, String label) async {
    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched && context.mounted) {
        AppSnackbar.showError(context, 'Could not open $label');
      }
    } catch (_) {
      if (context.mounted) {
        AppSnackbar.showError(context, 'Could not open $label');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Credits'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          _buildProfileCard(context),
          const SizedBox(height: 16),
          _buildSectionCard(
            title: 'Summary',
            child: const Text(
              'Backend-focused Software Engineer with expertise in Go, microservices, and cloud storage solutions. Experienced in designing scalable, high-performance systems for media processing, authentication, and multi-user services. Strong command over PostgreSQL, MinIO/S3, Gin framework, JWT, OTP flows, and backend architecture. Passionate about building efficient APIs and solving complex concurrency and data-processing problems.',
              style: TextStyle(
                fontSize: 14,
                height: 1.6,
                color: Color(0xFF374151),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildSectionCard(
            title: 'Experience',
            child: Column(
              children: const [
                _ExperienceTile(
                  title: 'Programmer – Fiber@Home Global Ltd.',
                  location: 'Dhaka, Bangladesh',
                  duration: 'Jan 2024 – Present',
                  points: [
                    'Architected and implemented Go-based backend services for a Media & Cloud Storage Service, including image/video uploads, multi-size thumbnail generation, and optimized processing pipelines.',
                    'Built secure authentication & authorization flows using OTP, JWT, and token refresh mechanisms, supporting mobile login and session management.',
                    'Designed and developed album management and media-sharing features for multi-user access, leveraging Go concurrency patterns for performance and scalability.',
                    'Integrated MinIO/S3-compatible storage, enabling efficient media retrieval, backups, and cloud-ready infrastructure.',
                    'Enhanced operational and network management software, improving efficiency and functionality for a system generating \$120M in annual revenue and serving 2,000+ active users.',
                    'Developed new features, optimized database queries, and maintained critical reports for improved performance.',
                  ],
                ),
                SizedBox(height: 14),
                _ExperienceTile(
                  title: 'Backend Developer – Pakapepe.com',
                  location: 'Dhaka, Bangladesh',
                  duration: 'Dec 2022 – Dec 2023',
                  points: [
                    'Developed HRIS (Office Management Software) in Laravel with attendance tracking, leave management, payroll processing, employee performance reports, and project oversight.',
                  ],
                ),
                SizedBox(height: 14),
                _ExperienceTile(
                  title: 'Junior Software Engineer – Xerone IT',
                  location: 'Rajshahi, Bangladesh',
                  duration: 'Jan 2022 – Nov 2022',
                  points: [
                    'Built a WhatsApp Chatbot System using WhatsApp Cloud API and Facebook Graph API (BotSailor).',
                    'Developed live session recording for HeatSketch and integrated multiple payment gateways.',
                    'Implemented master-slave database replication and provided support for existing client projects.',
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildSectionCard(
            title: 'Technical Skills',
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SkillLine(
                  label: 'Languages',
                  value: 'Go, PHP, JavaScript, Python, C++, Java, Dart',
                ),
                SizedBox(height: 10),
                _SkillLine(
                  label: 'Backend & Frameworks',
                  value: 'Go (Gin), Laravel, Spring Boot',
                ),
                SizedBox(height: 10),
                _SkillLine(
                  label: 'Databases',
                  value: 'PostgreSQL, MySQL',
                ),
                SizedBox(height: 10),
                _SkillLine(
                  label: 'Storage & Cloud',
                  value: 'MinIO/S3, Redis',
                ),
                SizedBox(height: 10),
                _SkillLine(
                  label: 'Tools & DevOps',
                  value: 'Git, Docker, Linux',
                ),
                SizedBox(height: 10),
                _SkillLine(
                  label: 'Concepts',
                  value:
                  'Microservices, OOP, MVC, Concurrency, RESTful API design, Data Structures & Algorithms',
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildSectionCard(
            title: 'Education',
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bachelor of Science in Computer Science & Engineering',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF111827),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Islamic University, Kushtia, Khulna',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF4B5563),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '2016 – 2022 — CGPA: 3.11/4.0',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF6B7280),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildSectionCard(
            title: 'Certifications',
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _BulletText('PHP for Beginners – Great Learning Academy'),
                SizedBox(height: 8),
                _BulletText('JavaScript Algorithms & Data Structures – freeCodeCamp'),
                SizedBox(height: 8),
                _BulletText('JavaScript (Intermediate) Certificate – HackerRank'),
                SizedBox(height: 8),
                _BulletText('Software Engineer Certificate – HackerRank'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF4F46E5),
            Color(0xFF7C3AED),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 84,
            height: 84,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white24, width: 3),
              image: const DecorationImage(
                image: AssetImage('assets/images/my_image.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Towhid Hasan Zahor',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Backend-focused Software Engineer',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white70,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          _InfoRow(
            icon: Icons.location_on_outlined,
            text: 'Badda, Dhaka',
            textColor: Colors.white,
            onTap: null,
          ),
          const SizedBox(height: 8),
          _InfoRow(
            icon: Icons.email_outlined,
            text: 'towhid.hasan.zahor@gmail.com',
            textColor: Colors.white,
            onTap: () => _openLink(context, _emailUri, 'email'),
          ),
          const SizedBox(height: 8),
          _InfoRow(
            icon: Icons.phone_outlined,
            text: '+8801521256487',
            textColor: Colors.white,
            onTap: () => _openLink(context, _phoneUri, 'phone'),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _SocialChip(
                label: 'LinkedIn',
                onTap: () => _openLink(context, _linkedinUrl, 'LinkedIn'),
              ),
              _SocialChip(
                label: 'Facebook',
                onTap: () => _openLink(context, _facebookUrl, 'Facebook'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

class _ExperienceTile extends StatelessWidget {
  final String title;
  final String location;
  final String duration;
  final List<String> points;

  const _ExperienceTile({
    required this.title,
    required this.location,
    required this.duration,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$location • $duration',
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF6B7280),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          ...points.map(
                (point) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _BulletText(point),
            ),
          ),
        ],
      ),
    );
  }
}

class _SkillLine extends StatelessWidget {
  final String label;
  final String value;

  const _SkillLine({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 14,
          height: 1.5,
          color: Color(0xFF374151),
        ),
        children: [
          TextSpan(
            text: '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              color: Color(0xFF111827),
            ),
          ),
          TextSpan(text: value),
        ],
      ),
    );
  }
}

class _BulletText extends StatelessWidget {
  final String text;

  const _BulletText(this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 6),
          child: Icon(
            Icons.circle,
            size: 6,
            color: Color(0xFF6B7280),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Color(0xFF374151),
            ),
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color textColor;
  final VoidCallback? onTap;

  const _InfoRow({
    required this.icon,
    required this.text,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Row(
            children: [
              Icon(icon, size: 18, color: Colors.white70),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 13,
                    color: textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (onTap != null)
                const Icon(
                  Icons.open_in_new_rounded,
                  size: 16,
                  color: Colors.white70,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _SocialChip({
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.14),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.white.withOpacity(0.18),
            ),
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}