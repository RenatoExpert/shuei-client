#	=======================================
#	 USE THESE COMMANDS ON PROJECT'S ROOT!
#	=======================================

#	Its the commands I use to generate new Icons
#	First I generate an png from svg using cairo
cairosvg -f png --output-width 500 --output-height 500 -o assets/icon/icon.png assets/icon/icon.svg
#	Then use flutter_laucher_icons to generate the rest
flutter pub run flutter_launcher_icons:main
