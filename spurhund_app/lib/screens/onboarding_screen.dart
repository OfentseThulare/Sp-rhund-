import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/colours.dart';
import '../widgets/spuerhund_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  late AnimationController _iconController;
  late Animation<double> _iconScale;

  @override
  void initState() {
    super.initState();
    _iconController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _iconScale = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _iconController, curve: SpuerhundCurves.spring),
    );
    _iconController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _iconController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 1) {
      _pageController.nextPage(
        duration: SpuerhundDurations.slow,
        curve: SpuerhundCurves.premium,
      );
    } else {
      context.go('/signup-province');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SpuerhundColours.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                  _iconController.reset();
                  _iconController.forward();
                },
                children: [
                  _buildPage(
                    title: 'Never Miss a\nMunicipal Bill',
                    description:
                        'Spürhund tracks your Tshwane accounts 24/7. Get instant alerts when bills are issued or due.',
                    icon: Icons.notifications_active_rounded,
                    gradient: [
                      SpuerhundColours.primary.withValues(alpha: 0.25),
                      SpuerhundColours.primaryTint,
                    ],
                  ),
                  _buildPage(
                    title: 'Resolve Disputes\nFast',
                    description:
                        'Direct integration with city systems for faster resolution of billing errors and service requests.',
                    icon: Icons.speed_rounded,
                    gradient: [
                      SpuerhundColours.success.withValues(alpha: 0.20),
                      SpuerhundColours.successTint,
                    ],
                  ),
                ],
              ),
            ),
            _buildBottomControls(),
          ],
        ),
      ),
    );
  }

  Widget _buildPage({
    required String title,
    required String description,
    required IconData icon,
    required List<Color> gradient,
  }) {
    return Padding(
      padding: const EdgeInsets.all(SpuerhundSpacing.lg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animated icon container
          AnimatedBuilder(
            animation: _iconScale,
            builder: (context, child) {
              return Transform.scale(
                scale: _iconScale.value,
                child: child,
              );
            },
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: gradient,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: SpuerhundColours.primary.withValues(alpha: 0.08),
                    blurRadius: 40,
                    offset: const Offset(0, 16),
                  ),
                ],
              ),
              child: Icon(icon, size: 56, color: SpuerhundColours.primary),
            ),
          ),
          const SizedBox(height: SpuerhundSpacing.xxl),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.epilogue(
              fontSize: 34,
              fontWeight: FontWeight.bold,
              height: 1.1,
              letterSpacing: -1.2,
              color: SpuerhundColours.textPrimary,
            ),
          ),
          const SizedBox(height: SpuerhundSpacing.md),
          Text(
            description,
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(
              fontSize: 16,
              color: SpuerhundColours.textSecondary,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomControls() {
    return Container(
      padding: const EdgeInsets.all(SpuerhundSpacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Animated page indicator dots
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              2,
              (index) => AnimatedContainer(
                duration: SpuerhundDurations.fast,
                curve: SpuerhundCurves.spring,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: _currentPage == index ? 28 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? SpuerhundColours.primary
                      : SpuerhundColours.border,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          const SizedBox(height: SpuerhundSpacing.xl),
          SpuerhundButton(
            text: _currentPage == 0 ? 'Continue' : 'Get Started',
            onPressed: _nextPage,
          ),
          if (_currentPage == 0) ...[
            const SizedBox(height: SpuerhundSpacing.md),
            TextButton(
              onPressed: () => context.go('/signup-province'),
              child: Text(
                'Skip',
                style: GoogleFonts.manrope(
                  color: SpuerhundColours.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
