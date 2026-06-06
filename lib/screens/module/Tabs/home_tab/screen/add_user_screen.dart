import 'dart:convert';

import 'package:ag_chirag_web/screens/module/Tabs/home_tab/model/user_model.dart';
import 'package:ag_chirag_web/utils/app_prefs_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddUserScreen extends StatefulWidget {
  final int? index;
  final String? documentId;
  final UserModel? clientData;

  const AddUserScreen({
    super.key,
    this.documentId,
    this.clientData,
    this.index,
  });

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  // ── Controllers ──────────────────────────────────────────────────────────
  final TextEditingController usernameCtr = TextEditingController();
  final TextEditingController clientcodeCtr = TextEditingController();
  final TextEditingController passwordCtr = TextEditingController();
  final TextEditingController privateKeyCtr = TextEditingController();
  final TextEditingController secretKeyCtr = TextEditingController();
  final TextEditingController ipNameCtr = TextEditingController();
  final TextEditingController publicIPCtr = TextEditingController();
  final TextEditingController portCtr = TextEditingController();
  final TextEditingController ipPwdCtr = TextEditingController();

  bool _showPassword = false;
  bool _showPrivateKey = false;
  bool _showSecretKey = false;
  bool _showIpPwd = false;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    if (widget.clientData != null) {
      usernameCtr.text = widget.clientData!.username.toString();
      clientcodeCtr.text = widget.clientData!.clientcode.toString();
      passwordCtr.text = widget.clientData!.password.toString();
      privateKeyCtr.text = widget.clientData!.privateKey.toString();
      secretKeyCtr.text = widget.clientData!.secretKey.toString();
      ipNameCtr.text = widget.clientData!.ipName.toString();
      publicIPCtr.text = widget.clientData!.publicIP.toString();
      portCtr.text = widget.clientData!.port.toString();
      ipPwdCtr.text = widget.clientData!.ipPwd.toString();
    }
  }

  @override
  void dispose() {
    usernameCtr.dispose();
    clientcodeCtr.dispose();
    passwordCtr.dispose();
    privateKeyCtr.dispose();
    secretKeyCtr.dispose();
    ipNameCtr.dispose();
    publicIPCtr.dispose();
    portCtr.dispose();
    ipPwdCtr.dispose();
    super.dispose();
  }

  void _submit({String? documentId}) async {
    setState(() => _loading = true);
    List<UserModel> userList = await SharedPref.getUserData();
    bool isSuccess = false;

    try {
      // 1. Gather your form data into a Map
      Map<String, dynamic> clientData = {
        'username': usernameCtr.text.trim(),
        'clientCode': clientcodeCtr.text.trim(),
        'password': passwordCtr.text,
        'privateKey': privateKeyCtr.text.trim(),
        'secretKey': secretKeyCtr.text.trim(),
        'ipName': ipNameCtr.text.trim(),
        'publicIP': publicIPCtr.text.trim(),
        'port': portCtr.text.trim(),
        'ipPassword': ipPwdCtr.text,
        // 'updatedAt' is great for tracking when edits happen
        'updatedAt': FieldValue.serverTimestamp(),
      };

      // 2. Reference the 'clients' collection
      final collectionRef = FirebaseFirestore.instance.collection('clients');
      print("Check=> ${documentId != null && documentId.isNotEmpty}");
      if (documentId != null && documentId.isNotEmpty) {
        // 👉 EDIT MODE: Update the specific document matching the ID
        await collectionRef.doc(documentId).update(clientData);
        print("Data updated successfully for ID: $documentId");

        List<UserModel> userList = await SharedPref.getUserData();
        userList[widget.index!] = UserModel(
          ipName: ipNameCtr.value.text,
          ipPwd: ipPwdCtr.value.text,
          port: portCtr.value.text,
          publicIP: publicIPCtr.value.text,
          clientcode: clientcodeCtr.value.text,
          secretKey: secretKeyCtr.value.text,
          privateKey: privateKeyCtr.value.text,
          password: passwordCtr.value.text,
          username: usernameCtr.value.text,
        );

        List<String> userListForSp = [];
        for (var item in userList) {
          userListForSp.add(json.encode(item.toJson()));
        }
      } else {
        // 👉 ADD MODE: Add a completely new document (with server timestamp)
        clientData['createdAt'] = FieldValue.serverTimestamp();
        await collectionRef.add(clientData);
        print("New data added successfully!");

        userList.add(
          UserModel(
            ipName: ipNameCtr.value.text,
            ipPwd: ipPwdCtr.value.text,
            port: portCtr.value.text,
            publicIP: publicIPCtr.value.text,
            clientcode: clientcodeCtr.value.text,
            secretKey: secretKeyCtr.value.text,
            privateKey: privateKeyCtr.value.text,
            password: passwordCtr.value.text,
            username: usernameCtr.value.text,
          ),
        );

        List<String> userListForSp = [];
        for (var item in userList) {
          userListForSp.add(json.encode(item.toJson()));
        }
        SharedPref.setUserData(userListForSp);
      }

      isSuccess = true;
    } catch (error) {
      print("Database error: $error");
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Failed to save data: $error")));
      }
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }

    if (isSuccess && mounted) {
      Navigator.pop(context);
    }
  }

  // void _submit() async {
  //   // 1. Show the loading spinner
  //   setState(() => _loading = true);
  //
  //   // Variable to track if the save was successful
  //   bool isSuccess = false;
  //
  //   try {
  //     // 2. Map your controller values to a Map
  //     Map<String, dynamic> clientData = {
  //       'username': usernameCtr.text.trim(),
  //       'clientCode': clientcodeCtr.text.trim(),
  //       'password': passwordCtr.text,
  //       'privateKey': privateKeyCtr.text.trim(),
  //       'secretKey': secretKeyCtr.text.trim(),
  //       'ipName': ipNameCtr.text.trim(),
  //       'publicIP': publicIPCtr.text.trim(),
  //       'port': portCtr.text.trim(),
  //       'ipPassword': ipPwdCtr.text,
  //       'createdAt': FieldValue.serverTimestamp(),
  //     };
  //
  //     // 3. Await the actual database insert operation
  //     await FirebaseFirestore.instance.collection('clients').add(clientData);
  //
  //     // If it reaches here without throwing an error, it succeeded!
  //     isSuccess = true;
  //
  //   } catch (error) {
  //     print("Database error: $error");
  //
  //     // Optional: Show an error alert/Snackbar to the user if it fails
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text("Failed to save data: $error")),
  //       );
  //     }
  //   } finally {
  //     // 4. Turn off loading state regardless of success or failure
  //     if (mounted) {
  //       setState(() => _loading = false);
  //     }
  //   }
  //
  //   // 5. Only close the screen if the data was added successfully
  //   if (isSuccess && mounted) {
  //     Navigator.pop(context);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
            child: Column(
              children: [
                // ── Header ──────────────────────────────────────────────
                _buildHeader(context),
                const SizedBox(height: 16),

                // ── Scrollable form ──────────────────────────────────────
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _SectionCard(
                          icon: Icons.badge_outlined,
                          title: 'User Credentials',
                          children: [
                            _TwoColumn(
                              left: _FormField(
                                label: 'Username',
                                controller: usernameCtr,
                                hint: 'e.g. harshil_trade',
                                icon: Icons.person_outline_rounded,
                              ),
                              right: _FormField(
                                label: 'Client Code',
                                controller: clientcodeCtr,
                                hint: 'e.g. H54980091',
                                icon: Icons.tag_rounded,
                                suffix: _IdBadge(),
                              ),
                            ),
                            const SizedBox(height: 12),
                            _TwoColumn(
                              left: _FormField(
                                label: 'Password',
                                controller: passwordCtr,
                                hint: 'Enter password',
                                icon: Icons.lock_outline_rounded,
                                obscure: !_showPassword,
                                suffix: _EyeBtn(
                                  visible: _showPassword,
                                  onTap: () => setState(
                                    () => _showPassword = !_showPassword,
                                  ),
                                ),
                              ),
                              right: _HintBox(
                                text:
                                    'Password must be 8+ characters with at least one number and one symbol.',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        _SectionCard(
                          icon: Icons.vpn_key_outlined,
                          title: 'API Keys',
                          badge: _SensitiveBadge(),
                          children: [
                            _TwoColumn(
                              left: _FormField(
                                label: 'Private Key',
                                controller: privateKeyCtr,
                                hint: 'Paste private key',
                                icon: Icons.lock_person_outlined,
                                obscure: !_showPrivateKey,
                                suffix: _EyeBtn(
                                  visible: _showPrivateKey,
                                  onTap: () => setState(
                                    () => _showPrivateKey = !_showPrivateKey,
                                  ),
                                ),
                              ),
                              right: _FormField(
                                label: 'Secret Key',
                                controller: secretKeyCtr,
                                hint: 'Paste secret key',
                                icon: Icons.security_outlined,
                                obscure: !_showSecretKey,
                                suffix: _EyeBtn(
                                  visible: _showSecretKey,
                                  onTap: () => setState(
                                    () => _showSecretKey = !_showSecretKey,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        _SectionCard(
                          icon: Icons.dns_outlined,
                          title: 'Server Configuration',
                          badge: _NetworkBadge(),
                          children: [
                            _ThreeColumn(
                              children: [
                                _FormField(
                                  label: 'Server / IP Name',
                                  controller: ipNameCtr,
                                  hint: 'e.g. prod-server-01',
                                  icon: Icons.storage_outlined,
                                ),
                                _FormField(
                                  label: 'Public IP',
                                  controller: publicIPCtr,
                                  hint: 'e.g. 203.0.113.10',
                                  icon: Icons.language_outlined,
                                ),
                                _FormField(
                                  label: 'Port',
                                  controller: portCtr,
                                  hint: 'e.g. 8080',
                                  icon: Icons.electrical_services_outlined,
                                  keyboardType: TextInputType.number,
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            _FormField(
                              label: 'IP Password',
                              controller: ipPwdCtr,
                              hint: 'Server access password',
                              icon: Icons.lock_outline_rounded,
                              obscure: !_showIpPwd,
                              suffix: _EyeBtn(
                                visible: _showIpPwd,
                                onTap: () =>
                                    setState(() => _showIpPwd = !_showIpPwd),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // ── Footer buttons ──────────────────────────────
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            _CancelBtn(onTap: () => Navigator.pop(context)),
                            const SizedBox(width: 10),
                            _SubmitBtn(
                              loading: _loading,
                              onTap: () {
                                _submit(documentId: widget.documentId);
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFF2563EB),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.person_add_alt_1_rounded,
            color: Colors.white,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add New User',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF111827),
                ),
              ),
              Text(
                'Fill in credentials, API keys and server config',
                style: TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.close_rounded,
            size: 20,
            color: Color(0xFF6B7280),
          ),
          style: IconButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            side: const BorderSide(color: Color(0xFFE5E7EB), width: 0.5),
          ),
        ),
      ],
    );
  }
}

// ── Section Card ──────────────────────────────────────────────────────────────

class _SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? badge;
  final List<Widget> children;

  const _SectionCard({
    required this.icon,
    required this.title,
    this.badge,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Icon(icon, size: 15, color: const Color(0xFF2563EB)),
              ),
              const SizedBox(width: 9),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF374151),
                  letterSpacing: 0.4,
                ),
              ),
              if (badge != null) ...[const SizedBox(width: 8), badge!],
            ],
          ),
          const SizedBox(height: 14),
          const Divider(height: 1, color: Color(0xFFF3F4F6)),
          const SizedBox(height: 14),
          ...children,
        ],
      ),
    );
  }
}

// ── Layout Helpers ────────────────────────────────────────────────────────────

class _TwoColumn extends StatelessWidget {
  final Widget left;
  final Widget right;

  const _TwoColumn({required this.left, required this.right});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: left),
        const SizedBox(width: 12),
        Expanded(child: right),
      ],
    );
  }
}

