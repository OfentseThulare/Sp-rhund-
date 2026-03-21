import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/colours.dart';

/// Premium text field with label-above-input pattern and animated focus state.
/// Follows taste-skill form patterns: label above, helper text optional,
/// error text below, standard gap-2 for input blocks.
class AppTextField extends StatefulWidget {
  final String label;
  final String? hint;
  final TextEditingController? controller;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final String? errorText;
  final IconData? prefixIcon;
  final Widget? suffix;

  const AppTextField({
    super.key,
    required this.label,
    this.hint,
    this.controller,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.errorText,
    this.prefixIcon,
    this.suffix,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscured = true;
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedDefaultTextStyle(
          duration: SpuerhundDurations.fast,
          curve: SpuerhundCurves.snappy,
          style: GoogleFonts.manrope(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: _focused
                ? SpuerhundColours.primary
                : SpuerhundColours.textSecondary,
          ),
          child: Text(widget.label),
        ),
        const SizedBox(height: 8),
        Focus(
          onFocusChange: (focused) {
            setState(() => _focused = focused);
          },
          child: AnimatedContainer(
            duration: SpuerhundDurations.fast,
            curve: SpuerhundCurves.snappy,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SpuerhundRadius.md),
              boxShadow: _focused
                  ? [
                      BoxShadow(
                        color: SpuerhundColours.primary.withValues(alpha: 0.08),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : [],
            ),
            child: TextFormField(
              controller: widget.controller,
              obscureText: widget.isPassword && _obscured,
              keyboardType: widget.keyboardType,
              validator: widget.validator,
              style: GoogleFonts.manrope(
                color: SpuerhundColours.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                hintText: widget.hint,
                errorText: widget.errorText,
                prefixIcon: widget.prefixIcon != null
                    ? Icon(widget.prefixIcon, size: 20,
                        color: _focused
                            ? SpuerhundColours.primary
                            : SpuerhundColours.textTertiary)
                    : null,
                suffixIcon: widget.isPassword
                    ? GestureDetector(
                        onTap: () => setState(() => _obscured = !_obscured),
                        child: Icon(
                          _obscured
                              ? Icons.visibility_off_rounded
                              : Icons.visibility_rounded,
                          size: 20,
                          color: SpuerhundColours.textTertiary,
                        ),
                      )
                    : widget.suffix,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
