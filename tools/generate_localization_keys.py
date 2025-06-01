import os
import re
import json
from deep_translator import GoogleTranslator

DART_DIR = "lib"
ASSETS_DIR = "assets/lang"
KEYS_FILE = os.path.join(DART_DIR, "l10n", "localization_keys.dart")
EN_JSON = os.path.join(ASSETS_DIR, "en.json")
AR_JSON = os.path.join(ASSETS_DIR, "ar.json")

def find_all_keys():
    pattern = re.compile(r'LocalizationKeys\.(\w+)\s*\.tr\(\)', re.MULTILINE)
    keys = set()
    for root, _, files in os.walk(DART_DIR):
        for file in files:
            if file.endswith(".dart"):
                path = os.path.join(root, file)
                with open(path, 'r', encoding='utf-8') as f:
                    content = f.read()
                    matches = pattern.findall(content)
                    keys.update(matches)
    return keys

def load_json(file_path):
    if not os.path.exists(file_path):
        return {}
    with open(file_path, 'r', encoding='utf-8') as f:
        return json.load(f)

def write_json(data, path):
    with open(path, "w", encoding="utf-8") as f:
        json.dump(data, f, indent=2, ensure_ascii=False)

def translate_key(key):
    words = re.sub(r'([a-z])([A-Z])', r'\1 \2', key).replace("_", " ")
    english = words.capitalize()
    arabic = GoogleTranslator(source='en', target='ar').translate(english)
    return english, arabic

def update_keys_file(all_keys):
    if not os.path.exists(KEYS_FILE):
        lines = ["class LocalizationKeys {\n"]
    else:
        with open(KEYS_FILE, "r", encoding="utf-8") as f:
            lines = f.readlines()

    existing_keys = set(re.findall(r'static const String (\w+)', ''.join(lines)))
    new_lines = []
    for key in sorted(all_keys):
        if key not in existing_keys:
            new_lines.append(f'  static const String {key} = \'{key}\';\n')

    if new_lines:
        if lines[-1].strip() != "}":
            lines.append("}\n")
        index = lines.index("}\n")
        lines[index:index] = new_lines
        with open(KEYS_FILE, "w", encoding="utf-8") as f:
            f.writelines(lines)
        print(f"📝 Updated {KEYS_FILE}")
    else:
        print("✅ No new keys to add to localization_keys.dart")

def main():
    keys = find_all_keys()
    print(f"🔍 Found {len(keys)} localization keys")

    en_data = load_json(EN_JSON)
    ar_data = load_json(AR_JSON)

    new_keys = keys - en_data.keys()
    if not new_keys:
        print("✅ All keys are already translated")
    else:
        for key in sorted(new_keys):
            en, ar = translate_key(key)
            en_data[key] = en
            ar_data[key] = ar
            print(f"➕ Added key: {key} => EN: {en}, AR: {ar}")

        write_json(en_data, EN_JSON)
        write_json(ar_data, AR_JSON)

        update_keys_file(keys)

if __name__ == "__main__":
    main()
