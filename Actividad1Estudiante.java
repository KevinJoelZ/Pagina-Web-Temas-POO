import java.util.Scanner;

/**
 * Actividad 1: Clase Estudiante con atributos y constructor
 * Los argumentos son ingresados por el usuario utilizando Scanner
 */
class Estudiante {
    // Atributos de la clase
    String nombre;
    String carrera;
    double promedio;
    
    // Constructor para inicializar los atributos
    Estudiante(String nombre, String carrera, double promedio) {
        this.nombre = nombre;
        this.carrera = carrera;
        this.promedio = promedio;
    }
    
    // Método para mostrar los datos del estudiante
    void mostrarDatos() {
        System.out.println("\n=== Datos del Estudiante ===");
        System.out.println("Nombre: " + nombre);
        System.out.println("Carrera: " + carrera);
        System.out.println("Promedio: " + promedio);
    }
}

public class Actividad1Estudiante {
    public static void main(String[] args) {
        // Crear objeto Scanner para leer datos del usuario
        Scanner sc = new Scanner(System.in);
        
        // Solicitar datos al usuario
        System.out.println("=== Registro de Estudiante ===");
        System.out.print("Ingrese el nombre: ");
        String nombre = sc.nextLine();
        
        System.out.print("Ingrese la carrera: ");
        String carrera = sc.nextLine();
        
        System.out.print("Ingrese el promedio: ");
        double promedio = sc.nextDouble();
        
        // Crear el objeto Estudiante con los datos ingresados
        Estudiante estudiante = new Estudiante(nombre, carrera, promedio);
        
        // Mostrar los datos del estudiante
        estudiante.mostrarDatos();
        
        // Cerrar el Scanner
        sc.close();
    }
}
