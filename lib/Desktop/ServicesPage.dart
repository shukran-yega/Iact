import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ServicePage extends StatelessWidget {
  const ServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildServiceStep(
                stepNumber: 1,
                title: "Software Development",
                description: [
                  _textSpan(
                    "Our software development services ",
                  ),
                  _textSpan(
                      "cover solutions for desktop applications, online applications, and database management ",
                      color: Colors.redAccent,
                      isBold: true),
                  _textSpan("supported by all major operating systems. ",
                      isItalic: true),
                ],
                animationPath: "code.json",
                isImageFirst: false,
              ),
              _buildServiceStep(
                stepNumber: 2,
                title: "Research Implementation",
                description: [
                  _textSpan(
                    "We work hand in hand ",
                  ),
                  _textSpan(
                      "with our clients to implement research activities ethically and efficiently.",
                      color: Colors.redAccent,
                      isBold: true),
                  _textSpan(
                      "that complies with all applicable laws in Tanzania and from the client side. Our implementation strategy includes a small pilot study to test and validate tools followed by the actual field implementation. Throughout implementation, we closely monitor finances to make sure the project is implemented according to the budget"
                      "We pride ourselves on our flexibility to field dynamic changes while not compromising the quality of our work. The entire research implementation phase is surrounded by quality control initiatives through routine evaluation and verification of each major step. We also employ technologies to help streamline our processes."
                      "We also support preparation prior to research implementation including but not limited to supporting client’s IRB application materials and/or obtaining COSTECH’s research permit. Our team will also review and/or prepare informed consent forms, in both English and Kiswahili, and ensure that official letters required to introduce field enumerators are obtained through appropriate channels.")
                ],
                animationPath: "research.json",
                isImageFirst: true,
              ),
              _buildServiceStep(
                stepNumber: 3,
                title: "Mobile Application",
                description: [
                  _textSpan(
                    "We develop custom mobile applications ",
                  ),
                  _textSpan(
                      "for both iOS and Android with high performance and security.",
                      color: Colors.redAccent,
                      isBold: true),
                  _textSpan(
                      " Our team pay special attention to clients technical and non-technical needs ensuring our mobile applications have friendly user interfaces, high performance and secured, we also ensure the app meets implementation required for example data collection in remote areas (without internet access) and usability on low-end mobile devices")
                ],
                animationPath: "mobile.json",
                isImageFirst: false,
              ),
              _buildServiceStep(
                stepNumber: 4,
                title: "Data Hosting",
                description: [
                  _textSpan(
                      "We offer dedicated and protected database hosting services on behalf of our clients through cloud solutions.",
                      color: Colors.redAccent,
                      isBold: true),
                  _textSpan(
                      "Mobile devices deployed for data collection through our service will have pre-configurations that allow them to submit data to the hosting server. Having employed password protected and access levels, we guarantee that information collected will be protected and only individuals with right credentials will have access to the data.Clients who wishes to just use our data hosting services may contact us (support@iact.co.tz) to discuss their requirement in more details")
                ],
                animationPath: "tech.json",
                isImageFirst: true,
              ),
              _buildServiceStep(
                stepNumber: 5,
                title: "Data Analytics",
                description: [
                  _textSpan(
                      "We provide advanced data analytics solutions to transform raw data into valuable insights for decision-making.",
                      color: Colors.redAccent,
                      isBold: true),
                  _textSpan(
                      "We heavily invest in data visualization when providing our clients with key findings from the data - and our clients can be provided by real-time dashboards to easily access the key performance indicators of their interest via a computer and/or a mobile phone Our team has extensive experience working with different data analysis tools – for example, MATLABA, R statistical package, STATA, MS Excel, and SPSS.")
                ],
                animationPath: "stats.json",
                isImageFirst: false,
              ),
              _buildServiceStep(
                stepNumber: 6,
                title: "Data Collection",
                description: [
                  _textSpan(
                      "Our team ensures secure and efficient data collection through mobile solutions, cloud integration, and advanced reporting.",
                      color: Colors.redAccent,
                      isBold: true),
                  _textSpan(
                      "We offer digital forms (or web version) of the data collection tools for testing purposes and also imporve overall data tools design. Through the digital web version, our team in collaboration with the client ensure that all the questions, the required work flow are accurately programmed and all the client’s requirements are met. For the actual field study, the team uses the “Rahisisha “app an adapted version of ODK for field data collection with a configuration to store the data in a secured server.Rahisisha App, available in Google Play Store, was configured and is maintained by iAct as an open-source set of tools which help researchers to collect field data. The andoid-based app allows data collection using mobile devices either online or offline with data submission capability to a secured server. The app is configured with other features like GPS cordinates and sound recording as well as capabilities to take and store pictures. The Rahisisha app is currently available in Kiswahili and English. Our team is also capable of developing a customized version to work with IOS depending on our client’s requirements.")
                ],
                animationPath: "collection.json",
                isImageFirst: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceStep({
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: isImageFirst
            ? [
                Expanded(
                  flex: 1,
                  child: Lottie.asset(animationPath, height: 250),
                ),
                const SizedBox(width: 40),
                Expanded(
                  flex: 2,
                  child: _buildTextContent(stepNumber, title, description),
                ),
              ]
            : [
                Expanded(
                  flex: 2,
                  child: _buildTextContent(stepNumber, title, description),
                ),
                const SizedBox(width: 40),
                Expanded(
                  flex: 1,
                  child: Lottie.asset(animationPath, height: 250),
                ),
              ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: isImageFirst
          ? content
          : Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.blueGrey.shade300, width: 1),
              ),
              child: content,
            ),
    );
  }

  Widget _buildTextContent(
      int stepNumber, String title, List<TextSpan> description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blueAccent,
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
              RichText(
                text: TextSpan(
                  children: description,
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ),
            ],
          ),
        ),
      ],
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
