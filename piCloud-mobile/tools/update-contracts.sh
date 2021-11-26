mkdir -p "lib/contracts"
curl "http://100.106.232.78:8080/api/api" | jq . > "lib/contracts/api.swagger"
flutter pub run build_runner build --delete-conflicting-outputs