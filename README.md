# Biblioteca Arcana

Sistema de gestión de biblioteca (tipo CRUD) desarrollado en Java usando JSP/Servlets, compatible con Eclipse y Tomcat. Permite administrar libros, usuarios, préstamos y devoluciones con soporte para notificaciones por correo electrónico.

## Requisitos

- **JDK:** Java 1.8 (Java 8)
- **IDE recomendado:** Eclipse IDE for Enterprise Java Developers
- **Servidor de aplicaciones:** Apache Tomcat  9.x
- **Base de datos:** MySQL 
- **Librerías externas:**
  - `mysql-connector-j-9.3.0.jar` (conexión MySQL)
  - `javax.mail.jar` (envío de correos electrónicos)

## Estructura del proyecto

Biblioteca3/
├── src/
│ └── main/
│ └── webapp/
│ ├── WEB-INF/
│ │ ├── lib/
│ │ │ ├── javax.mail.jar
│ │ │ └── mysql-connector-j-9.3.0.jar
│ │ └── web.xml
│ ├── *.jsp
│ └── recursos estáticos
├── .metadata/ (solo Eclipse)

## Instalación y Ejecución

1. **Clona el repositorio**
   ```bash
   git clone https://github.com/roberto3101/BibliotecaArcana.git
Importa el proyecto en Eclipse

Abre Eclipse.

Ve a File > Import > Existing Projects into Workspace.

Selecciona la carpeta tantan/Biblioteca3.

Configura Tomcat

Descarga e instala Apache Tomcat 8 o 9.

Añade Tomcat a Eclipse (Servers > New > Server).

Verifica que las librerías externas estén en WEB-INF/lib/.

Configura la base de datos

Crea una base de datos MySQL, por ejemplo biblioteca.

Ajusta la configuración de conexión (usuario, contraseña, URL) en los archivos .java donde se gestione la conexión.

Si tienes un script .sql de la base de datos, impórtalo con tu gestor favorito (Workbench, DBeaver, consola, etc).

Ejecuta la aplicación

Haz clic derecho sobre el proyecto > Run As > Run on Server.

Accede desde el navegador:


http://localhost:8080/Biblioteca3/
Dependencias externas
MySQL Connector/J 9.3.0

JavaMail API

Las dependencias ya están incluidas en el proyecto, dentro de WEB-INF/lib/.

Funcionalidades principales
Gestión de libros, usuarios y préstamos.

Devolución y seguimiento de préstamos.

Notificaciones de eventos por correo electrónico (requiere configuración SMTP).

Panel administrativo y de usuario.

Interfaz web usando JSP.

Notas importantes
Usuario/clave de MySQL: Ajusta en el código según tu entorno local.

JDK: Usar exclusivamente Java 1.8.

Servidor: Tomcat 8 o 9 (configurado en Eclipse).

Correos electrónicos: Si usas funciones de correo, configura correctamente los parámetros SMTP en el código o archivos de propiedades.

Autor
Roberto3101
Repositorio: https://github.com/roberto3101/BibliotecaArcana


