import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';

class OpPatientProfileCard extends StatelessWidget {
  final String imagePath;
  final String patientName;
  final String patientId;
  final String visitId;
  final String validityDate;
  final String age;
  final String gender;
  final VoidCallback? onViewTap;

  const OpPatientProfileCard({
    super.key,
    required this.imagePath,
    required this.patientName,
    required this.patientId,
    required this.visitId,
    required this.validityDate,
    required this.age,
    required this.gender,
    this.onViewTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Left Image Section ---
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  bottomLeft: Radius.circular(12.0),
                ),
                child: Image.asset(
                  imagePath,
                  width: 110,
                  height: 160,
                  fit: BoxFit.cover,
                ),
              ),
              // "View" Button overlay
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: SizedBox(
                  height: 28,
                  child: ElevatedButton(
                    onPressed: onViewTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.color1E1E1E,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: Text(
                      'View',
                      style: AppTextStyles.RegH3.copyWith(
                          color: AppColor.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // --- Right Details Section ---
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Row 1: Name & Visit ID
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            patientName,
                            style: AppTextStyles.RegH3.copyWith(
                              color: AppColor.color117A7A, // Primary Teal
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            patientId,
                            style: AppTextStyles.RegH3.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Visit ID',
                            style: AppTextStyles.RegH3.copyWith(
                              fontSize: 11,
                              color: AppColor.colorB7B7B7,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            visitId,
                            style: AppTextStyles.RegH3.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Row 2: Validity & Age/Gender
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Validity',
                            style: AppTextStyles.RegH3.copyWith(
                              fontSize: 11,
                              color: AppColor.colorB7B7B7,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            validityDate,
                            style: AppTextStyles.RegH3.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Age / Gender',
                            style: AppTextStyles.RegH3.copyWith(
                              fontSize: 11,
                              color: AppColor.colorB7B7B7,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '$age / $gender',
                            style: AppTextStyles.RegH3.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}