import 'package:ag_chirag_web/config/app_colors.dart';
import 'package:ag_chirag_web/config/app_pages.dart';
import 'package:ag_chirag_web/screens/authentication/Login/controller/admin_login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

final AdminLoginController adminLoginController = Get.put(AdminLoginController());

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 1000;
    return Scaffold(backgroundColor: AppColor.secondary,
      body: Center(
        child: Container(
          // Constraining the max width on larger screens for a central card look
          constraints: const BoxConstraints(maxWidth: 600),
          margin: EdgeInsets.symmetric(horizontal: isDesktop ? 40.0 : 0),
          child: Card(
            elevation: 8.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Row(
              children: [
                // // --- Left Section (Illustration/Image) ---
                // if (isDesktop)
                //   Expanded(
                //     child: Container(
                //       padding: const EdgeInsets.all(40.0),
                //       decoration: BoxDecoration(
                //         color: const Color(0xFF4267B2), // Blue background
                //         borderRadius: BorderRadius.circular(16.0),
                //       ),
                //       child: Column(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           // Placeholder for the illustration (removed GIF)
                //           const Icon(
                //             Icons.shopping_cart_outlined,
                //             color: Colors.white,
                //             size: 150,
                //           ),
                //           const SizedBox(height: 16),
                //           const Text(
                //             'T Store',
                //             style: TextStyle(
                //               color: Colors.white,
                //               fontSize: 24,
                //               fontWeight: FontWeight.bold,
                //             ),
                //           ),
                //           const SizedBox(height: 8),
                //           const Text(
                //             'Powered by Coding with T.',
                //             style: TextStyle(
                //               color: Colors.white70,
                //               fontSize: 14,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),

                // --- Right Section (Login Form) ---
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(isDesktop ? 40.0 : 30.0),
                    child:  loginForm(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget loginForm(){
    final primaryColor = Theme.of(context).primaryColor;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // T Logo (simple text/icon placeholder)
        Center(
          child: Text(
            'T',
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w900,
              color: AppColor.drawerSelectedColor,
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Welcome Text
        const Text(
          'Welcome back,',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Discover Limitless Choices and Unmatched Convenience.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 32),

        // E-Mail Field
        TextField(controller: adminLoginController.emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: _inputDecoration('E-Mail', Icons.email_outlined).copyWith(
            prefixIcon: const Icon(Icons.email_outlined, color: Colors.grey),
            labelText: 'E-Mail', // Label inside the box
          ),
        ),
        const SizedBox(height: 16),

        // Password Field
       Obx(()=>TextField(
         obscureText: adminLoginController.isPasswordVisible.value,
         controller: adminLoginController.passwordController,
         decoration: _inputDecoration('Password', Icons.lock_outlined).copyWith(
           prefixIcon: const Icon(Icons.lock_outlined, color: Colors.grey),
           suffixIcon: IconButton(onPressed: (){
             adminLoginController.isPasswordVisible.value = !adminLoginController.isPasswordVisible.value;
           }, icon: adminLoginController.isPasswordVisible.value?Icon(Icons.visibility_off_outlined, color: Colors.grey):
           Icon(Icons.visibility_outlined, color: Colors.grey)), // Eye icon
           labelText: 'Password', // Label inside the box
         ),
       )),
        const SizedBox(height: 16),

        // Remember Me and Forgot Password
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(
                  value: true,
                  onChanged: (bool? newValue) {

                  },
                  activeColor: AppColor.drawerSelectedColor,
                ),
                const Text('Remember Me'),
              ],
            ),
            TextButton(
              onPressed: () {
                // Handle forgot password
              },
              child: Text(
                'Forgot Password?',
                style: TextStyle(color: primaryColor),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Sign In Button
        ElevatedButton(
          onPressed: () {
            Get.toNamed(AppRoutes.dashboardScreen);
                // if(adminLoginController.onCheckAllFieldsValidation()){
                //   adminLoginController.insertUpdateStudRegistrationData();
                // }
            // Handle login logic
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.drawerSelectedColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0), // Rounded corners for button
            ),
            padding: const EdgeInsets.symmetric(vertical: 16.0),
          ),
          child:Obx(()=>  adminLoginController.isAdminLoading.value?SizedBox(
              height: 20,
              width: 20,
              child: const CircularProgressIndicator(color: Colors.white,)): Text(
            'Sign In',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ))
        ),
      ],
    );
  }

  // Helper to create the styled TextField matching the screenshot's look
  InputDecoration _inputDecoration(String labelText, IconData icon) {
    return InputDecoration(
      labelText: labelText,
      prefixIcon: Icon(icon, color: Colors.grey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0), // Rounded corners for input fields
        borderSide: BorderSide.none, // Hide default border if using filled: true
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: Colors.grey, width: 0.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: Color(0xFF4267B2), width: 2.0),
      ),
      // To mimic the screenshot's light background on the input fields
      fillColor: AppColor.secondary,
      filled: true,
    );
  }
}
