<div align="center">

<img src="docs/screenshots/splash.png" alt="Inferwise" width="260"/>

# Inferwise

**Learn · Infer · Grow**

App educativa de inglés (nivel B1–B2) para desarrollar la comprensión lectora a través de la inferencia.

![Flutter](https://img.shields.io/badge/Flutter-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?logo=dart&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-FFCA28?logo=firebase&logoColor=black)
![Nivel](https://img.shields.io/badge/Inglés-B1--B2-6c63ff)

</div>

---

## Sobre el proyecto

**Inferwise** es una app educativa de inglés de nivel **B1–B2**, enfocada en la **comprensión lectora mediante el desarrollo de habilidades de inferencia**. A través de textos seleccionados y actividades interactivas, permite a los usuarios:

- Identificar **información implícita**.
- **Deducir significados** a partir del contexto.
- Comprender el **contexto y el mensaje** de un texto en inglés.

Leer no es solo entender lo que está escrito, sino también lo que *no* se dice de forma explícita. Inferwise entrena esa habilidad de manera progresiva y gamificada.

## Capturas de pantalla

<div align="center">

| Biblioteca | Logros | Retos |
|:---:|:---:|:---:|
| <img src="docs/screenshots/library.png" width="220"/> | <img src="docs/screenshots/achievements.png" width="220"/> | <img src="docs/screenshots/challenges.png" width="220"/> |
| Colecciones de lecturas por tipo de inferencia | Perfil, progreso, sellos y medallas | Planetas de retos por tipo de inferencia |

</div>

## Características

- **5 niveles de dificultad** con lecciones de instrucción y animaciones explicativas por nivel.
- **Biblioteca de lecturas** organizada en colecciones (Short / Medium), con cuatro tipos de texto: biografías, cuentos, noticias y artículos.
- **Retos por tipo de inferencia**, cada uno con 4 actividades:
  - Referential (referencial)
  - Lexical (léxica)
  - Explanatory (explicativa)
  - Elaborative / Associative (elaborativa)
  - Predictive (predictiva)
- **Spots de lectura** por color (Blue, Dark Blue, Green, Orange, Purple), cada uno con lecturas y un test final.
- **Autoevaluaciones** por nivel e historial de resultados.
- **Test final** para medir el progreso global.
- **Gamificación**: barra de progreso, sellos (*stamps*) por cada lectura completada y medallas por logros.
- **Cuentas de usuario**: registro, inicio de sesión y gestión de sesión.
- **Perfil personalizable** con nombre e ilustración de avatar.

## Medallas

| Medalla | Medalla |
|---|---|
| Referential Ranger | Lexical Linker |
| Explanation Expert | Associative Architect |
| Prediction Pioneer | Infera Champion |
| Lifetime Teller | News Nexus |
| Narrative Master | Scholar Star |

## Estructura del proyecto

```
inferwise/
├── android/ ios/ web/ windows/ linux/ macos/   # Plataformas de Flutter
├── assets/
│   ├── Articles Stamps/ Biography Stamps/ News Stamps/ Stories Stamps/
│   ├── Banners/  covers/  Medals/  PUZZLES/  Wallpapers/
│   ├── Imagenes de ejemplos/                   # Imágenes por nivel (1–5)
│   └── texts/                                  # Lecturas (.txt)
├── lib/
│   ├── main.dart
│   ├── screens/                                # Login, registro, home, splash, sesión, base de datos
│   ├── Self Assessments/                       # Autoevaluaciones por nivel e historial
│   └── Spots/
│       ├── Achievements/                       # Perfil, sellos y medallas
│       ├── Challenges/                         # Retos y actividades por tipo de inferencia
│       ├── Final-Test/                         # Test final
│       ├── IntuctionSpots/                     # Instrucciones y animaciones (Level 1–5)
│       ├── Library/                            # Biblioteca, lector de textos y quizzes
│       ├── Pathway/                            # Ruta de aprendizaje
│       ├── ReadingSpots/                       # Blue, Dark Blue, Green, Orange, Purple
│       └── Settings/                           # Configuración
├── test/
└── pubspec.yaml
```

## Tecnologías

- [Flutter](https://flutter.dev/) y [Dart](https://dart.dev/)
- [Firebase](https://firebase.google.com/) (configuración en `android/app/google-services.json`)

## Instalación y ejecución

### Requisitos

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (versión estable reciente)
- Android Studio o VS Code con las extensiones de Flutter y Dart
- Un emulador o dispositivo físico

### Pasos

```bash
# 1. Clonar el repositorio
git clone https://github.com/King1962774/Inferwise.git
cd Inferwise

# 2. Instalar dependencias
flutter pub get

# 3. Ejecutar la app
flutter run
```

> Para compilar un APK de Android: `flutter build apk --release`

## Hoja de ruta

- [ ] Más lecturas y colecciones por nivel
- [ ] Más tipos de actividades de inferencia
- [ ] Sincronización de progreso entre dispositivos
- [ ] Versión para iOS publicada

## Créditos

- Textos de lectura: se utilizan obras de dominio público y artículos de divulgación con fines educativos. Los créditos de cada texto pertenecen a sus autores y fuentes originales.
- Ilustraciones, sellos y medallas: diseño propio del proyecto.

## Autor

Desarrollado por **King1962774**.

---

<div align="center">
<sub>Learn · Infer · Grow</sub>
</div>
