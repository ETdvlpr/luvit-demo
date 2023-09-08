import 'package:flutter/material.dart';
import 'package:luvit/core/models/profile.dart';
import 'package:luvit/shared/theme/app_theme.dart';

class ProfileTags extends StatelessWidget {
  final Profile profile;

  const ProfileTags({
    required this.profile,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 4,
      runSpacing: 4,
      children: profile.tags
          .asMap()
          .entries
          .map((entry) => _buildProfileTag(entry.value, index: entry.key))
          .toList(),
    );
  }

  Widget _buildProfileTag(
    String label, {
    required int index,
  }) {
    final bool highlight = index == 0;

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 13,
        horizontal: 15,
      ),
      decoration: ShapeDecoration(
        color: highlight ? AppTheme.primaryPartial : AppTheme.black58,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 0.50,
            color: highlight ? AppTheme.primaryColor : AppTheme.black31,
          ),
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      child: Text(
        label,
        style: AppTheme.boldTextStyle.copyWith(
          color: highlight ? AppTheme.primaryColor : AppTheme.white245,
        ),
      ),
    );
  }
}
