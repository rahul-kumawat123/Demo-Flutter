import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_spacing.dart';
import '../cubit/hmac_demo_cubit.dart';
import '../cubit/hmac_demo_state.dart';
import 'widgets/difference_card.dart';
import 'widgets/request_result_card.dart';

class HmacDemoScreen extends StatelessWidget {
  const HmacDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HmacDemoCubit(),
      child: const _HmacDemoView(),
    );
  }
}

class _HmacDemoView extends StatelessWidget {
  const _HmacDemoView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
          ),
        ),
        child: SafeArea(
          child: BlocBuilder<HmacDemoCubit, HmacDemoState>(
            builder: (context, state) {
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    backgroundColor: const Color(0xFF1A1A2E),
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    title: const Text(
                      'HMAC API Security POC',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(AppSpacing.spacing16),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        const DifferenceCard(),
                        gapH24,
                        _buildSectionHeader('Without HMAC'),
                        gapH12,
                        _buildButton(
                          context,
                          label: 'GET Users',
                          icon: Icons.download,
                          isLoading: state.isLoading,
                          onPressed: () =>
                              context.read<HmacDemoCubit>().getUsersPlain(),
                        ),
                        if (state.lastPlainGetResult != null) ...[
                          gapH12,
                          RequestResultCard(
                            result: state.lastPlainGetResult!,
                          ),
                        ],
                        gapH12,
                        _buildButton(
                          context,
                          label: 'POST Data',
                          icon: Icons.upload,
                          isLoading: state.isLoading,
                          onPressed: () =>
                              context.read<HmacDemoCubit>().postDataPlain(),
                        ),
                        if (state.lastPlainPostResult != null) ...[
                          gapH12,
                          RequestResultCard(
                            result: state.lastPlainPostResult!,
                          ),
                        ],
                        gapH24,
                        _buildSectionHeader('With HMAC'),
                        gapH12,
                        _buildButton(
                          context,
                          label: 'GET Users (HMAC)',
                          icon: Icons.lock,
                          isLoading: state.isLoading,
                          isHmac: true,
                          onPressed: () =>
                              context.read<HmacDemoCubit>().getUsersHmac(),
                        ),
                        if (state.lastHmacGetResult != null) ...[
                          gapH12,
                          RequestResultCard(
                            result: state.lastHmacGetResult!,
                            showHmacDetails: true,
                          ),
                        ],
                        gapH12,
                        _buildButton(
                          context,
                          label: 'POST Data (HMAC)',
                          icon: Icons.lock_outline,
                          isLoading: state.isLoading,
                          isHmac: true,
                          onPressed: () =>
                              context.read<HmacDemoCubit>().postDataHmac(),
                        ),
                        if (state.lastHmacPostResult != null) ...[
                          gapH12,
                          RequestResultCard(
                            result: state.lastHmacPostResult!,
                            showHmacDetails: true,
                          ),
                        ],
                        gapH24,
                        _buildSectionHeader('Tamper Demonstrations'),
                        gapH8,
                        Text(
                          'These simulate what a backend verifier would detect. '
                          'Run an HMAC request first, then tap a tamper button.',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 13,
                          ),
                        ),
                        gapH12,
                        _buildTamperButton(
                          context,
                          label: 'Tamper Body',
                          isLoading: state.isLoading,
                          onPressed: () => context
                              .read<HmacDemoCubit>()
                              .demonstrateTamperedBody(),
                        ),
                        if (state.tamperBodyResult != null) ...[
                          gapH12,
                          RequestResultCard(
                            result: state.tamperBodyResult!,
                            showHmacDetails: true,
                          ),
                        ],
                        gapH8,
                        _buildTamperButton(
                          context,
                          label: 'Tamper Timestamp',
                          isLoading: state.isLoading,
                          onPressed: () => context
                              .read<HmacDemoCubit>()
                              .demonstrateTamperedTimestamp(),
                        ),
                        if (state.tamperTimestampResult != null) ...[
                          gapH12,
                          RequestResultCard(
                            result: state.tamperTimestampResult!,
                            showHmacDetails: true,
                          ),
                        ],
                        gapH8,
                        _buildTamperButton(
                          context,
                          label: 'Wrong Secret Key',
                          isLoading: state.isLoading,
                          onPressed: () => context
                              .read<HmacDemoCubit>()
                              .demonstrateWrongSecret(),
                        ),
                        if (state.tamperSecretResult != null) ...[
                          gapH12,
                          RequestResultCard(
                            result: state.tamperSecretResult!,
                            showHmacDetails: true,
                          ),
                        ],
                        if (state.errorMessage != null) ...[
                          gapH12,
                          Text(
                            state.errorMessage!,
                            style: const TextStyle(color: Colors.redAccent),
                          ),
                        ],
                        gapH32,
                      ]),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        gapH4,
        Container(
          height: 2,
          width: 60,
          color: const Color(0xFFE94560),
        ),
      ],
    );
  }

  Widget _buildButton(
    BuildContext context, {
    required String label,
    required IconData icon,
    required bool isLoading,
    required VoidCallback onPressed,
    bool isHmac = false,
  }) {
    return SizedBox(
      width: double.infinity,
      height: AppSpacing.spacing48,
      child: ElevatedButton.icon(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isHmac ? const Color(0xFF0F3460) : const Color(0xFF2A2A4A),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.spacing12),
            side: isHmac
                ? const BorderSide(color: Color(0xFFE94560))
                : BorderSide.none,
          ),
        ),
        icon: isLoading
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Icon(icon),
        label: Text(
          label,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildTamperButton(
    BuildContext context, {
    required String label,
    required bool isLoading,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: AppSpacing.spacing44,
      child: OutlinedButton.icon(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.orangeAccent,
          side: const BorderSide(color: Colors.orangeAccent),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.spacing12),
          ),
        ),
        icon: const Icon(Icons.warning_amber, size: 18),
        label: Text(label),
      ),
    );
  }
}
