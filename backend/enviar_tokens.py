"""Envía una notificación push a una lista de tokens."""

import warnings

import firebase_admin
from firebase_admin import credentials, messaging

# firebase-admin 7 marca "tokens" como deprecado (prefiere "fids"), pero los
# tokens de registro siguen siendo lo que devuelven las apps cliente.
warnings.filterwarnings("ignore", category=DeprecationWarning)

# --- CONFIGURACIÓN ---------------------------------------------------------
SERVICE_ACCOUNT = "serviceAccountKey.json"

TOKENS = [
    "cttwUqeoRPKVO4jAteubsY:APA91bH7VU2-7Lmet7QwVlAWsFqIint5OvHzI5YyOmjWqleGIjDx835wzyrwUPPtCY9gbNQuayOnwGdaWA1uiuQAVB1QELpFqMZzNwocgYbnjHlT2zwkYxc",
]

TITLE = "Hola 👋"
BODY = "Este es tu primer push desde Python"

DATA = {
    "pantalla": "detalle_pedido",
    "pedido_id": "1234",
}
# ---------------------------------------------------------------------------

firebase_admin.initialize_app(credentials.Certificate(SERVICE_ACCOUNT))

respuesta = messaging.send_each_for_multicast(
    messaging.MulticastMessage(
        notification=messaging.Notification(title=TITLE, body=BODY),
        data=DATA,
        tokens=TOKENS,
    )
)

print(f"Enviados: {respuesta.success_count} / Fallidos: {respuesta.failure_count}")

for token, resultado in zip(TOKENS, respuesta.responses):
    estado = "ok" if resultado.success else f"error: {resultado.exception}"
    print(f"  {token[:20]}… -> {estado}")
