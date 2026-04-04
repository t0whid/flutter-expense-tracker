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
        title: const Text('About Developer'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          _buildProfileCard(context),
          const SizedBox(height: 16),
          _buildSectionCard(
            title: 'About',
            child: const Text(
              'Backend-focused Software Engineer with expertise in Go, Flutter, Android, Laravel, microservices, and cloud storage solutions. Experienced in designing scalable, high-performance systems for media processing, authentication, and multi-user services. Strong command over PostgreSQL, MySQL, Gin framework, JWT, OTP flows, backend architecture, and mobile application development. Passionate about building efficient APIs and solving complex concurrency and data-processing problems.',
              style: TextStyle(
                fontSize: 14,
                height: 1.6,
                color: Color(0xFF374151),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildSectionCard(
            title: 'App Info',
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _AppInfoRow(
                  label: 'Version',
                  value: '1.0.0',
                ),
                SizedBox(height: 10),
                _AppInfoRow(
                  label: 'Built With',
                  value: 'Flutter',
                ),
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
            'Software Engineer',
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

class _AppInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _AppInfoRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF111827),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
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