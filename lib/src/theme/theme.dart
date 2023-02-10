import "package:flutter/material.dart";

const double defaultRadius = 12;
const double defaultCardRadius = 24;
final BorderRadius defaultBorderRadius = BorderRadius.circular(defaultRadius);
final BorderRadius defaultCardBorderRadius = BorderRadius.circular(defaultCardRadius);
const double dockHeight = 70;

// ignore: long-method
ThemeData mainTheme() => ThemeData(
      fontFamily: "Nunito",
      useMaterial3: false,
      // COLORS
      colorScheme: schemeTwo,
      scaffoldBackgroundColor: schemeTwo.background,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
      // region $Widgets
      sliderTheme: SliderThemeData(
        thumbColor: schemeTwo.outline,
        activeTrackColor: schemeTwo.outline,
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.transparent,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
      ),
      popupMenuTheme: PopupMenuThemeData(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(defaultRadius))),

      chipTheme: ChipThemeData(
        backgroundColor: schemeTwo.surfaceVariant,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(defaultRadius)),
      ),
      dividerTheme: const DividerThemeData(thickness: 2, space: 24, indent: 8, endIndent: 8),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          fixedSize: const MaterialStatePropertyAll(Size(150, 42)),
          splashFactory: InkSparkle.splashFactory,
          shape: MaterialStatePropertyAll<OutlinedBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(defaultRadius)),
          ),
          enableFeedback: false,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          //fixedSize: const MaterialStatePropertyAll(Size(150, 42)),
          splashFactory: InkSparkle.splashFactory,
          foregroundColor: MaterialStateProperty.resolveWith(
            (states) => states.contains(MaterialState.disabled) ? Colors.white12 : Colors.white70,
          ),
          shape: MaterialStateProperty.resolveWith(
            (states) => RoundedRectangleBorder(borderRadius: defaultBorderRadius),
          ),
          enableFeedback: false,
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStatePropertyAll<OutlinedBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(defaultRadius)),
          ),
          enableFeedback: false,
        ),
      ),
      dialogTheme: DialogTheme(
        backgroundColor: schemeTwo.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(defaultRadius)),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        sizeConstraints: const BoxConstraints(minWidth: 52, minHeight: 52),
        extendedSizeConstraints: const BoxConstraints(minHeight: 52),
        backgroundColor: schemeTwo.primary,
        foregroundColor: schemeTwo.onPrimary,
        shape: RoundedRectangleBorder(borderRadius: defaultBorderRadius),
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        color: schemeTwo.background,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(defaultRadius)),
        ),
      ),
      cardTheme: CardTheme(
        color: schemeTwo.surfaceVariant,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: defaultCardBorderRadius,
        ),
      ),

      // DOCK
      bottomAppBarTheme: const BottomAppBarTheme(shape: CircularNotchedRectangle()),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        enableFeedback: true,
        selectedIconTheme: IconThemeData(size: 24),
        unselectedIconTheme: IconThemeData(size: 22),
        selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
        unselectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w200),
        showSelectedLabels: true,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
      ),
      // TOOLTIP
      tooltipTheme: const TooltipThemeData(
        textAlign: TextAlign.left,
        showDuration: Duration(milliseconds: 300),
      ),
      // BOTTOM SHEET
      bottomSheetTheme: BottomSheetThemeData(
        modalBackgroundColor: schemeTwo.surfaceVariant,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(defaultCardRadius)),
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return schemeTwo.secondary;
          }
          return null;
        }),
        trackColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return schemeTwo.secondary;
          }
          return null;
        }),
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(defaultRadius)),
      ).copyWith(
        fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return schemeTwo.secondary;
          }
          return null;
        }),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return schemeTwo.secondary;
          }
          return null;
        }),
      ),
      // endregion
    );

const schemeTwo = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFF5F5F0),
  onPrimary: Color.fromARGB(255, 20, 20, 20),
  primaryContainer: Color(0xFFF5F5F0),
  onPrimaryContainer: Color.fromARGB(255, 20, 20, 20),
  secondary: Color(0xFFF65A74), //Color.fromARGB(255, 214, 116, 25),
  onSecondary: Color(0xFFF5F5F0),
  secondaryContainer: Color.fromARGB(255, 40, 40, 40),
  onSecondaryContainer: Color(0xFFF5F5F0),
  tertiary: Color(0xFFF5F5F0),
  onTertiary: Color.fromARGB(255, 30, 30, 30),
  tertiaryContainer: Color.fromARGB(255, 80, 80, 85),
  onTertiaryContainer: Color(0xFFF5F5F0),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color.fromARGB(255, 15, 15, 20),
  onBackground: Color(0xFFE0E3E2),
  surface: Color.fromARGB(255, 35, 35, 40),
  onSurface: Color(0xFFF5F5F0),
  surfaceVariant: Color.fromARGB(255, 20, 20, 25),
  onSurfaceVariant: Color(0xFFF5F5F0),
  outline: Color.fromARGB(255, 100, 100, 100),
  inverseSurface: Color(0xFFE0E3E2),
  onInverseSurface: Color.fromARGB(255, 25, 20, 20),
  inversePrimary: Color(0xFF56101D),
  shadow: Color.fromARGB(100, 0, 0, 8),
  surfaceTint: Color.fromARGB(255, 53, 43, 43),
);

const schemeOne = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF4CDADA),
  onPrimary: Color(0xFF003737),
  primaryContainer: Color(0xFF004F50),
  onPrimaryContainer: Color(0xFF6FF7F6),
  secondary: Color(0xFFB0CCCB),
  onSecondary: Color(0xFF1B3534),
  secondaryContainer: Color(0xFF324B4B),
  onSecondaryContainer: Color(0xFFCCE8E7),
  tertiary: Color(0xFFB3C8E8),
  onTertiary: Color(0xFF1C314B),
  tertiaryContainer: Color(0xFF334863),
  onTertiaryContainer: Color(0xFFD3E4FF),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF191C1C),
  onBackground: Color(0xFFE0E3E2),
  surface: Color(0xFF191C1C),
  onSurface: Color(0xFFE0E3E2),
  surfaceVariant: Color(0xFF3F4948),
  onSurfaceVariant: Color(0xFFBEC9C8),
  outline: Color(0xFF889392),
  onInverseSurface: Color(0xFF191C1C),
  inverseSurface: Color(0xFFE0E3E2),
  inversePrimary: Color(0xFF006A6A),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF4CDADA),
);
