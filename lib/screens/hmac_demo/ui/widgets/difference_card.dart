import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';

/// Educational card explaining the difference between normal and HMAC requests.
class DifferenceCard extends StatelessWidget {
  const DifferenceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1A1A2E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.spacing12),
        side: BorderSide(color: Colors.white.withOpacity(0.1)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.info_outline, color: Color(0xFFE94560), size: 22),
                gapW8,
                const Expanded(
                  child: Text(
                    'Difference Between Normal Request and HMAC Request',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            gapH16,
            _buildComparisonRow(
              'Authentication',
              'Bearer token or none',
              'HMAC signature proves request origin',
            ),
            gapH12,
            _buildComparisonRow(
              'Integrity',
              'No guarantee body wasn\'t modified',
              'Body hash in signature detects tampering',
            ),
            gapH12,
            _buildComparisonRow(
              'Replay Protection',
              'None',
              'Timestamp + nonce prevent replay attacks',
            ),
            gapH12,
            _buildComparisonRow(
              'Headers',
              'Standard (Content-Type, Accept)',
              '+ Authorization, X-Timestamp, X-Nonce, X-Signature',
            ),
            gapH12,
            _buildComparisonRow(
              'HTTPS Required?',
              'Yes — always',
              'Yes — HMAC does NOT replace TLS encryption',
            ),
            gapH16,
            Container(
              padding: const EdgeInsets.all(AppSpacing.spacing12),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppSpacing.spacing8),
                border: Border.all(color: Colors.orange.withOpacity(0.3)),
              ),
              child: const Text(
                'HMAC alone cannot secure a mobile app. The shared secret '
                'can be extracted via reverse engineering. Use it as one '
                'layer alongside HTTPS, certificate pinning, server-issued '
                'tokens, and device attestation.',
                style: TextStyle(color: Colors.orangeAccent, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComparisonRow(String aspect, String normal, String hmac) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          aspect,
          style: const TextStyle(
            color: Color(0xFFE94560),
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        gapH4,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Normal',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.4),
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    normal,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            gapW12,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'HMAC',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.4),
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    hmac,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
