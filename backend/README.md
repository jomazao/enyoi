# Push Notifications con Firebase (Python)

Dos scripts para enviar notificaciones push con Firebase Cloud Messaging.
La configuración (tokens, título, cuerpo y data) va **escrita dentro de cada archivo**.

## Preparación

Deja tu service account en la raíz del proyecto como `serviceAccountKey.json`.

```bash
source .venv/bin/activate
```

## Enviar a una lista de tokens

Edita [enviar_tokens.py](enviar_tokens.py) (bloque `CONFIGURACIÓN`) y ejecuta:

```bash
python enviar_tokens.py
```

```python
TOKENS = ["TOKEN_1", "TOKEN_2"]

TITLE = "Hola 👋"
BODY = "Este es tu primer push desde Python"

DATA = {"pantalla": "detalle_pedido", "pedido_id": "1234"}
```

Salida:

```
Enviados: 2 / Fallidos: 0
  eyJhbGciOiJIUzI1NiI… -> ok
  dGVzdCB0b2tlbiBudW0… -> ok
```

## Enviar a un topic

Edita [enviar_topic.py](enviar_topic.py) (bloque `CONFIGURACIÓN`) y ejecuta:

```bash
python enviar_topic.py
```

```python
TOPIC = "noticias"

TITLE = "Novedades 📣"
BODY = "Ya está disponible la nueva versión"

DATA = {"pantalla": "novedades", "version": "2.0"}
```

Salida:

```
Enviado al topic 'noticias'
message_id: projects/mi-proyecto/messages/0:1712345678901234%abcdef
```

## Enviar a un usuario a partir de una venta en Firestore

[enviar_venta.py](enviar_venta.py) lee una venta, saca su usuario, busca el token de
ese usuario y le envía la notificación solo a él.

```bash
python enviar_venta.py
```

Estructura que espera en Firestore:

```
sales/venta_001     ->  { userId: "user_abc", total: 149.99, estado: "pagada" }
users/user_abc      ->  { nombre: "Ana Pérez", fcmToken: "TOKEN_DEL_DISPOSITIVO" }
```

Configuración del script (bloque `CONFIGURACIÓN`):

```python
VENTA_ID = "venta_001"

COLECCION_VENTAS = "sales"
COLECCION_USUARIOS = "users"

CAMPO_USUARIO = "userId"    # campo de la venta que identifica al usuario
CAMPO_TOKEN = "fcmToken"    # campo del usuario donde guardas el token
```

Salida:

```
Venta venta_001: {'userId': 'user_abc', 'total': 149.99, 'estado': 'pagada'}
Usuario user_abc: Ana Pérez
Enviado a user_abc (dGVzdCB0b2tlbiBudW0…)
message_id: projects/mi-proyecto/messages/0:1712345678901234%abcdef
```

`CAMPO_USUARIO` funciona tanto si guardas el id como string (`"user_abc"`) como si
guardas una referencia al documento (`DocumentReference`).

Si el token ya no es válido, el script lo borra del documento del usuario para que no
se quede basura en Firestore.

## Notas

- Los valores de `DATA` deben ser **strings** (es requisito de FCM).
- Máximo 500 tokens por envío en `enviar_tokens.py`.
- `serviceAccountKey.json` está en el `.gitignore`: no lo subas al repo.
- El acceso a Firestore no necesita instalar nada extra: `firebase-admin` ya trae el cliente.
