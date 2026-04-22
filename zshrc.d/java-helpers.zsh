# Stop the gradle daemon and wipe .gradle/ and build/ dirs up to 5 levels deep
gradle_clean_all() {
  gradle --stop
  find . -name .gradle -type d -maxdepth 5 -not -path "*/node_modules/*" -exec rm -rfv {} +
  find . -name build -type d -maxdepth 5 -not -path "*/node_modules/*" -exec rm -rfv {} +
}

# Remove IntelliJ IDEA project metadata (.idea/ and *.iml)
idea_clean_all() {
  find . -name .idea -type d -maxdepth 5 -not -path "*/node_modules/*" -exec rm -rfv {} +
  find . -name "*.iml" -type f -not -path "*/node_modules/*" -exec rm -rfv {} +
}
