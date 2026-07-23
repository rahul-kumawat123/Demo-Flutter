import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../domain/api_call_result.dart';
import '../../../../security/hmac_verifier.dart';

/// Displays the result of a single API call (plain or HMAC).
class RequestResultCard extends StatelessWidget {
  const RequestResultCard({
    super.key,
    required this.result,
    this.showHmacDetails = false,
  });

  final ApiCallResult result;
  final bool showHmacDetails;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF0F3460),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.spacing12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatusRow(),
            gapH12,
            _buildRow('URL', result.url),
            gapH8,
            _buildRow('Method', result.method),
            gapH8,
            _buildHeadersSection(),
            if (result.requestBody != null) ...[
              gapH8,
              _buildRow('Request Body', result.requestBody!),
            ],
            gapH8,
            _buildRow('Status', '${result.statusCode ?? 'N/A'}'),
            gapH8,
            _buildRow('Time Taken', '${result.elapsedMs} ms'),
            gapH8,
            _buildRow('Response', _truncate(result.responseBody, 500)),
            if (showHmacDetails) ...[
              gapH12,
              const Divider(color: Colors.white24),
              gapH8,
              if (result.timestamp != null)
                _buildRow('Timestamp', result.timestamp!),
              if (result.nonce != null) ...[
                gapH8,
                _buildRow('Nonce', result.nonce!),
              ],
              if (result.canonicalString != null) ...[
                gapH8,
                _buildRow('Signing String', result.canonicalString!),
              ],
              if (result.signature != null) ...[
                gapH8,
                _buildRow('HMAC Signature', result.signature!),
              ],
              if (result.verificationResult != null) ...[
                gapH12,
                _buildVerificationBadge(result.verificationResult!),
              ],
            ],
            if (result.errorMessage != null) ...[
              gapH8,
              Text(
                'Error: ${result.errorMessage}',
                style: const TextStyle(color: Colors.redAccent, fontSize: 13),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusRow() {
    final success = result.isSuccess;
    return Row(
      children: [
        Icon(
          success ? Icons.check_circle : Icons.error,
          color: success ? Colors.greenAccent : Colors.redAccent,
          size: 20,
        ),
        gapW8,
        Text(
          success ? 'Success' : 'Failed',
          style: TextStyle(
            color: success ? Colors.greenAccent : Colors.redAccent,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const Spacer(),
        if (result.isHmacSigned)
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.spacing8,
              vertical: AppSpacing.spacing4,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFE94560).withOpacity(0.2),
              borderRadius: BorderRadius.circular(AppSpacing.spacing8),
            ),
            child: const Text(
              'HMAC',
              style: TextStyle(
                color: Color(0xFFE94560),
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildHeadersSection() {
    final headers = result.requestHeaders.entries
        .where((e) => !e.key.startsWith('content-length'))
        .map((e) => '${e.key}: ${e.value}')
        .join('\n');

    return _buildRow('Headers', headers.isEmpty ? '(none)' : headers);
  }

  Widget _buildVerificationBadge(VerificationResult verification) {
    final isValid = verification.isValid;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.spacing12),
      decoration: BoxDecoration(
        color: isValid
            ? Colors.green.withOpacity(0.15)
            : Colors.red.withOpacity(0.15),
        borderRadius: BorderRadius.circular(AppSpacing.spacing8),
        border: Border.all(
          color: isValid ? Colors.greenAccent : Colors.redAccent,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                isValid ? '✔ Signature Valid' : '✘ Signature Invalid',
                style: TextStyle(
                  color: isValid ? Colors.greenAccent : Colors.redAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          gapH4,
          Text(
            verification.message,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.5),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        gapH4,
        SelectableText(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontFamily: 'monospace',
          ),
        ),
      ],
    );
  }

  String _truncate(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }
}
