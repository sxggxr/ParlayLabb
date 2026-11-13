# ParlayLab – Android (Google Play y otras tiendas)
Requisitos: Node 20+, Android Studio (sirve en Windows, Mac o Linux).

1. `npm install`
2. `npx cap add android`
3. `npm run assets`  (genera todos los íconos y splash desde assets/)
4. `npx cap sync`
5. `npx cap open android` → compila (ver GUIA_TIENDAS.md)

Cambia `appId` en `capacitor.config.json` por el tuyo (ej. `com.tunombre.parlaylab`).

## Google Sign-In (Android)
1. console.cloud.google.com → Credenciales → pantalla de consentimiento OAuth.
2. Crea un ID de cliente **Web** y otro **Android** (package name + huella SHA-1).
3. Pon el Web en `GOOGLE_WEB_CLIENT_ID` dentro de `www/index.html`.
4. Cuando subas a Play, agrega TAMBIÉN la SHA-1 de "firma de la app de Play" (Play Console → Integridad de la app) como otro cliente Android.
5. Si los IDs están vacíos, la app usa el login de demostración.
Guía del plugin: https://github.com/Cap-go/capacitor-social-login

## Cuentas con correo y contraseña (Supabase)
1. En `www/index.html` rellena `SUPABASE_URL` y `SUPABASE_KEY` (clave pública anon/publishable, nunca la secreta).
2. Supabase → Authentication → Providers → Email: actívalo. Decide si exiges confirmar el correo.
3. Mientras estén vacíos, las cuentas son de demostración y se guardan solo en el dispositivo.
4. Para uso sin internet o en producción, copia la librería a `www/supabase.js` (ver guía) y cambia el <script> al archivo local.
