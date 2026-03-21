import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/colours.dart';

/// Premium pill-shaped button with tactile press feedback.
/// Implements taste-skill "active:scale-[0.98]" physical push simulation.
class SpuerhundButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;
  final bool isLoading;
  final bool fullWidth;
  final IconData? icon;

  const SpuerhundButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
    this.isLoading = false,
    this.fullWidth = true,
    this.icon,
  });

  @override
  State<SpuerhundButton> createState() => _SpuerhundButtonState();
}

class _SpuerhundButtonState extends State<SpuerhundButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _pressController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _pressController = AnimationController(
      vsync: this,
      duration: SpuerhundDurations.micro,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _pressController, curve: SpuerhundCurves.snappy),
    );
  }

  @override
  void dispose() {
    _pressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.icon != null && !widget.isLoading) ...[
          Icon(widget.icon, size: 20),
          const SizedBox(width: 10),
        ],
        if (widget.isLoading)
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              valueColor: AlwaysStoppedAnimation<Color>(
                widget.isPrimary ? Colors.white : SpuerhundColours.primary,
              ),
            ),
          )
        else
          Text(widget.text),
      ],
    );

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        );
      },
      child: GestureDetector(
        onTapDown: (_) => _pressController.forward(),
        onTapUp: (_) {
          _pressController.reverse();
          if (!widget.isLoading) widget.onPressed();
        },
        onTapCancel: () => _pressController.reverse(),
        child: SizedBox(
          width: widget.fullWidth ? double.infinity : null,
          height: 56,
          child: widget.isPrimary
              ? _buildPrimaryButton(content)
              : _buildSecondaryButton(content),
        ),
      ),
    );
  }

  Widget _buildPrimaryButton(Widget content) {
    return Container(
      decoration: BoxDecoration(
        color: widget.isLoading
            ? SpuerhundColours.primary.withValues(alpha: 0.7)
            : SpuerhundColours.primary,
        borderRadius: BorderRadius.circular(SpuerhundRadius.pill),
        boxShadow: widget.isLoading
            ? null
            : [
                BoxShadow(
                  color: SpuerhundColours.primary.withValues(alpha: 0.25),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                  spreadRadius: -4,
                ),
              ],
      ),
      alignment: Alignment.center,
      child: DefaultTextStyle(
        style: GoogleFonts.manrope(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
        child: IconTheme(
          data: const IconThemeData(color: Colors.white),
          child: content,
        ),
      ),
    );
  }

  Widget _buildSecondaryButton(Widget content) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(SpuerhundRadius.pill),
        border: Border.all(
          color: SpuerhundColours.divider,
          width: 1.5,
        ),
      ),
      alignment: Alignment.center,
      child: DefaultTextStyle(
        style: GoogleFonts.manrope(
          color: SpuerhundColours.textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
        child: IconTheme(
          data: const IconThemeData(color: SpuerhundColours.textPrimary),
          child: content,
        ),
      ),
    );
  }
}
