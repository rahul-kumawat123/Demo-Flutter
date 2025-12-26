import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/auth/auth_cubit.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../l10n/app_localizations.dart';

/// Account Tab - Profile and Logout
class AccountTab extends StatelessWidget {
  const AccountTab({super.key});

  void _handleLogout(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A2E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.spacing16),
        ),
        title: Text(l10n.logout, style: const TextStyle(color: Colors.white)),
        content: Text(
          l10n.logoutConfirmation,
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              l10n.cancel,
              style: TextStyle(color: Colors.white.withOpacity(0.6)),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<AuthCubit>().logout();
            },
            child: Text(
              l10n.logout,
              style: const TextStyle(color: Color(0xFFE94560)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.spacing16),
            child: Text(
              l10n.account,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.spacing16),
              child: Column(
                children: [
                  // Profile placeholder
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.spacing20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppSpacing.spacing16),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: AppSpacing.spacing60,
                          height: AppSpacing.spacing60,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [Color(0xFFE94560), Color(0xFFFF6B6B)],
                            ),
                          ),
                          child: const Icon(
                            Icons.person,
                            size: AppSpacing.spacing30,
                            color: Colors.white,
                          ),
                        ),
                        gapW16,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.profile,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              gapH4,
                              Text(
                                l10n.viewAndEditProfile,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: Colors.white.withOpacity(0.6),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  // Logout button
                  SizedBox(
                    width: double.infinity,
                    height: AppSpacing.spacing52,
                    child: OutlinedButton.icon(
                      onPressed: () => _handleLogout(context),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFFE94560),
                        side: const BorderSide(color: Color(0xFFE94560)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSpacing.spacing12),
                        ),
                      ),
                      icon: const Icon(Icons.logout),
                      label: Text(
                        l10n.logout,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  gapH32,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

