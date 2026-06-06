import 'package:ag_chirag_web/common_controller/custom_controller.dart';
import 'package:ag_chirag_web/screens/authentication/Login/controller/admin_login_controller.dart';
import 'package:ag_chirag_web/screens/authentication/Login/custom_widget/input_field.dart';
import 'package:ag_chirag_web/screens/authentication/Login/custom_widget/mini_chart.dart';
import 'package:ag_chirag_web/screens/authentication/Login/custom_widget/pulse_dot.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AdminLoginController adminLoginController = Get.put(
    AdminLoginController(),
  );
  bool _obscure = true;
  final CommonController commonCtrl = Get.find<CommonController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1300),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Row(
                children: [
                  // ── Left branding panel ──
                  Expanded(flex: 5, child: leftPanel()),
                  // ── Right form panel ──
                  Expanded(
                    flex: 4,
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 44,
                        vertical: 48,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header
                          const Text(
                            'Welcome back',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF111827),
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Sign in to your TradeDesk account',
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF6B7280),
                            ),
                          ),
                          const SizedBox(height: 32),

                          // User ID field
                          fieldLabel(text: 'User ID or Email'),
                          const SizedBox(height: 6),
                          InputField(
                            controller: adminLoginController.emailController,
                            hint: 'e.g. H54980091 or you@email.com',
                            icon: Icons.person_outline_rounded,
                          ),
                          const SizedBox(height: 16),

                          // Password field
                          fieldLabel(text: 'Password'),
                          const SizedBox(height: 6),
                          InputField(
                            controller: adminLoginController.passwordController,
                            hint: 'Enter your password',
                            icon: Icons.lock_outline_rounded,
                            obscure: _obscure,
                            suffix: IconButton(
                              onPressed: () =>
                                  setState(() => _obscure = !_obscure),
                              icon: Icon(
                                _obscure
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                size: 18,
                                color: const Color(0xFF9CA3AF),
                              ),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ),
                          const SizedBox(height: 14),

                          // // Remember + Forgot
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     GestureDetector(
                          //       onTap: () => setState(() => _remember = !_remember),
                          //       child: Row(children: [
                          //         AnimatedContainer(
                          //           duration: const Duration(milliseconds: 150),
                          //           width: 18, height: 18,
                          //           decoration: BoxDecoration(
                          //             color: _remember ? const Color(0xFF2563EB) : Colors.white,
                          //             borderRadius: BorderRadius.circular(4),
                          //             border: Border.all(
                          //               color: _remember ? const Color(0xFF2563EB) : const Color(0xFFD1D5DB),
                          //               width: 1.5,
                          //             ),
                          //           ),
                          //           child: _remember
                          //               ? const Icon(Icons.check_rounded, size: 12, color: Colors.white)
                          //               : null,
                          //         ),
                          //         const SizedBox(width: 8),
                          //         const Text('Remember me',
                          //             style: TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
                          //       ]),
                          //     ),
                          //     TextButton(
                          //       onPressed: () {},
                          //       style: TextButton.styleFrom(
                          //         padding: EdgeInsets.zero,
                          //         minimumSize: Size.zero,
                          //         tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          //       ),
                          //       child: const Text('Forgot password?',
                          //           style: TextStyle(
                          //               fontSize: 12, color: Color(0xFF2563EB),
                          //               fontWeight: FontWeight.w600)),
                          //     ),
                          //   ],
                          // ),
                          // const SizedBox(height: 22),

                          // Sign in button
                          SizedBox(
                            width: double.infinity,
                            height: 46,
                            child: ElevatedButton(
                              onPressed: () {
                                if (adminLoginController
                                    .onCheckAllFieldsValidation()) {
                                  adminLoginController.logIn(
                                    adminLoginController.emailController.text,
                                    adminLoginController
                                        .passwordController
                                        .text,
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2563EB),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Obx(
                                () => adminLoginController.isAdminLoading.value
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.login_rounded, size: 18),
                                          SizedBox(width: 8),
                                          Text(
                                            'Sign in to TradeDesk',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // // Divider
                          // Row(children: [
                          //   const Expanded(child: Divider(color: Color(0xFFE5E7EB), thickness: 0.5)),
                          //   const Padding(
                          //     padding: EdgeInsets.symmetric(horizontal: 12),
                          //     child: Text('or continue with',
                          //         style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
                          //   ),
                          //   const Expanded(child: Divider(color: Color(0xFFE5E7EB), thickness: 0.5)),
                          // ]),
                          // const SizedBox(height: 16),
                          //
                          // // Social buttons
                          // Row(children: [
                          //   _SocialBtn(icon: Icons.g_mobiledata_rounded, label: 'Google', onTap: () {}),
                          //   const SizedBox(width: 10),
                          //   _SocialBtn(icon: Icons.apple_rounded, label: 'Apple', onTap: () {}),
                          //   const SizedBox(width: 10),
                          //   _SocialBtn(icon: Icons.window_rounded, label: 'Microsoft', onTap: () {}),
                          // ]),
                          // const SizedBox(height: 20),
                          //
                          // // Sign up link
                          // Center(
                          //   child: RichText(
                          //     text: TextSpan(
                          //       style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
                          //       children: [
                          //         const TextSpan(text: "Don't have an account? "),
                          //         WidgetSpan(
                          //           child: GestureDetector(
                          //             onTap: () {},
                          //             child: const Text('Create one free',
                          //                 style: TextStyle(
                          //                     fontSize: 12,
                          //                     color: Color(0xFF2563EB),
                          //                     fontWeight: FontWeight.w600)),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget loginForm() {
  //   final primaryColor = Theme.of(context).primaryColor;
  //   return Column(
  //     mainAxisSize: MainAxisSize.min,
  //     crossAxisAlignment: CrossAxisAlignment.stretch,
  //     children: [
  //       // T Logo (simple text/icon placeholder)
  //       Center(
  //         child: Text(
  //           'T',
  //           style: TextStyle(
  //             fontSize: 48,
  //             fontWeight: FontWeight.w900,
  //             color: AppColor.drawerSelectedColor,
  //           ),
  //         ),
  //       ),
  //       const SizedBox(height: 8),
  //       // Welcome Text
  //       const Text(
  //         'Welcome back,',
  //         textAlign: TextAlign.center,
  //         style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  //       ),
  //       const SizedBox(height: 8),
  //       const Text(
  //         'Discover Limitless Choices and Unmatched Convenience.',
  //         textAlign: TextAlign.center,
  //         style: TextStyle(fontSize: 14, color: Colors.grey),
  //       ),
  //       const SizedBox(height: 32),
  //
  //       // E-Mail Field
  //       TextField(
  //         controller: adminLoginController.emailController,
  //         keyboardType: TextInputType.emailAddress,
  //         decoration: _inputDecoration('E-Mail', Icons.email_outlined).copyWith(
  //           prefixIcon: const Icon(Icons.email_outlined, color: Colors.grey),
  //           labelText: 'E-Mail', // Label inside the box
  //         ),
  //       ),
  //       const SizedBox(height: 16),
  //
  //       // Password Field
  //       Obx(
  //         () => TextField(
  //           obscureText: adminLoginController.isPasswordVisible.value,
  //           controller: adminLoginController.passwordController,
  //           decoration: _inputDecoration('Password', Icons.lock_outlined)
  //               .copyWith(
  //                 prefixIcon: const Icon(
  //                   Icons.lock_outlined,
  //                   color: Colors.grey,
  //                 ),
  //                 suffixIcon: IconButton(
  //                   onPressed: () {
  //                     adminLoginController.isPasswordVisible.value =
  //                         !adminLoginController.isPasswordVisible.value;
  //                   },
  //                   icon: adminLoginController.isPasswordVisible.value
  //                       ? Icon(
  //                           Icons.visibility_off_outlined,
  //                           color: Colors.grey,
  //                         )
  //                       : Icon(Icons.visibility_outlined, color: Colors.grey),
  //                 ),
  //                 // Eye icon
  //                 labelText: 'Password', // Label inside the box
  //               ),
  //         ),
  //       ),
  //       const SizedBox(height: 16),
  //
  //       // Remember Me and Forgot Password
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Row(
  //             children: [
  //               Checkbox(
  //                 value: true,
  //                 onChanged: (bool? newValue) {},
  //                 activeColor: AppColor.drawerSelectedColor,
  //               ),
  //               const Text('Remember Me'),
  //             ],
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               // Handle forgot password
  //             },
  //             child: Text(
  //               'Forgot Password?',
  //               style: TextStyle(color: primaryColor),
  //             ),
  //           ),
  //         ],
  //       ),
  //       const SizedBox(height: 24),
  //
  //       // Sign In Button
  //       ElevatedButton(
  //         onPressed: () {
  //           if (adminLoginController.onCheckAllFieldsValidation()) {
  //             adminLoginController.logIn(
  //               adminLoginController.emailController.text,
  //               adminLoginController.passwordController.text,
  //             );
  //           }
  //         },
  //         style: ElevatedButton.styleFrom(
  //           backgroundColor: AppColor.drawerSelectedColor,
  //           foregroundColor: Colors.white,
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(
  //               8.0,
  //             ), // Rounded corners for button
  //           ),
  //           padding: const EdgeInsets.symmetric(vertical: 16.0),
  //         ),
  //         child: Obx(
  //           () => adminLoginController.isAdminLoading.value
  //               ? SizedBox(
  //                   height: 20,
  //                   width: 20,
  //                   child: const CircularProgressIndicator(color: Colors.white),
  //                 )
  //               : Text(
  //                   'Sign In',
  //                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //                 ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Helper to create the styled TextField matching the screenshot's look
  // InputDecoration _inputDecoration(String labelText, IconData icon) {
  //   return InputDecoration(
  //     labelText: labelText,
  //     prefixIcon: Icon(icon, color: Colors.grey),
  //     border: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(12.0),
  //       // Rounded corners for input fields
  //       borderSide:
  //           BorderSide.none, // Hide default border if using filled: true
  //     ),
  //     enabledBorder: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(12.0),
  //       borderSide: const BorderSide(color: Colors.grey, width: 0.5),
  //     ),
  //     focusedBorder: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(12.0),
  //       borderSide: const BorderSide(color: Color(0xFF4267B2), width: 2.0),
  //     ),
  //     // To mimic the screenshot's light background on the input fields
  //     fillColor: AppColor.secondary,
  //     filled: true,
  //   );
  // }

  Widget leftPanel() {
    return Container(
      height: double.infinity,
      color: const Color(0xFF0A1628),
      padding: const EdgeInsets.all(36),
      child: Stack(
        children: [
          // Decorative circles
          Positioned(
            right: -60,
            top: -60,
            child: circleWidget(size: 260, opacity: 0.07),
          ),
          Positioned(
            right: -20,
            top: 20,
            child: circleWidget(size: 160, opacity: 0.05),
          ),
          Positioned(
            left: -40,
            bottom: -40,
            child: circleWidget(size: 200, opacity: 0.06),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo
              Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2563EB),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.trending_up_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'TradeDesk',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
              const Spacer(),

              // Live pill
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF2563EB).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFF3B82F6).withValues(alpha: 0.4),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PulseDot(),
                    const SizedBox(width: 6),
                    const Icon(
                      Icons.candlestick_chart_rounded,
                      color: Color(0xFF60A5FA),
                      size: 13,
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      'Markets open — NSE & BSE',
                      style: TextStyle(
                        color: Color(0xFF93C5FD),
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // Headline
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    height: 1.25,
                  ),
                  children: [
                    TextSpan(
                      text: 'Trade smarter,\ngrow ',
                      style: TextStyle(color: Colors.white),
                    ),
                    TextSpan(
                      text: 'faster',
                      style: TextStyle(color: Color(0xFF60A5FA)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'Real-time market data, smart order management, and portfolio analytics — all in one place.',
                style: TextStyle(
                  color: Color(0xFF8A9BB8),
                  fontSize: 13,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 32),

              // Mini chart visual
              MiniChart(),
              const SizedBox(height: 24),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }

  Widget circleWidget({required double size, required double opacity}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withValues(alpha: opacity),
          width: 0.5,
        ),
      ),
    );
  }

  Widget fieldLabel({required String text}) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Color(0xFF374151),
        letterSpacing: 0.2,
      ),
    );
  }
}
