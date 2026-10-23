
import 'package:flutter/material.dart';

class StudentProfile extends StatefulWidget {
  const StudentProfile({super.key});

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  final nameController = TextEditingController();
  final courseController = TextEditingController();
  final universityController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final locationController = TextEditingController();
  final levelController = TextEditingController();

  final aboutController = TextEditingController(
    text: 'I am a passionate student who enjoys learning new skills, '
        'exploring technology, and solving problems. I am committed '
        'to improving myself and building a successful future.',
  );

  bool showProfile = false;
  bool isDarkMode = false;

  @override
  void dispose() {
    nameController.dispose();
    courseController.dispose();
    universityController.dispose();
    emailController.dispose();
    phoneController.dispose();
    locationController.dispose();
    levelController.dispose();
    aboutController.dispose();
    super.dispose();
  }

  Widget inputField(
      String label,
      IconData icon,
      TextEditingController controller,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: TextField(
        controller: controller,
        maxLines: label == 'About Me' ? 3 : 1,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 12,
          ),
        ),
      ),
    );
  }

  Widget infoCard(String title, String value, IconData icon) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title),
        subtitle: Text(
          value.trim().isEmpty ? 'Not provided' : value.trim(),
        ),
      ),
    );
  }

  void saveProfile() {
    if (nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your name.')),
      );
      return;
    }

    setState(() {
      showProfile = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness:
          isDarkMode ? Brightness.dark : Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My Student Profile'),
          centerTitle: true,
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              tooltip: isDarkMode ? 'Light Mode' : 'Dark Mode',
              icon: Icon(
                isDarkMode ? Icons.light_mode : Icons.dark_mode,
              ),
              onPressed: () {
                setState(() {
                  isDarkMode = !isDarkMode;
                });
              },
            ),
          ],
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (!showProfile) ...[
                    const Text(
                      'Create Your Profile',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),

                    const CircleAvatar(
                      radius: 55,
                      backgroundImage: AssetImage('assets/vv.jpg'),
                    ),
                    const SizedBox(height: 20),

                    inputField(
                      'Full Name',
                      Icons.person,
                      nameController,
                    ),
                    inputField(
                      'Course',
                      Icons.menu_book,
                      courseController,
                    ),
                    inputField(
                      'School / University',
                      Icons.school,
                      universityController,
                    ),
                    inputField(
                      'Email',
                      Icons.email,
                      emailController,
                    ),
                    inputField(
                      'Phone',
                      Icons.phone,
                      phoneController,
                    ),
                    inputField(
                      'Location',
                      Icons.location_on,
                      locationController,
                    ),
                    inputField(
                      'Level',
                      Icons.grade,
                      levelController,
                    ),
                    inputField(
                      'About Me',
                      Icons.info_outline,
                      aboutController,
                    ),
                    const SizedBox(height: 12),

                    ElevatedButton(
                      onPressed: saveProfile,
                      child: const Text('Save Profile'),
                    ),
                  ] else ...[
                    const Center(
                      child: CircleAvatar(
                        radius: 65,
                        backgroundImage: AssetImage('assets/vv.jpg'),
                      ),
                    ),
                    const SizedBox(height: 16),

                    Text(
                      nameController.text.trim(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),

                    Text(
                      courseController.text.trim(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                      ),
                    ),
                    Text(
                      universityController.text.trim(),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),

                    infoCard(
                      'Email',
                      emailController.text,
                      Icons.email,
                    ),
                    infoCard(
                      'Phone',
                      phoneController.text,
                      Icons.phone,
                    ),
                    infoCard(
                      'Location',
                      locationController.text,
                      Icons.location_on,
                    ),
                    infoCard(
                      'Level',
                      levelController.text,
                      Icons.school,
                    ),

                    const SizedBox(height: 16),
                    const Text(
                      'About Me',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),

                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          aboutController.text.trim().isEmpty
                              ? 'No introduction provided yet.'
                              : aboutController.text.trim(),
                          style: const TextStyle(
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          showProfile = false;
                        });
                      },
                      icon: const Icon(Icons.edit),
                      label: const Text('Edit Profile'),
                    ),
                    const SizedBox(height: 8),

                    ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Contact button pressed!'),
                          ),
                        );
                      },
                      child: const Text('Contact Me'),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
