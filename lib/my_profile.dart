
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class StudentProfile extends StatefulWidget {
  const StudentProfile({super.key});

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  // Light mode is enabled when the app first opens.
  bool isDarkMode = false;
  bool isSaved = false;

  final ImagePicker _picker = ImagePicker();
  File? _profileImage;

  final TextEditingController _nameController =
  TextEditingController();
  final TextEditingController _courseController =
  TextEditingController();
  final TextEditingController _schoolController =
  TextEditingController();
  final TextEditingController _emailController =
  TextEditingController();
  final TextEditingController _phoneController =
  TextEditingController();
  final TextEditingController _locationController =
  TextEditingController();
  final TextEditingController _levelController =
  TextEditingController();
  final TextEditingController _aboutController =
  TextEditingController(
    text:
    'I am a motivated student who enjoys learning, '
        'developing new skills, and working with others.',
  );

  @override
  void dispose() {
    _nameController.dispose();
    _courseController.dispose();
    _schoolController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    _levelController.dispose();
    _aboutController.dispose();
    super.dispose();
  }

  void _toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  Future<void> _pickProfilePicture() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (pickedFile != null && mounted) {
        setState(() {
          _profileImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not select image: $e'),
        ),
      );
    }
  }

  void _saveProfile() {
    FocusScope.of(context).unfocus();

    setState(() {
      isSaved = true;
    });
  }

  void _editProfile() {
    setState(() {
      isSaved = false;
    });
  }

  void _contactMe() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Contact button pressed!'),
      ),
    );
  }

  ImageProvider<Object> _getProfileImage() {
    if (_profileImage != null) {
      return FileImage(_profileImage!);
    }

    return const AssetImage('assets/vv.jpg');
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: const Color(0xFFF4F7FC),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Color(0xFF172554),
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFF7F9FD),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFFE1E7F0),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.blue,
            width: 1.5,
          ),
        ),
      ),
    );

    final ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: const Color(0xFF121722),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1B2230),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: const Color(0xFF1B2230),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF252E3D),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFF394457),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.lightBlueAccent,
            width: 1.5,
          ),
        ),
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Student Profile',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'My Student Profile',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                IconButton(
                  tooltip: isDarkMode
                      ? 'Switch to light mode'
                      : 'Switch to dark mode',
                  onPressed: _toggleTheme,
                  icon: Icon(
                    isDarkMode
                        ? Icons.light_mode
                        : Icons.dark_mode,
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
            body: SafeArea(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 480,
                  ),
                  child: isSaved
                      ? _buildProfileView(context)
                      : _buildProfileForm(context),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileForm(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 8),
          Text(
            'Create Your Profile',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Enter your details to introduce yourself.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          _buildPhotoPicker(context),
          const SizedBox(height: 24),
          _buildSectionCard(
            context,
            title: 'Personal Information',
            icon: Icons.person_outline,
            children: [
              _buildTextField(
                controller: _nameController,
                label: 'Full Name',
                icon: Icons.badge_outlined,
              ),
              _buildTextField(
                controller: _courseController,
                label: 'Course / Programme',
                icon: Icons.menu_book_outlined,
              ),
              _buildTextField(
                controller: _schoolController,
                label: 'School / University',
                icon: Icons.school_outlined,
              ),
              _buildTextField(
                controller: _emailController,
                label: 'Email Address',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              _buildTextField(
                controller: _phoneController,
                label: 'Phone Number',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),
              _buildTextField(
                controller: _locationController,
                label: 'Location',
                icon: Icons.location_on_outlined,
              ),
              _buildTextField(
                controller: _levelController,
                label: 'Level / Year of Study',
                icon: Icons.school,
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSectionCard(
            context,
            title: 'About Me',
            icon: Icons.edit_note,
            children: [
              TextField(
                controller: _aboutController,
                minLines: 4,
                maxLines: 6,
                textCapitalization:
                TextCapitalization.sentences,
                decoration: const InputDecoration(
                  hintText: 'Write a little about yourself...',
                  alignLabelWithHint: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: _saveProfile,
            icon: const Icon(Icons.save_outlined),
            label: const Text('Save Profile'),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Use the sun/moon icon above to change the theme.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildPhotoPicker(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 58,
          backgroundColor:
          Theme.of(context).colorScheme.surfaceContainerHighest,
          backgroundImage: _getProfileImage(),
          onBackgroundImageError: (_, __) {},
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: _pickProfilePicture,
          icon: const Icon(Icons.photo_library_outlined),
          label: const Text('Choose Profile Picture'),
        ),
      ],
    );
  }

  Widget _buildSectionCard(
      BuildContext context, {
        required String title,
        required IconData icon,
        required List<Widget> children,
      }) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            ...children.map(
                  (child) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
      ),
    );
  }

  Widget _buildProfileView(BuildContext context) {
    final String name = _nameController.text.trim();
    final String displayName =
    name.isEmpty ? 'Student Name' : name;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 62,
                    backgroundColor: Theme.of(context)
                        .colorScheme
                        .surfaceContainerHighest,
                    backgroundImage: _getProfileImage(),
                    onBackgroundImageError: (_, __) {},
                  ),
                  const SizedBox(height: 16),
                  Text(
                    displayName,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _courseController.text.trim().isEmpty
                        ? 'Student'
                        : _courseController.text.trim(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  if (_schoolController.text.trim().isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text(
                      _schoolController.text.trim(),
                      textAlign: TextAlign.center,
                    ),
                  ],
                  const SizedBox(height: 20),
                  FilledButton.icon(
                    onPressed: _contactMe,
                    icon: const Icon(Icons.mail_outline),
                    label: const Text('Contact Me'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildSectionCard(
            context,
            title: 'Student Details',
            icon: Icons.person_outline,
            children: [
              _buildDetail(
                context,
                Icons.email_outlined,
                'Email',
                _emailController.text,
              ),
              _buildDetail(
                context,
                Icons.phone_outlined,
                'Phone',
                _phoneController.text,
              ),
              _buildDetail(
                context,
                Icons.location_on_outlined,
                'Location',
                _locationController.text,
              ),
              _buildDetail(
                context,
                Icons.school_outlined,
                'Level / Year',
                _levelController.text,
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSectionCard(
            context,
            title: 'About Me',
            icon: Icons.info_outline,
            children: [
              Text(
                _aboutController.text.trim().isEmpty
                    ? 'No description added yet.'
                    : _aboutController.text.trim(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          const SizedBox(height: 24),
          OutlinedButton.icon(
            onPressed: _editProfile,
            icon: const Icon(Icons.edit_outlined),
            label: const Text('Edit Profile'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildDetail(
      BuildContext context,
      IconData icon,
      String label,
      String value,
      ) {
    if (value.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(height: 4),
                SelectableText(
                  value.trim(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
