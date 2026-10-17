# Galaga — Videojuego 

## Descripción

Este proyecto consiste en el desarrollo de un videojuego  inspirado en **Galaga**, el clásico juego arcade de disparos espaciales. El jugador controla una nave que debe enfrentarse a formaciones de enemigos, esquivar sus proyectiles y acumular puntos para avanzar en la partida.

El proyecto está desarrollado con **Godot Engine y GDScript**, utilizando escenas y nodos para organizar los diferentes componentes del juego.
**Nota**
El juego cuenta con 4 niveles o stages con una dificultad intermedia,  por decision del equipo se opto  por esta implementacion puesto a que   consideramos que el juego  es algo corto, Acontinuacion presentamos algunas escenas del juego 

- ## **MAIN**
<img width="485" height="631" alt="image" src="https://github.com/user-attachments/assets/5b4a49a0-26d3-4b61-94ba-0176cff18bef" />
<img width="481" height="623" alt="image" src="https://github.com/user-attachments/assets/d22f4eb2-f56a-42b8-a6a8-9ce3c2ba829a" />

- ## **STAGE1**
<img width="492" height="648" alt="image" src="https://github.com/user-attachments/assets/03acd71b-15a6-4d3c-b30d-227e971381aa" />
<img width="494" height="623" alt="image" src="https://github.com/user-attachments/assets/b8d2d985-4b1e-41c5-9734-9d9e889a61b7" />

- ## **STAGE2**
<img width="498" height="631" alt="image" src="https://github.com/user-attachments/assets/9d10cf5d-8763-413e-bbb0-f8ea25f228af" />
<img width="468" height="625" alt="image" src="https://github.com/user-attachments/assets/a7eb86b8-ef1a-476f-a83d-90bfcfda20e5" />

 - ## **STAGE3**
<img width="493" height="636" alt="image" src="https://github.com/user-attachments/assets/547fe796-822f-48f7-af66-66b825cbe23d" />
<img width="492" height="631" alt="image" src="https://github.com/user-attachments/assets/d83014dc-c303-40f6-b2c3-1d0bab32ee79" />

 - ## **STAGE4**
<img width="478" height="631" alt="image" src="https://github.com/user-attachments/assets/2f25da00-0f1c-4ff3-90fb-4e4f188dea85" />
<img width="509" height="630" alt="image" src="https://github.com/user-attachments/assets/15a04509-0011-47af-8df9-cb96d1b9773b" />

## Características

- **Pantalla principal:** presenta el juego y permite iniciar la partida.
- **Formación de enemigos:** generación y organización de enemigos en una formación.
- **Movimientos de ataque:** los enemigos pueden abandonar su formación, ejecutar trayectorias curvas y regresar a su posición.
- **Disparos enemigos:** los enemigos lanzan proyectiles en distintas direcciones, incluyendo trayectorias diagonales y disparos orientados hacia la posición del jugador.
- **Combate:** el jugador puede disparar contra los enemigos y destruirlos.
- **Sistema de puntuación:** se acumulan puntos al eliminar enemigos.
- **Sistema de vidas:** el jugador dispone de un número limitado de vidas.
- **Efectos visuales y sonidos:** se incluyen recursos audiovisuales para complementar los eventos del juego.
- **Game Over:** al finalizar la partida, se muestra el estado correspondiente y se permite regresar a la pantalla principal.
- **Organización por etapas:** el proyecto cuenta con escenas separadas para facilitar la implementación e integración de diferentes etapas.
- 

## Tecnologías utilizadas

- **Godot Engine 4:** motor de desarrollo del videojuego.
- **GDScript:** lenguaje de programación utilizado para implementar la lógica del juego.
- **Git:** sistema de control de versiones.
- **GitHub:** plataforma para alojar el repositorio y gestionar los cambios del proyecto.

## Requisitos

Para ejecutar el proyecto se necesita:

- Godot Engine 4, compatible con la versión utilizada para desarrollar el proyecto.
- Los archivos del repositorio, incluyendo las escenas, scripts y recursos gráficos y de sonido.
- Sin Embargo el ropsosiorio cuenta con 2 archivos ejecutable para windows y dristribusiones linux galaga.exe y galaga.x64_86, los cuales se deben descargar justo al archivo gala.pck, los cuales permiten ejecutar el juegos sin necesidad de instalar godot, mas delente se indica e proceso de instalacion de godot si lo  requiere

## Instalación de Godot Engine

Godot Engine es el motor utilizado para desarrollar y ejecutar el videojuego. Para trabajar con el proyecto se recomienda utilizar Godot 4, preferiblemente la misma versión con la que se desarrolló el juego.

**1. Descargar Godot**

Ingresar al sitio web oficial: https://godotengine.org/download/

Seleccionar el sistema operativo correspondiente.

Descargar la versión estable de Godot 4.

Seguir las instrucciones correspondientes al sistema operativo.

**2. Instalación en Linux**

En Linux, Godot puede ejecutarse mediante el archivo binario oficial, sin necesidad de realizar una instalación tradicional.

Descargar la versión de Godot para Linux desde la página oficial.

Extraer el archivo descargado si viene comprimido.

