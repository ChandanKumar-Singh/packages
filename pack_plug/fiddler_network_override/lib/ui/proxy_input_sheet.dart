part of '../fiddler_network_override.dart';

class ProxyInputSheet extends StatefulWidget {
  const ProxyInputSheet({super.key});

  @override
  State<ProxyInputSheet> createState() => _ProxyInputSheetState();
}

class _ProxyInputSheetState extends State<ProxyInputSheet> {
  final _hostController = TextEditingController();
  final _portController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _enabled = false;

  @override
  void initState() {
    super.initState();
    _loadPrevious();
  }

  Future<void> _loadPrevious() async {
    final prefs = await SharedPreferences.getInstance();
    final proxy = prefs.getString(_fiddlerProxyKey);
    final enabled = prefs.getBool(_fiddlerEnableKey) ?? false;

    setState(() {
      _enabled = enabled;
    });

    if (proxy != null) {
      final parts = proxy.split(':');
      if (parts.length == 2) {
        _hostController.text = parts[0];
        _portController.text = parts[1];
      }
    }
  }

  Future<void> _saveAndRestart() async {
    if (!_formKey.currentState!.validate()) return;

    final host = _hostController.text.trim();
    final port = _portController.text.trim();
    final proxy = "$host:$port";

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_fiddlerProxyKey, proxy);
    await prefs.setBool(_fiddlerEnableKey, _enabled);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Proxy saved. Restarting...")),
    );

    Future.delayed(const Duration(milliseconds: 700), () => exit(0));
  }

  String? _validateHost(String? value) {
    final regex = RegExp(r'^((25[0-5]|(2[0-4]|1\d|[1-9]|)\d)\.?\b){4}$');
    if (value == null || value.isEmpty) return "Host is required";
    if (!regex.hasMatch(value.trim())) return "Invalid host format";
    return null;
  }

  String? _validatePort(String? value) {
    if (value == null || value.isEmpty) return "Port is required";
    final port = int.tryParse(value);
    if (port == null || port < 1 || port > 65535) return "Invalid port number";
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Fiddler Proxy Settings",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text("Enable Proxy"),
                    const Spacer(),
                    Switch(
                      value: _enabled,
                      onChanged: (value) => setState(() => _enabled = value),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _hostController,
                  decoration: _inputDecoration("Host (e.g. 192.168.1.9)"),
                  validator: _validateHost,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _portController,
                  keyboardType: TextInputType.number,
                  decoration: _inputDecoration("Port (e.g. 8866)"),
                  validator: _validatePort,
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text("Save & Restart"),
                  onPressed: _saveAndRestart,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
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

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.grey[100],
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blue),
        borderRadius: BorderRadius.circular(10),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
