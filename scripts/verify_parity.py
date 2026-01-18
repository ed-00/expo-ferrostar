import os
import re

ANDROID_DIR = "android/src/main/java/expo/modules/ferrostar"
IOS_DIR = "ios"

def get_android_records():
    records = set()
    records_dir = os.path.join(ANDROID_DIR, "records")
    if not os.path.exists(records_dir):
        return records
    for filename in os.listdir(records_dir):
        if filename.endswith(".kt"):
            records.add(filename[:-3]) # Remove .kt
    return records

def get_ios_records():
    records = set()
    records_dir = os.path.join(IOS_DIR, "Records")
    if not os.path.exists(records_dir):
        return records
    for filename in os.listdir(records_dir):
        if filename.endswith(".swift"):
            records.add(filename[:-6]) # Remove .swift
    return records

def get_android_functions():
    functions = set()
    module_file = os.path.join(ANDROID_DIR, "ExpoFerrostarModule.kt")
    if not os.path.exists(module_file):
        return functions
    with open(module_file, 'r') as f:
        content = f.read()
        # Look for AsyncFunction("name")
        matches = re.findall(r'AsyncFunction\("([^"]+)"\)', content)
        functions.update(matches)
        # Look for Events
        events = re.findall(r'Events\(\s*"([^"]+)"', content)
        functions.update([f"Event: {e}" for e in events])
        # Look for Props
        props = re.findall(r'Prop\("([^"]+)"\)', content)
        functions.update([f"Prop: {p}" for p in props])
    return functions

def get_ios_functions():
    functions = set()
    module_file = os.path.join(IOS_DIR, "ExpoFerrostarModule.swift")
    if not os.path.exists(module_file):
        return functions
    with open(module_file, 'r') as f:
        content = f.read()
        matches = re.findall(r'AsyncFunction\("([^"]+)"\)', content)
        functions.update(matches)
        events = re.findall(r'Events\("([^"]+)"\)', content)
        functions.update([f"Event: {e}" for e in events])
        props = re.findall(r'Prop\("([^"]+)"\)', content)
        functions.update([f"Prop: {p}" for p in props])
    return functions

def main():
    print("--- Checking Records ---")
    android_records = get_android_records()
    ios_records = get_ios_records()
    
    missing_records = android_records - ios_records
    if missing_records:
        print(f"Missing iOS Records: {missing_records}")
    else:
        print("All Android records present in iOS.")

    print("\n--- Checking Module Functions/Props ---")
    android_funcs = get_android_functions()
    ios_funcs = get_ios_functions()
    
    missing_funcs = android_funcs - ios_funcs
    if missing_funcs:
        print(f"Missing iOS Functions/Props: {missing_funcs}")
    else:
        print("All Android functions/props present in iOS.")
    
    # Extra check for View props if they are defined in View block but not parsed above
    # The regex above captures Prop calls inside definition(), so it should cover Module definition props.
    # Note: Android typically puts View-specific props inside the View definition in the Module.
    
if __name__ == "__main__":
    main()
