# flutter_application_1

Frontend aplikacji sklepu internetowego z elektroniką, przygotowany we Flutterze. Projekt pełni rolę klienta dla backendu wdrożonego na Azure i komunikuje się z API przez HTTP.

## O projekcie

Repozytorium zawiera prototyp aplikacji sklepowej z podstawowym przepływem użytkownika:

- logowanie, rejestracja i zmiana nazwy użytkownika,
- wyświetlenie listy kategorii,
- przeglądanie listy produktów w poszczególnych kategoriach,
- podgląd szczegółów produktu,
- dodawanie produktów do koszyka,
- zmiana ilości i usuwanie pozycji z koszyka.

Aplikacja została przygotowana jako warstwa kliencka dla jednego systemu sklepu z elektroniką. Backend działa w Azure Functions i udostępnia endpointy pod ścieżką `/api`.

## Architektura

```text
Flutter app
   ↓ HTTP / JSON
Azure Functions + FastAPI
   ↓
Azure SQL / SQL Server
```

## Stack technologiczny

- Flutter / Dart
- Dio do komunikacji z API
- flutter_secure_storage do przechowywania tokenu JWT
- shared_preferences / http jako zależności pomocnicze

## Główne moduły

```text
lib/
├── models/           # modele danych: kategorie, produkty, koszyk
├── screens/          # ekrany aplikacji
├── widgets/          # wspólne komponenty UI
├── api_config.dart   # adres backendu
├── auth_api.dart     # logowanie, rejestracja, token JWT
├── categories_api.dart
├── products_api.dart
└── cart_api.dart
```

## Kluczowe ekrany

- **LoginScreen** – logowanie użytkownika i przejście do aplikacji.
- **RegistrationScreen** – rejestracja nowego konta.
- **SearchScreen** – lista kategorii.
- **ProductsScreen** – lista produktów dla wybranej kategorii.
- **ProductScreen** – szczegóły produktu i dodanie do koszyka.
- **BasketScreen** – podgląd koszyka i edycja ilości.
- **HomeScreen** – ekran główny projektu.

## Konfiguracja API

Bazowy adres backendu jest ustawiony w pliku `lib/api_config.dart`.

Przykład:

```dart
const String kApiBaseUrl = 'https://...azurewebsites.net/api';
```

Na potrzeby pracy lokalnej można podmienić adres na środowisko developerskie, np. `http://10.0.2.2:7071/api`.

## Uruchomienie lokalne

```bash
flutter pub get
flutter run
```

## Wymagania

- Flutter SDK
- aktywny backend zgodny z endpointami używanymi przez aplikację
- dostęp do internetu lub lokalnego środowiska API

## Przykładowe endpointy używane przez aplikację

- `POST /login`
- `POST /register`
- `GET /categories`
- `GET /products`
- `GET /products/{id}`
- `GET /cart`
- `POST /cart/items/add`
- `POST /cart/items/set`
- `DELETE /cart/items/{product_id}`

## Status projektu

Projekt ma charakter prototypowy i demonstracyjny. Repozytorium pokazuje kompletny przepływ klienta dla sklepu z elektroniką, spięty z backendem opartym o Python, FastAPI, Azure Functions i bazę SQL.
