# 💪 Vida Activa

**Vida Activa** es una aplicación desarrollada en Flutter que permite crear recordatorios personalizados para mantener una rutina activa y saludable.  
Puedes configurar recordatorios únicos o periódicos, asignar días de la semana y recibir notificaciones a una hora específica.

---

## 🧠 Funcionalidades principales

- 🕒 **Creación de recordatorios** para uno o varios días de la semana.  
- 🔁 **Frecuencia configurable:** única, diaria o semanal.  
- 📝 Cada recordatorio contiene:
  - Título  
  - Descripción  
  - Frecuencia  
  - Hora  
  - Días seleccionados  
  - Estado (Pendiente, Completado, Omitido)
- ✏️ **Editar**, 🗑️ **eliminar**, ✅ **completar** u ❌ **omitir** recordatorios.
- 🔍 **Filtrado por estado** de los recordatorios.
- 🌙 **Cambio de tema** (modo claro/oscuro) desde el Drawer lateral.

---

## 🔔 Sistema de notificaciones

Las notificaciones locales permiten interactuar directamente con los recordatorios.  
Actualmente se encuentran operativas, aunque con las siguientes limitaciones conocidas:

1. Al presionar el botón **"Completado"** desde la notificación, la interfaz no se actualiza automáticamente.  
2. No se logró implementar la lógica para que un recordatorio **ya completado vuelva a "Pendiente"** si se ignora una nueva notificación.

---

## 🧩 Arquitectura del proyecto

El proyecto está implementado bajo el patrón **Flutter Clean Architecture**, manteniendo una separación clara de responsabilidades:

| Capa | Descripción |
|------|--------------|
| **app/** | Contiene las vistas, controladores y widgets de la interfaz. |
| **data/** | Gestiona el acceso y persistencia de datos (Firebase y SharedPreferences). |
| **domain/** | Define las entidades, casos de uso y la lógica de negocio principal. |

---

## ⚙️ Tecnologías y herramientas utilizadas

- 🧱 **Flutter** (Framework principal)  
- 💾 **SharedPreferences** (almacenamiento local)  
- ☁️ **Firebase Firestore** (sincronización remota)  
- 🔔 **flutter_local_notifications** (sistema de notificaciones locales)  
- 🧭 **flutter_clean_architecture** (estructura modular del proyecto)  
- 🪪 **uuid** (generación de identificadores únicos)

---

## 🚀 Estado actual

- ✅ Recordatorios funcionales  
- ✅ Notificaciones activas  
- ⚙️ Sincronización local y remota  
- ⚠️ Pendiente: actualización automática de la interfaz tras acciones desde la notificación  
- ⚠️ Pendiente: cambio automático de estado a “Pendiente” si se ignora una notificación

---

