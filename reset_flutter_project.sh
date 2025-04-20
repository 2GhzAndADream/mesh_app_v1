#!/bin/bash

# Nuclear Reset Script for Flutter Projects
# Preserves your lib/, assets/, and pubspec.yaml while regenerating Android/iOS files

# --- Configuration ---
ORG="com.yourdomain"          # Change this to your reverse domain
PROJECT_NAME="mesh_app_v1"    # Your project name
TEMP_DIR="_temp_backup"       # Temporary backup folder

# --- Step 1: Backup Critical Files ---
echo "🚀 Backing up your project..."
mkdir -p $TEMP_DIR
cp -r lib/ $TEMP_DIR/lib/
cp pubspec.yaml $TEMP_DIR/
cp -r assets/ $TEMP_DIR/assets/ 2>/dev/null || true
cp -r web/ $TEMP_DIR/web/ 2>/dev/null || true

# --- Step 2: Nuclear Clean ---
echo "💣 Removing old platform files..."
rm -rf android/
rm -rf ios/
rm -rf .dart_tool/
rm -rf build/

# --- Step 3: Regenerate Project ---
echo "🛠️  Regenerating Flutter project..."
flutter create --platforms android,ios --org $ORG --project-name $PROJECT_NAME .

# --- Step 4: Restore Your Code ---
echo "🔙 Restoring your files..."
cp -r $TEMP_DIR/lib/* lib/
cp $TEMP_DIR/pubspec.yaml .
cp -r $TEMP_DIR/assets/* assets/ 2>/dev/null || true
cp -r $TEMP_DIR/web/* web/ 2>/dev/null || true

# --- Step 5: Cleanup ---
echo "🧹 Cleaning up..."
rm -rf $TEMP_DIR

# --- Step 6: Rebuild ---
echo "🔨 Rebuilding dependencies..."
flutter clean
flutter pub get

echo "✅ Nuclear reset complete! Run: flutter run"