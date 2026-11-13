# Publicar ParlayLab (solo Android)

## 0. Antes
1. Sube `www/privacy.html` a una URL pública (GitHub Pages / Netlify, gratis). Rellena [FECHA] y [TU CORREO].
2. Sigue el README (instalar, `cap add android`, assets, Google Sign-In).

## 1. Compilar el .aab
1. Android Studio → `npx cap open android`.
2. Build → Generate Signed Bundle / APK → Android App Bundle (.aab) → Create new keystore.
3. GUARDA el keystore y sus contraseñas (sin ellos no podrás actualizar la app).

## 2. Google Play (25 USD, pago único)
1. Cuenta en play.google.com/console + verificación de identidad.
2. Crear app: nombre, idioma, "App", "Gratis".
3. Ficha: `play-store/icon-512.png`, `feature-graphic-1024x500.png`, capturas `phone-*.png`, textos de STORE_LISTING.md.
4. Contenido de la app: URL de privacidad, anuncios (no), público 18+, clasificación IARC, seguridad de datos (nombre y correo por Google), declaración de apuestas.
5. Cuentas personales nuevas: prueba cerrada con ~12 testers durante 14 días antes de Producción (verifica el requisito vigente).
6. Producción → crear versión → subir .aab → enviar a revisión (horas a varios días).

## 3. Otras tiendas (gratis, mismo Android)
- **Samsung Galaxy Store:** seller.samsungapps.com, sube el .aab/.apk.
- **Amazon Appstore:** developer.amazon.com, sube el .apk.
- **Huawei AppGallery:** developer.huawei.com (Google Sign-In no funciona ahí; usa modo invitado).
- **Xiaomi GetApps / APK directo:** puedes compartir el .apk firmado desde tu sitio.
- **PC/web:** publica la carpeta `www/` en Netlify o GitHub Pages.

## Riesgos
Los botones a casas de apuestas y sus logos son lo más delicado en la revisión. Usa logos con permiso o quita esa sección si te rechazan.