class _ThreeColumn extends StatelessWidget {
  final List<Widget> children;

  const _ThreeColumn({required this.children});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children
          .map(
            (w) => Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: w == children.last ? 0 : 12),
                child: w,
              ),
            ),
          )
          .toList(),
    );
  }
}

// ── Form Field ────────────────────────────────────────────────────────────────

class _FormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final bool obscure;
  final Widget? suffix;
  final TextInputType keyboardType;

  const _FormField({
    required this.label,
    required this.controller,
    required this.hint,
    required this.icon,
    this.obscure = false,
    this.suffix,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF6B7280),
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          obscureText: obscure,
          keyboardType: keyboardType,
          style: const TextStyle(fontSize: 13, color: Color(0xFF111827)),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 13),
            prefixIcon: Icon(icon, size: 17, color: const Color(0xFF9CA3AF)),
            suffixIcon: suffix,
            filled: true,
            fillColor: const Color(0xFFF9FAFB),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xFFE5E7EB),
                width: 0.5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xFFE5E7EB),
                width: 0.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xFF2563EB),
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ── Hint Box ──────────────────────────────────────────────────────────────────

class _HintBox extends StatelessWidget {
  final String text;

  const _HintBox({required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(' ', style: TextStyle(fontSize: 11)),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.all(11),
          decoration: BoxDecoration(
            color: const Color(0xFFF0F9FF),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFBAE6FD), width: 0.5),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.info_outline_rounded,
                size: 14,
                color: Color(0xFF0284C7),
              ),
              const SizedBox(width: 7),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF0369A1),
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Badges ────────────────────────────────────────────────────────────────────