Dar permisos de ejecución al binario, si es necesario.

Ejecutar Godot y esperar a que aparezca el gestor de proyectos.

Si el archivo descargado se encuentra en la carpeta Descargas, se puede utilizar el administrador de archivos para extraerlo y ejecutarlo.

También es posible utilizar la terminal. Los siguientes comandos son un ejemplo para un archivo que ya haya sido extraído:

```bash
cd ~/Descargas
chmod +x Godot_v4.x-stable_linux.x86_64
./Godot_v4.x-stable_linux.x86_64
```

Nota: el nombre del archivo cambia según la versión descargada. Se debe reemplazar el nombre del ejemplo por el nombre real del ejecutable.

**3. Instalación en Windows y macOS**

Windows: descargar Godot desde la página oficial, extraer el archivo comprimido y ejecutar el archivo .exe.

macOS: descargar la versión correspondiente, abrir el archivo descargado y trasladar Godot a la carpeta de aplicaciones si se desea.

Descargas oficiales: https://godotengine.org/download/

**4. Importar el proyecto**

Una vez abierto Godot Engine:

-Seleccionar la opción Importar en el gestor de proyectos.

-Buscar la carpeta donde se clonó o descargó el repositorio.

-Seleccionar el archivo project.godot.

-Confirmar la importación y esperar a que Godot procese los recursos del proyecto.

-Abrir el proyecto y ejecutar la escena principal para iniciar el videojuego.

-Godot puede generar automáticamente archivos internos de caché e importación durante este proceso. Estos archivos no necesitan descargarse por separado.

**5. Verificar la ejecución**

Para comprobar que la configuración es correcta:

Verificar que el proyecto se abra sin errores de recursos o scripts.

Confirmar que la escena principal esté configurada correctamente.

Ejecutar el proyecto y comprobar que aparezca la pantalla inicial.

Si se presentan errores, se recomienda verificar la versión de Godot utilizada y confirmar que todos los archivos del repositorio se hayan descargado correctamente.

## Instalación y ejecución Galaga

1. Clonar el repositorio:

   ```bash
   git clone https://github.com/arnoldoswaldo/galaga.git 
   git clone https://https://github.com/w15hy/galaga
   ```

2. Ingresar a la carpeta del proyecto:

   ```bash
   cd galaga
   ```

3. Abrir Godot Engine.

4. Seleccionar **Importar** y elegir el archivo `project.godot` ubicado en la carpeta del proyecto.

5. Una vez importado, abrir el proyecto y ejecutar la escena principal con el botón **Ejecutar proyecto**.

> También es posible abrir directamente el archivo `project.godot` desde el gestor de proyectos de Godot.

## Controles

| Tecla | Acción |
|---|---|
| `Enter` | Iniciar la partida desde la pantalla principal |
|  `←` | Mover la nave hacia la izquierda |
|  `→` | Mover la nave hacia la derecha |
| `Espacio` | Disparar |
| `Esc` | Pausar o reanudar la partida |

## Estructura del proyecto

```text
Galaga/
├── assets/          # Recursos gráficos y audiovisuales
├── bullets/         # Escenas y scripts de los proyectiles
├── enemies/         # Lógica y escenas de los enemigos
├── particles/       # Efectos de partículas
├── player/          # Componentes de la nave del jugador
├── scripts/         # Lógica general y control del juego
├── stages/          # Escenas y lógica de las etapas
├── ui/              # Elementos de la interfaz
├── hud.tscn         # Interfaz durante la partida
├── project.godot    # Configuración principal del proyecto
└── README.md        # Documentación del proyecto
```

## Arquitectura general

El proyecto utiliza el sistema de escenas y nodos de Godot para separar responsabilidades:

- **Escena principal:** administra la pantalla inicial y el flujo general de la partida.
- **Etapas:** gestionan la formación de enemigos, sus ataques y el desarrollo de cada nivel.
- **Enemigos:** implementan los estados de entrada, formación, ataque y retorno.
- **Jugador:** gestiona el movimiento, los disparos y las vidas.
- **Proyectiles:** controlan el movimiento y las colisiones de las balas.
- **HUD:** presenta información de la partida, como la puntuación y las vidas.

Esta organización facilita el mantenimiento del código y la integración progresiva de nuevas funcionalidades.

## Control de versiones

El desarrollo se gestiona mediante Git, lo que permite registrar los cambios y mantener el código del proyecto en GitHub.

Repositorio: [github.com/arnoldoswaldo/galaga](https://github.com/arnoldoswaldo/galaga), https://github.com/w15hy/galaga

## Autores

Proyecto académico desarrollado de manera colaborativa por estudiantes del programa de ingieneria de sistemas y computacion,
de la Universida Nacional de Colombia  para el curso de Computacion visual

- **Integrantes:**
- Arnold Oswaldo Acosta
- Yeswah Gonzales Tapia
- Jose Alejandro Ordoñez
- Juan David Peña


## Licencia

Proyecto desarrollado con fines académicos. Los recursos gráficos, sonidos y demás materiales de terceros conservan las licencias y condiciones de uso de sus respectivos autores.
