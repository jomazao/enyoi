"""Envía una notificación push a todos los suscritos a un topic."""

import firebase_admin
from firebase_admin import credentials, messaging

# --- CONFIGURACIÓN ---------------------------------------------------------
SERVICE_ACCOUNT = "serviceAccountKey.json"

TOPIC = "noticias"

TITLE = "Novedades 📣"
BODY = "Ya está disponible la nueva versión"

DATA = {
    "pantalla": "novedades",
    "version": "2.0",
}
# ---------------------------------------------------------------------------

firebase_admin.initialize_app(credentials.Certificate(SERVICE_ACCOUNT))

message_id = messaging.send(
    messaging.Message(
        notification=messaging.Notification(title=TITLE, body=BODY),
        data=DATA,
        topic=TOPIC,
    )
)

print(f"Enviado al topic '{TOPIC}'")
print(f"message_id: {message_id}")
