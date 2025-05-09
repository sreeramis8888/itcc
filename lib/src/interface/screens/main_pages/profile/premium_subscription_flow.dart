import 'package:flutter/material.dart';
import 'package:itcc/src/data/constants/color_constants.dart';
import 'package:itcc/src/data/constants/style_constants.dart';
import 'package:itcc/src/data/globals.dart';
import 'package:itcc/src/data/utils/secure_storage.dart';
import 'package:itcc/src/interface/components/Buttons/primary_button.dart';

class PremiumSubscriptionFlow extends StatefulWidget {
  final VoidCallback? onComplete;
  const PremiumSubscriptionFlow({Key? key, this.onComplete}) : super(key: key);
  @override
  State<PremiumSubscriptionFlow> createState() =>
      PremiumSubscriptionFlowState();
}

class PremiumSubscriptionFlowState extends State<PremiumSubscriptionFlow> {
  int _page = 0;

  void _next() {
    setState(() {
      _page++;
    });
  }

  void _skip() {
    if (widget.onComplete != null) {
      widget.onComplete!();
    } else {
      Navigator.of(context).pushReplacementNamed('MainPage');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_page == 0) {
      return Scaffold(
        backgroundColor: kPrimaryLightColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32),
                  Text(
                    'Get ITCC Premium for Your Business',
                    style: kDisplayTitleM.copyWith(fontSize: 27),
                  ),
                  const SizedBox(height: 32),
                  _PremiumFeatureTimeline(),
                  const SizedBox(height: 24),
                  customButton(
                    label: 'View Plan',
                    onPressed: _next,
                    buttonColor: kPrimaryColor,
                    fontSize: 16,
                  ),
                  const SizedBox(height: 16),
                  customButton(
                    label: 'Start Your Free Trial',
                    onPressed: _skip,
                    buttonColor: Colors.transparent,
                    labelColor: kBlack,
                    sideColor: kPrimaryColor,
                    fontSize: 16,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Discover the right subscription to boost your business visibility and network.',
                    style: kBodyTextStyle.copyWith(fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: kPrimaryLightColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32),
                  Text(
                    'Pick a subscription',
                    style: kDisplayTitleSB.copyWith(fontSize: 26),
                  ),
                  const SizedBox(height: 32),
                  _PremiumPlanCard(onComplete: widget.onComplete),
                  const SizedBox(height: 24),
                  customButton(
                    label: 'Start Your Free Trial',
                    onPressed: _skip,
                    buttonColor: Colors.transparent,
                    labelColor: kBlack,
                    sideColor: kPrimaryColor,
                    fontSize: 16,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Terms and Conditions apply',
                    style:
                        kBodyTextStyle.copyWith(fontSize: 12, color: kGreyDark),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}

class _PremiumFeatureTimeline extends StatelessWidget {
  final int featureCount = 3;
  final List<String> titles = [
    'Select a Plan',
    'Pay the Respective Amount',
    'Unlock All Features',
  ];
  final List<String> subtitles = [
    'Choose the subscription plan that fits you best.\nWhether you\'re just starting out or need access to advanced tools. Take a moment to review the features and pick the one that aligns with your goals.',
    'Proceed with a secure and hassle-free payment.\nOnce you\'ve selected a plan, complete your purchase through our trusted payment gateway. We ensure a smooth and safe transaction experience every step of the way.',
    'Enjoy unlimited access to all premium features.\nAfter your payment is confirmed, your account will be instantly upgraded. Dive into the full range of tools and services designed to help you get the most out of your experience.',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(featureCount * 2 - 1, (i) {
        if (i.isOdd) {
          return const SizedBox(height: 0);
        }
        final index = i ~/ 2;
        return _PremiumFeatureTile(
          title: titles[index],
          subtitle: subtitles[index],
          showLine: index < featureCount - 1,
        );
      }),
    );
  }
}

class _PremiumFeatureTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool showLine;

  const _PremiumFeatureTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.showLine,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(0xFFE1E7FF),
                  border: Border.all(color: Color(0xFFC6D2FF), width: 1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child:
                      Icon(Icons.shutter_speed, color: kPrimaryColor, size: 22),
                ),
              ),
              if (showLine)
                Expanded(
                  child: Container(
                    width: 2,
                    color: kPrimaryColor.withOpacity(0.5),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: kDisplayTitleSB.copyWith(
                      fontSize: 16, color: kPrimaryColor),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: kBodyTextStyle.copyWith(fontSize: 12),
                ),
                if (showLine) const SizedBox(height: 48),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PremiumPlanCard extends StatelessWidget {
  final VoidCallback? onComplete;
  const _PremiumPlanCard({Key? key, this.onComplete}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: kPrimaryColor, width: 1),
        borderRadius: BorderRadius.circular(20),
        color: kWhite,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text('BEST PLAN',
                  style: kSmallTitleR.copyWith(color: kWhite)),
            ),
          ),
          const SizedBox(height: 16),
          Text('Dubai Connect Premium',
              style: kDisplayTitleSB.copyWith(fontSize: 20)),
          const SizedBox(height: 8),
          Text(
              'Enjoy full access to exclusive features and premium networking tools for an entire year.',
              style: kSmallTitleR),
          const SizedBox(height: 18),
          Row(
            children: [
              Text('₹1000', style: kDisplayTitleSB.copyWith(fontSize: 24)),
              Text('/year', style: kBodyTextStyle.copyWith(fontSize: 24)),
              Spacer(),
              Text('₹83.3/month equivalent',
                  style:
                      kBodyTextStyle.copyWith(fontSize: 12, color: kGreyDark)),
            ],
          ),
          const SizedBox(height: 18),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _PlanBenefit(text: 'Self-manage products and services'),
              _PlanBenefit(text: 'Send Product and Business enquiries'),
              _PlanBenefit(text: 'Direct Messaging Access'),
            ],
          ),
          const SizedBox(height: 22),
          customButton(
            label: 'Select This Plan',
            onPressed: () async {
              if (onComplete != null) {
                onComplete!();
              }
            },
            buttonColor: kPrimaryColor,
            fontSize: 16,
          ),
        ],
      ),
    );
  }
}

class _PlanBenefit extends StatelessWidget {
  final String text;
  const _PlanBenefit({required this.text});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: kPrimaryColor, size: 15),
          const SizedBox(width: 10),
          Text(text, style: kBodyTextStyle.copyWith(fontSize: 12)),
        ],
      ),
    );
  }
}

const kBodyTextStyle = TextStyle(fontSize: 15, color: kGreyDark, height: 1.5);
