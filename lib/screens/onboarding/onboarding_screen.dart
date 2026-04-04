import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/colours.dart';
import '../../theme/typography.dart';
import '../../widgets/common/spuerhund_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  double _pageOffset = 0.0;

  static const List<_SlideData> _slides = [
    _SlideData(
      centralIcon: Icons.dashboard_rounded,
      orbitingIcons: [
        Icons.water_drop_rounded,
        Icons.bolt_rounded,
        Icons.account_balance_rounded,
      ],
      title: 'One place for everything',
      subtitle:
          'Water, electricity, rates, waste. One dashboard, one total, one glance.',
    ),
    _SlideData(
      centralIcon: Icons.notifications_active_rounded,
      orbitingIcons: [
        Icons.calendar_today_rounded,
        Icons.alarm_rounded,
        Icons.check_circle_outline_rounded,
      ],
      title: "We'll remind you before it's too late",
      subtitle:
          "Missed payments lead to disconnections. We watch your due dates so you don't have to.",
    ),
    _SlideData(
      centralIcon: Icons.location_on_rounded,
      orbitingIcons: [
        Icons.flash_on_rounded,
        Icons.warning_amber_rounded,
        Icons.build_rounded,
      ],
      title: "Know what's happening in your area",
      subtitle:
          "Load shedding, water outages, maintenance. Before it hits you, you'll know.",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_onPageScroll);
  }

  void _onPageScroll() {
    setState(() {
      _pageOffset = _pageController.page ?? 0.0;
    });
  }

  @override
  void dispose() {
    _pageController.removeListener(_onPageScroll);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.voidBlack,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Semantics(
                  button: true,
                  label: 'Skip onboarding',
                  child: GestureDetector(
                    onTap: () => context.go('/signup'),
                    child: SizedBox(
                      height: 44,
                      child: Center(
                        child: Text(
                          'Skip',
                          style: AppTypography.bodyLarge.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColours.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // PageView
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _slides.length,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemBuilder: (context, index) {
                  final slide = _slides[index];
                  final parallaxOffset = (_pageOffset - index) * 40.0;
                  return _buildSlide(slide, parallaxOffset);
                },
              ),
            ),

            // Dot indicators
            _buildDotIndicators(),
            const SizedBox(height: 24),

            // Get Started button (slide 3 only)
            if (_currentPage == _slides.length - 1) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SpuerhundButton(
                  label: 'Get Started',
                  onPressed: () => context.go('/signup'),
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Sign in link (all slides)
            Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Semantics(
                button: true,
                label: 'Sign in to existing account',
                child: GestureDetector(
                  onTap: () => context.go('/login'),
                  child: SizedBox(
                    height: 44,
                    child: Center(
                      child: RichText(
                      text: TextSpan(
                        text: 'Already have an account? ',
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColours.textSecondary,
                        ),
                        children: [
                          TextSpan(
                            text: 'Sign in',
                            style: TextStyle(
                              color: AppColours.primaryPurple,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlide(_SlideData slide, double parallaxOffset) {
    return Column(
      children: [
        // Top 60%: geometric illustration
        Expanded(
          flex: 6,
          child: Center(
            child: Transform.translate(
              offset: Offset(parallaxOffset, 0),
              child: _GeometricIllustration(
                centralIcon: slide.centralIcon,
                orbitingIcons: slide.orbitingIcons,
              ),
            ),
          ),
        ),

        // Bottom 40%: text content
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Semantics(
                  header: true,
                  child: Text(
                    slide.title,
                    textAlign: TextAlign.center,
                    style: AppTypography.headlineLarge.copyWith(
                      fontSize: 26,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  slide.subtitle,
                  textAlign: TextAlign.center,
                  style: AppTypography.bodyLarge.copyWith(
                    color: AppColours.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDotIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_slides.length, (i) {
        final isActive = _currentPage == i;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive
                ? AppColours.primaryPurple
                : Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}

class _GeometricIllustration extends StatelessWidget {
  final IconData centralIcon;
  final List<IconData> orbitingIcons;

  const _GeometricIllustration({
    required this.centralIcon,
    required this.orbitingIcons,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      height: 280,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Purple gradient glow
          Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColours.primaryPurple.withValues(alpha: 0.25),
                  blurRadius: 60,
                  spreadRadius: 20,
                ),
              ],
            ),
          ),

          // Central container
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppColours.surface,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: AppColours.borderSubtle),
            ),
            child: Icon(
              centralIcon,
              size: 48,
              color: AppColours.pureWhite,
            ),
          ),

          // Orbiting container: top left
          Positioned(
            top: 20,
            left: 30,
            child: _orbitingContainer(orbitingIcons[0]),
          ),

          // Orbiting container: top right
          Positioned(
            top: 20,
            right: 30,
            child: _orbitingContainer(orbitingIcons[1]),
          ),

          // Orbiting container: bottom centre
          Positioned(
            bottom: 30,
            child: _orbitingContainer(orbitingIcons[2]),
          ),
        ],
      ),
    );
  }

  Widget _orbitingContainer(IconData icon) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: AppColours.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColours.borderSubtle),
      ),
      child: Icon(
        icon,
        size: 22,
        color: AppColours.pureWhite,
      ),
    );
  }
}

class _SlideData {
  final IconData centralIcon;
  final List<IconData> orbitingIcons;
  final String title;
  final String subtitle;

  const _SlideData({
    required this.centralIcon,
    required this.orbitingIcons,
    required this.title,
    required this.subtitle,
  });
}
