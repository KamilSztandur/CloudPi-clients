mkdir -p "lib/contracts"
curl "http://100.106.232.78:8080/api/v3/api-docs" | jq . > "lib/contracts/api.swagger"
flutter pub run build_runner build --delete-conflicting-outputs