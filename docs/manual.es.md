# Manual de VCore Pulse 2.2

🇧🇷 [Português](manual.pt-BR.md) · 🇺🇸 [English](manual.en.md) · 🇪🇸 **Español** · 🇨🇳 [简体中文](manual.zh-Hans.md) · 🇹🇼 [繁體中文](manual.zh-Hant.md)

**La Memoria Operativa empieza en tu máquina.** Pulse observa los recursos, relaciona cambios, impactos y recuperaciones, y conserva el contexto para entender lo que ocurrió. El sistema operativo cambia; el concepto permanece.

> Edición del 28/09/2026. Presentación de Pulse 2.2. Las descargas 2.2 todavía no están habilitadas. Esta guía prepara el uso de la versión; no certifica plataformas ni anuncia disponibilidad comercial. Consulta la [matriz de plataformas](platforms-2.2.md). Este repositorio contiene documentación pública, no el código privado de los motores.

## 1. Antes de instalar

Cuando se habilite la versión, descarga únicamente desde el [sitio oficial](https://www.voigtcore.com.br/?lang=es#pulse22-manual) o las [releases oficiales](https://github.com/VoigtCore/VCore-PULSE/releases). Comprueba la versión, arquitectura y estado del archivo. Una descarga anterior no se convierte en 2.2 por aparecer junto a este manual.

Windows x64 no equivale a Windows ARM64. Los Mac Intel y Apple Silicon necesitan paquetes distintos. Linux ARM64 es la próxima prioridad de expansión, no una plataforma ya homologada.

## 2. Instalar o actualizar en Windows

1. Cierra Pulse y ejecuta el instalador correspondiente a tu sistema, cuando esté disponible.
2. Usa el mismo usuario de Windows de la instalación anterior: la protección local de la clave está vinculada a ese usuario.
3. Espera a que termine y abre **VCore Pulse 2.2** desde el acceso directo.
4. El panel local se abre en `http://127.0.0.1:4173`. Esta dirección corresponde al equipo que estás utilizando, no a otro ordenador de la red.
5. Comprueba la versión, las mediciones y el historial. Un equipo recién observado necesita tiempo para formar su trayectoria.

No borres los datos ni copies la base de otro equipo para actualizar. Si la instalación se interrumpe, guarda el código y el archivo `install.log` indicado y contacta con soporte. No edites el esquema de la base para eludir una comprobación.

El candidato v11 corrige la identificación de instalaciones antiguas sin manifiesto para los caminos de actualización revisados. El error `UPDATE_INSTALL_SCHEMA_UNKNOWN` sigue bloqueando versiones internas desconocidas; el equipo afectado necesita una nueva prueba.

## 3. Entender el panel

![Panel real de Pulse, captura de referencia de una edición anterior](../screenshots/dashboard.png)

Las imágenes de esta guía son capturas reales publicadas anteriormente. La apariencia de 2.2 puede variar; estas imágenes no demuestran la homologación del nuevo instalador.

- **Salud operativa:** una síntesis del estado observado, con contexto.
- **Respuesta a cambios y recuperación:** cómo reacciona la máquina y vuelve a su comportamiento habitual.
- **Inestabilidad:** variaciones detectadas durante la observación.
- **Historial:** continuidad y antigüedad de la memoria disponible. El tiempo apagado no es observación continua.
- **Procesos y recursos:** CPU, memoria, disco y sensores disponibles en la plataforma.

Una puntuación alta no garantiza ausencia de fallos. Pulse ayuda a interpretar evidencias; no sustituye copias de seguridad, antivirus ni las decisiones del equipo responsable.

## 4. Leer gráficos y trayectoria

![Cronología real de Pulse](../screenshots/timeline.png)

Selecciona el período y relaciona cambios, impactos y recuperaciones. Consulta fechas y turnos para distinguir un episodio aislado de un patrón. Los gráficos muestran la evolución de las mediciones; revisa también el contexto y la disponibilidad de muestras. Sin datos suficientes, una comparación debe indicarse como no disponible.

El historial pertenece a la identidad de esa máquina. Cambiar el idioma no crea otra identidad ni modifica los registros.

## 5. Informes, avisos e idioma

![Informes de Pulse](../screenshots/reports.png)

Elige un período disponible para consultar o generar informes. Pulse 2.2 amplía las comparaciones entre períodos, el resumen ejecutivo y la explicación de los episodios, para conectar el gráfico con lo que ocurrió. Los períodos sin muestras no deben interpretarse como funcionamiento normal.

El envío por correo y Telegram requiere configuración explícita. Confirma el destinatario y consulta el resultado: solicitar un envío no significa que se haya entregado.

La interfaz ofrece **portugués, inglés, español, chino simplificado y chino tradicional**. Selecciona tu idioma en el panel; los datos y la identidad se conservan.

## 6. Evaluación, licencia y pago

Consulta siempre las condiciones del producto. La oferta documentada contempla 10 días de evaluación y Pulse Solo por R$ 79,90 por máquina/mes; verifica el total, período y disponibilidad antes de pagar.

1. Abre **Comprar licencia** o **Renovar licencia**.
2. Completa los datos del comprador y la dirección fiscal; revisa el plan y el período.
3. Selecciona **Pix** para solicitar el QR y el código para copiar y pegar. Confirma el correo cuando se solicite y vuelve a Pulse.
4. Revisa el destinatario y el importe en la aplicación de tu banco antes de pagar.
5. Espera la confirmación o utiliza la opción de verificar el pago. Mostrar un QR no activa por sí solo la licencia.

**Tarjeta:** se completa en el checkout seguro de C6. Pulse no solicita número, vencimiento ni CVV en el panel local.

**¿Empezaste con tarjeta y prefieres Pix?** Usa la acción para cerrar el intento no pagado y elegir Pix. La aplicación espera la confirmación del banco. Un pago aprobado, en procesamiento o con respuesta incierta no autoriza otro cobro automático. Tras el cierre confirmado, revisa los datos y solicita el Pix.

Si recibes la licencia por correo, sigue las instrucciones. Tener acceso al ordenador no concede acceso a la cuenta comercial de otra persona.

## 7. Cerrar, reiniciar y conservar la memoria

Antes de mantenimiento, utiliza la opción de cerrar Pulse. Abre de nuevo el acceso directo para retomar la observación. No borres archivos de base ni termines procesos durante una escritura.

El producto puede organizar períodos antiguos en archivos históricos. No elimines segmentos, registros de control ni material protegido. Un informe exportado no es una copia de seguridad completa. Restaurar o trasladar datos a otro usuario/equipo requiere el procedimiento de soporte y las claves necesarias.

## 8. Linux y macOS

Los candidatos están empaquetados, pero necesitan homologación por plataforma. El adaptador SQLCipher validado en esta entrega es Windows x64; Linux requiere su adaptador nativo y la gestión de claves, y macOS requiere pruebas en Mac. No desactives el cifrado para declarar una instalación aprobada. No sustituyas una instalación operativa por un candidato sin copia y reversión verificadas.

## 9. VLP y próximos pasos

VLP prepara la integración del ecosistema con identidad y permisos. Instalar Pulse no lo conecta automáticamente a VCore Server; cada integración depende de su edición, configuración y validación.

Linux ARM64 tiene prioridad, seguido de Windows ARM64. FreeBSD y los sistemas Unix empresariales son posibilidades futuras condicionadas a la demanda, no soporte disponible.

## 10. Soporte

- Instalación y uso: [suporte@voigtcore.com.br](mailto:suporte@voigtcore.com.br).
- Licencias: [comercial@voigtcore.com.br](mailto:comercial@voigtcore.com.br).
- Integraciones: [engenharia@voigtcore.com.br](mailto:engenharia@voigtcore.com.br).

Indica sistema, arquitectura, versión/build, acción y código de error. No publiques contraseñas, claves, tokens, bases operativas ni datos completos de pago. Revisa los registros antes de compartirlos.
