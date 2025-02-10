import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ServicePage extends StatelessWidget {
  const ServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildServiceStep(
              context,
              stepNumber: 1,
              title: "Software Development",
              description: [
                _textSpan(
                  "-Our software development services\n",
                ),
                _textSpan(
                  "-cover solutions for desktop applications, online applications, and database management\n",
                  color: Colors.redAccent,
                  isBold: true,
                ),
                _textSpan(
                  "-supported by all major operating systems.\n",
                  isItalic: true,
                ),
                _textSpan(
                  "-We also specialize in custom software development to meet unique business needs, ensuring optimal performance and scalability.\n",
                  color: Colors.redAccent,
                  isBold: true,
                ),
                _textSpan(
                  "-Our team of experienced developers utilizes the latest technologies to deliver innovative solutions that drive business growth and efficiency.\n",
                  color: Colors.redAccent,
                  isBold: true,
                ),
              ],
              animationPath: "code.json",
              isImageFirst: false,
            ),
            _buildServiceStep(
              context,
              stepNumber: 2,
              title: "Research Implementation",
              description: [
                _textSpan(
                  "-We work hand in hand with our clients to implement research activities ethically and efficiently.\n",
                  color: Colors.redAccent,
                  isBold: true,
                ),
                _textSpan(
                  "-We ensure compliance with Tanzanian laws and client requirements, starting with a pilot study before full implementation.\n",
                ),
                _textSpan(
                  "-Our approach emphasizes budget adherence, flexibility, and quality control through routine evaluations and technology integration.\n",
                ),
                _textSpan(
                  "-Additionally, we assist with pre-research preparations, including IRB applications, COSTECH permits, and informed consent forms in English and Kiswahili.\n",
                ),
              ],
              animationPath: "research.json",
              isImageFirst: true,
            ),
            _buildServiceStep(
              context,
              stepNumber: 3,
              title: "Mobile Application",
              description: [
                _textSpan(
                  "-We develop custom mobile applications\n",
                ),
                _textSpan(
                  "-for both iOS and Android with high performance and security.\n",
                  color: Colors.redAccent,
                  isBold: true,
                ),
                _textSpan(
                  "-Our team pay special attention to clients' technical and non-technical needs, ensuring our mobile applications have friendly user interfaces, high performance, and are secured.\n",
                ),
                _textSpan(
                  "-We also ensure the app meets implementation requirements, for example, data collection in remote areas (without internet access) and usability on low-end mobile devices.\n",
                ),
              ],
              animationPath: "mobile.json",
              isImageFirst: false,
            ),
            _buildServiceStep(
              context,
              stepNumber: 4,
              title: "Data Hosting",
              description: [
                _textSpan(
                  "-We offer dedicated and protected database hosting services on behalf of our clients through cloud solutions.\n",
                  color: Colors.redAccent,
                  isBold: true,
                ),
                _textSpan(
                  "-Mobile devices deployed for data collection through our service will have pre-configurations that allow them to submit data to the hosting server.\n",
                ),
                _textSpan(
                  "-Having employed password protection and access levels, we guarantee that information collected will be protected and only individuals with the right credentials will have access to the data.\n",
                ),
                _textSpan(
                  "-Clients who wish to just use our data hosting services may contact us (support@iact.co.tz) to discuss their requirements in more detail.\n",
                ),
              ],
              animationPath: "tech.json",
              isImageFirst: true,
            ),
            _buildServiceStep(
              context,
              stepNumber: 5,
              title: "Data Analytics",
              description: [
                _textSpan(
                  "-We provide advanced data analytics solutions to transform raw data into valuable insights for decision-making.\n",
                  color: Colors.redAccent,
                  isBold: true,
                ),
                _textSpan(
                  "-We heavily invest in data visualization when providing our clients with key findings from the data -and our clients can be provided with real-time dashboards to easily access the key performance indicators of their interest via a computer and/or a mobile phone.\n",
                ),
                _textSpan(
                  "-Our team has extensive experience working with different data analysis tools – for example, MATLAB, R statistical package, STATA, MS Excel, and SPSS.\n",
                ),
              ],
              animationPath: "stats.json",
              isImageFirst: false,
            ),
            _buildServiceStep(
              context,
              stepNumber: 6,
              title: "Data Collection",
              description: [
                _textSpan(
                  "-Our team ensures secure and efficient data collection through mobile solutions, cloud integration, and advanced reporting.\n",
                  color: Colors.redAccent,
                  isBold: true,
                ),
                _textSpan(
                  "-We provide digital and web-based data collection tools for testing and optimization.\n",
                ),
                _textSpan(
                  "-For field studies, we use the Rahisisha app, an adapted version of ODK, ensuring secure data storage.\n",
                ),
                _textSpan(
                  "-Available on the Google Play Store, Rahisisha supports online/offline data collection, GPS, sound recording, and image capture.\n",
                ),
                _textSpan(
                  "-It’s available in Kiswahili and English, with customization options for iOS based on client needs.\n",
                ),
              ],
              animationPath: "collection.json",
              isImageFirst: true,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildServiceStep(
    BuildContext context, {
    required int stepNumber,
    required String title,
    required List<TextSpan> description,
    required String animationPath,
    required bool isImageFirst,
  }) {
    Widget content = Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: isImageFirst
            ? [
                Lottie.asset(animationPath, height: 250),
                const SizedBox(width: 40),
                _buildTextContent(
                  stepNumber,
                  title,
                  description,
                  context,
                ),
              ]
            : [
                _buildTextContent(
                  stepNumber,
                  title,
                  description,
                  context,
                ),
                const SizedBox(width: 40),
                Lottie.asset(animationPath, height: 250),
              ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: isImageFirst
          ? content
          : Container(
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [Colors.white70, Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 5,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: content,
            ),
    );
  }

  Widget _buildTextContent(int stepNumber, String title,
      List<TextSpan> description, BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      height: 300,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Colors.blueAccent.shade700, Colors.redAccent.shade200],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 5,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: Center(
              child: Text(
                stepNumber.toString(),
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                Text.rich(
                  textAlign: TextAlign.justify,
                  TextSpan(
                    children: description,
                    style: const TextStyle(fontSize: 18, color: Colors.black87),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextSpan _textSpan(String text,
      {bool isBold = false, bool isItalic = false, Color? color}) {
    return TextSpan(
      text: text,
      style: TextStyle(
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
        color: color ?? Colors.black87,
      ),
    );
  }
}
