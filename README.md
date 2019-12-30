# Meli
ejercicio practico


/*  MercadoLibre - Examen Mobile Developers

Ejercicio


Con este ejercicio se busca que muestres conocimientos a la hora de crear un proyecto en Android, ver si usas librerías y cómo planteas la solución. ​Es importante que cuando respondas el cuestionario, la respuesta a este ejercicio sea un link a Github, Bitbucket o algún repositorio de código.
MercadoPago posee APIs abiertas a la comunidad para que cualquier desarrollador las consuma y pueda tener pagos en su aplicación. Pero las APIs necesitan de una clave pública para identificar quién es el que está invocando a la API, además de ofrecer customizaciones para esa persona en particular. En este ejercicio, vas a utilizar la siguiente public_key: 444a9ef5-8a6b-429f-abdf-587639155d88​.
Te pedimos que realices una secuencia de pantallas realizando distintos API Calls, dónde el input de la pantalla actual son todos los seleccionados por el usuario en las pantallas anteriores.
A la hora de realizar un pago con tarjeta de crédito, se debe especificar el monto, el medio de pago, el banco y la cantidad de cuotas, además de una identificación segura (token) de la tarjeta con la que se está realizando el pago.
La secuencia de pantalla debe ser:

1. Pantalla de ingreso de monto.

2. Selección de medio de pago​ (de tipo ​credit_card​). Los medios de pago puede ser: Visa,
Mastercard, American Express, etc. ​Mostrar nombre e imagen.​ Para acceder a estos medios de pago, se consulta a la siguiente URL: https://api.mercadopago.com/v1/payment_methods?public_key=PUBLIC_KEY​ (Método GET).

3. Selección de banco​. Los bancos pueden ser: ICBC, Santander, Galicia, entre otros. ​Mostrar nombre e imagen. ​Estos operan con diversos medios de pago de pago, por lo que debes consumir una API para poder saber cuáles son los bancos disponibles para el medio de pago seleccionado. https://api.mercadopago.com/v1/payment_methods/card_issuers?public_key=PUBLIC_KEY &payment_method_id=MEDIO_DE_PAGO_SELECCIONADO​ (Método GET).

4. Selección de cuotas​. Luego de tener el medio de pago y las el banco seleccionados, el usuario debe seleccionar la cantidad de cuotas en las que desea pagar el monto ingresado en el paso 1. La API provee un ​recommended_message​ que resuelve el mensaje que se debe mostrar al usuario con la cantidad de cuotas, el valor de cada cuota y el monto final. ​Mostrar el recommended_message.
    
 https://api.mercadopago.com/v1/payment_methods/installments?public_key=PUBLIC_KEY &amount=MONTO_DEL_PASO_1&payment_method_id=MEDIO_DE_PAGO_SELECCIONADO &issuer.id=ISSUER_SELECCIONADO​ (Método GET).
Utilizar un esquema de callbacks para cada servicio utilizado. Modularizar la llamada para recibir base_url, uri y query_params.
El ejercicio debe volver a la primer pantalla y mostrar un mensaje de alerta con los valores seleccionados en el flujo de pantallas solicitado.
No es necesario realizar ​todo​ el modelo de clases, pero se valorará la calidad de la solución entregada y la profundidad del tema.
Recordá entregar el proyecto en un ​repositorio.​
La resolución del ejercicio es totalmente libre, todo lo que hagas de más va a sumar en tu proceso de selección.
Buena suerte y gracias por tu tiempo!
   */