class _SensitiveBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: const Color(0xFFFEF3C7),
      borderRadius: BorderRadius.circular(20),
    ),
    child: const Text(
      'Sensitive',
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: Color(0xFF92400E),
      ),
    ),
  );
}

class _NetworkBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: const Color(0xFFEFF6FF),
      borderRadius: BorderRadius.circular(20),
    ),
    child: const Text(
      'Network',
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: Color(0xFF1D4ED8),
      ),
    ),
  );
}

class _IdBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(right: 8),
    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
    decoration: BoxDecoration(
      color: const Color(0xFFEFF6FF),
      borderRadius: BorderRadius.circular(20),
    ),
    child: const Text(
      'ID',
      style: TextStyle(
        fontSize: 9,
        fontWeight: FontWeight.w700,
        color: Color(0xFF2563EB),
      ),
    ),
  );
}

// ── Eye Button ────────────────────────────────────────────────────────────────

class _EyeBtn extends StatelessWidget {
  final bool visible;
  final VoidCallback onTap;

  const _EyeBtn({required this.visible, required this.onTap});

  @override
  Widget build(BuildContext context) => IconButton(
    onPressed: onTap,
    icon: Icon(
      visible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
      size: 17,
      color: const Color(0xFF9CA3AF),
    ),
    padding: EdgeInsets.zero,
    constraints: const BoxConstraints(),
  );
}

// ── Buttons ───────────────────────────────────────────────────────────────────

class _CancelBtn extends StatelessWidget {
  final VoidCallback onTap;

  const _CancelBtn({required this.onTap});

  @override
  Widget build(BuildContext context) => OutlinedButton.icon(
    onPressed: onTap,
    icon: const Icon(Icons.close_rounded, size: 15),
    label: const Text('Cancel'),
    style: OutlinedButton.styleFrom(
      foregroundColor: const Color(0xFF374151),
      side: const BorderSide(color: Color(0xFFD1D5DB), width: 0.5),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
    ),
  );
}

class _SubmitBtn extends StatelessWidget {
  final bool loading;
  final VoidCallback onTap;

  const _SubmitBtn({required this.loading, required this.onTap});

  @override
  Widget build(BuildContext context) => ElevatedButton(
    onPressed: loading ? null : onTap,
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF2563EB),
      foregroundColor: Colors.white,
      elevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
    ),
    child: loading
        ? const SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
          )
        : const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.person_add_alt_1_rounded, size: 16),
              SizedBox(width: 8),
              Text(
                'Add User',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
            ],
          ),
  );
}
