import java.util.Scanner;

/**
 * Actividad 2: Clase Persona con métodos estáticos para ingresar datos
 * Se utilizan los métodos como argumentos del constructor
 */
class Persona {
    // Atributos de la clase
    String nombre;
    int edad;
    
    // Constructor para inicializar los atributos
    Persona(String nombre, int edad) {
        this.nombre = nombre;
        this.edad = edad;
    }
    
    // Método para mostrar los datos de la persona
    void mostrarDatos() {
        System.out.println("\n=== Datos de la Persona ===");
        System.out.println("Nombre: " + nombre);
        System.out.println("Edad: " + edad + " años");
    }
}

public class Actividad2Persona {
    
    // Método estático para pedir el nombre
    public static String pedirNombre() {
        Scanner sc = new Scanner(System.in);
        System.out.print("Ingrese nombre: ");
        return sc.nextLine();
    }
    
    // Método estático para pedir la edad
    public static int pedirEdad() {
        Scanner sc = new Scanner(System.in);
        System.out.print("Ingrese edad: ");
        return sc.nextInt();
    }
    
    public static void main(String[] args) {
        System.out.println("=== Registro de Persona ===");
        
        // Crear un nuevo objeto utilizando los métodos como argumentos del constructor
        Persona persona = new Persona(pedirNombre(), pedirEdad());
        
        // Mostrar los datos de la persona
        persona.mostrarDatos();
    }
}
