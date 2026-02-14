// ============================================================
// SISTEMA DE GESTIÓN DE PAGOS - CLASE PRÁCTICA No. 1
// Demonstración de Polimorfismo en POO
// ============================================================

import java.util.Scanner;

// ============================================================
// 1. INTERFAZ O CLASE ABSTRACTA - MetodoPago
// ============================================================
abstract class MetodoPago {
    protected String titular;
    protected float monto;
    protected String numeroReferencia;
    
    public MetodoPago(String titular, float monto) {
        this.titular = titular;
        this.monto = monto;
        this.numeroReferencia = "";
    }
    
    // Método abstracto que será implementado por cada subclase
    public abstract void procesarPago(float monto);
    
    // Método concreto común a todas las subclases
    public void mostrarInfo() {
        System.out.println("Titular: " + titular);
        System.out.println("Monto: $" + monto);
    }
    
    // Getters y Setters
    public String getTitular() { return titular; }
    public void setTitular(String titular) { this.titular = titular; }
    public float getMonto() { return monto; }
    public void setMonto(float monto) { this.monto = monto; }
    public String getNumeroReferencia() { return numeroReferencia; }
}

// ============================================================
// 2. TRES CLASES CONCRETAS
// ============================================================

// --- Tarjeta de Crédito ---
class TarjetaCredito extends MetodoPago {
    private String numeroTarjeta;
    private String fechaVencimiento;
    private String cvv;
    
    public TarjetaCredito(String titular, float monto, String numeroTarjeta, 
                          String fechaVencimiento, String cvv) {
        super(titular, monto);
        this.numeroTarjeta = numeroTarjeta;
        this.fechaVencimiento = fechaVencimiento;
        this.cvv = cvv;
        this.numeroReferencia = "TC-" + numeroTarjeta.substring(0, 4);
    }
    
    @Override
    public void procesarPago(float monto) {
        System.out.println("\n╔════════════════════════════════════════╗");
        System.out.println("║  PROCESANDO PAGO CON TARJETA CRÉDITO  ║");
        System.out.println("╚════════════════════════════════════════╝");
        System.out.println("• Validando número de tarjeta: " + numeroTarjeta.substring(0, 4) + "****");
        System.out.println("• Verificando fecha de vencimiento: " + fechaVencimiento);
        System.out.println("• Validando código CVV: ***");
        System.out.println("• Autorizando transacción...");
        System.out.println("✓ Pago de $" + monto + " procesado exitosamente");
        System.out.println("• Referencia: " + numeroReferencia);
    }
    
    public void mostrarInfo() {
        super.mostrarInfo();
        System.out.println("Tipo: Tarjeta de Crédito");
        System.out.println("Número: " + numeroTarjeta);
    }
}

// --- PayPal ---
class PayPal extends MetodoPago {
    private String email;
    private String contrasena;
    
    public PayPal(String titular, float monto, String email) {
        super(titular, monto);
        this.email = email;
        this.contrasena = "";
        this.numeroReferencia = "PP-" + System.currentTimeMillis() % 10000;
    }
    
    @Override
    public void procesarPago(float monto) {
        System.out.println("\n╔════════════════════════════════════════╗");
        System.out.println("║       PROCESANDO PAGO CON PAYPAL      ║");
        System.out.println("╚════════════════════════════════════════╝");
        System.out.println("• Conectando al servidor de PayPal...");
        System.out.println("• Autenticando cuenta: " + email);
        System.out.println("• Verificando saldo disponible...");
        System.out.println("• Confirmando transacción...");
        System.out.println("✓ Pago de $" + monto + " procesado exitosamente");
        System.out.println("• Referencia PayPal: " + numeroReferencia);
    }
    
    public void mostrarInfo() {
        super.mostrarInfo();
        System.out.println("Tipo: PayPal");
        System.out.println("Email: " + email);
    }
}

// --- Transferencia Bancaria ---
class TransferenciaBancaria extends MetodoPago {
    private String numeroCuenta;
    private String banco;
    private String tipoTransferencia;
    
    public TransferenciaBancaria(String titular, float monto, String numeroCuenta, 
                                 String banco, String tipoTransferencia) {
        super(titular, monto);
        this.numeroCuenta = numeroCuenta;
        this.banco = banco;
        this.tipoTransferencia = tipoTransferencia;
        this.numeroReferencia = "TB-" + banco.substring(0, 3).toUpperCase() + "-" + 
                                 System.currentTimeMillis() % 100000;
    }
    
    @Override
    public void procesarPago(float monto) {
        System.out.println("\n╔════════════════════════════════════════╗");
        System.out.println("║  PROCESANDO TRANSFERENCIA BANCARIA   ║");
        System.out.println("╚════════════════════════════════════════╝");
        System.out.println("• Banco emisor: " + banco);
        System.out.println("• Número de cuenta: " + numeroCuenta.substring(0, 4) + "****");
        System.out.println("• Tipo: " + tipoTransferencia);
        System.out.println("• Validando cuenta destino...");
        System.out.println("• Ejecutando transferencia...");
        System.out.println("✓ Transferencia de $" + monto + " completada");
        System.out.println("• Referencia: " + numeroReferencia);
    }
    
    public void mostrarInfo() {
        super.mostrarInfo();
        System.out.println("Tipo: Transferencia Bancaria");
        System.out.println("Banco: " + banco);
        System.out.println("Cuenta: " + numeroCuenta);
    }
}

// ============================================================
// 3. CLASE GESTOR PAGOS
// ============================================================
class GestorPagos {
    private String nombreEmpresa;
    
    public GestorPagos(String nombreEmpresa) {
        this.nombreEmpresa = nombreEmpresa;
    }
    
    // Método polimórfico - recibe cualquier tipo de MetodoPago
    public void ejecutarPago(MetodoPago metodo) {
        System.out.println("\n═══════════════════════════════════════════");
        System.out.println("  GESTOR DE PAGOS: " + nombreEmpresa);
        System.out.println("═══════════════════════════════════════════");
        metodo.mostrarInfo();
        metodo.procesarPago(metodo.getMonto());
    }
    
    // Sobrecarga de método para procesar varios pagos
    public void ejecutarPagos(MetodoPago[] metodos) {
        System.out.println("\n╔════════════════════════════════════════╗");
        System.out.println("║    PROCESAMIENTO MASIVO DE PAGOS      ║");
        System.out.println("╚════════════════════════════════════════╝");
        
        float total = 0;
        for (int i = 0; i < metodos.length; i++) {
            System.out.println("\n--- Pago " + (i + 1) + " ---");
            metodos[i].mostrarInfo();
            metodos[i].procesarPago(metodos[i].getMonto());
            total += metodos[i].getMonto();
        }
        
        System.out.println("\n═══════════════════════════════════════════");
        System.out.println("TOTAL PROCESADO: $" + total);
        System.out.println("═══════════════════════════════════════════");
    }
}

// ============================================================
// 4. PRUEBAS DE FUNCIONALIDAD
// ============================================================
class PruebasFuncionales {
    
    public static void pruebaTarjetaCredito() {
        System.out.println("\n🧪 PRUEBA: Tarjeta de Crédito");
        TarjetaCredito tc = new TarjetaCredito("Juan Pérez", 1500.00f, 
                                                "4532123456789012", "12/25", "123");
        tc.procesarPago(tc.getMonto());
        assert tc.getMonto() == 1500.00f : "Error en monto";
        assert tc.getTitular().equals("Juan Pérez") : "Error en titular";
        System.out.println("✓ Prueba exitosa\n");
    }
    
    public static void pruebaPayPal() {
        System.out.println("\n🧪 PRUEBA: PayPal");
        PayPal pp = new PayPal("Maria García", 750.50f, "maria@email.com");
        pp.procesarPago(pp.getMonto());
        assert pp.getMonto() == 750.50f : "Error en monto";
        assert pp.getTitular().equals("Maria García") : "Error en titular";
        System.out.println("✓ Prueba exitosa\n");
    }
    
    public static void pruebaTransferenciaBancaria() {
        System.out.println("\n🧪 PRUEBA: Transferencia Bancaria");
        TransferenciaBancaria tb = new TransferenciaBancaria("Carlos López", 2300.00f, 
                                                              "1234567890", "Banco Nacional", "ACH");
        tb.procesarPago(tb.getMonto());
        assert tb.getMonto() == 2300.00f : "Error en monto";
        assert tb.getTitular().equals("Carlos López") : "Error en titular";
        System.out.println("✓ Prueba exitosa\n");
    }
    
    public static void pruebaPolimorfismo() {
        System.out.println("\n🧪 PRUEBA: Polimorfismo");
        MetodoPago pago1 = new TarjetaCredito("Test1", 100f, "1111", "12/25", "111");
        MetodoPago pago2 = new PayPal("Test2", 200f, "test@test.com");
        MetodoPago pago3 = new TransferenciaBancaria("Test3", 300f, "3333", "Banco Test", "Transfer");
        
        GestorPagos gestor = new GestorPagos("Empresa Test");
        gestor.ejecutarPago(pago1);
        gestor.ejecutarPago(pago2);
        gestor.ejecutarPago(pago3);
        System.out.println("✓ Prueba de polimorfismo exitosa\n");
    }
    
    public static void ejecutarTodasLasPruebas() {
        System.out.println("\n╔════════════════════════════════════════╗");
        System.out.println("║     EJECUTANDO PRUEBAS UNITARIAS      ║");
        System.out.println("╚════════════════════════════════════════╝");
        
        pruebaTarjetaCredito();
        pruebaPayPal();
        pruebaTransferenciaBancaria();
        pruebaPolimorfismo();
        
        System.out.println("╔════════════════════════════════════════╗");
        System.out.println("║     ✓ TODAS LAS PRUEBAS PASARON       ║");
        System.out.println("╚════════════════════════════════════════╝");
    }
}

// ============================================================
// CLASE PRINCIPAL
// ============================================================
public class SistemaPagos {
    
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int opcion;
        
        do {
            System.out.println("\n╔════════════════════════════════════════════════╗");
            System.out.println("║     SISTEMA DE GESTIÓN DE PAGOS - POO        ║");
            System.out.println("╠════════════════════════════════════════════════╣");
            System.out.println("║  1. Procesar pago con Tarjeta de Crédito     ║");
            System.out.println("║  2. Procesar pago con PayPal                 ║");
            System.out.println("║  3. Procesar Transferencia Bancaria          ║");
            System.out.println("║  4. Procesar múltiples pagos                 ║");
            System.out.println("║  5. Ejecutar pruebas unitarias              ║");
            System.out.println("║  0. Salir                                    ║");
            System.out.println("╚════════════════════════════════════════════════╝");
            System.out.print("Seleccione una opción: ");
            
            opcion = scanner.nextInt();
            
            switch(opcion) {
                case 1:
                    TarjetaCredito tc = new TarjetaCredito(
                        "Juan Pérez", 1500.00f, 
                        "4532123456789012", "12/25", "123"
                    );
                    GestorPagos g1 = new GestorPagos("Tienda Online");
                    g1.ejecutarPago(tc);
                    break;
                    
                case 2:
                    PayPal pp = new PayPal("Maria García", 750.50f, "maria@email.com");
                    GestorPagos g2 = new GestorPagos("Servicios Digitales");
                    g2.ejecutarPago(pp);
                    break;
                    
                case 3:
                    TransferenciaBancaria tb = new TransferenciaBancaria(
                        "Carlos López", 2300.00f, 
                        "1234567890", "Banco Nacional", "ACH"
                    );
                    GestorPagos g3 = new GestorPagos("Pagos Empresarial");
                    g3.ejecutarPago(tb);
                    break;
                    
                case 4:
                    MetodoPago[] pagos = {
                        new TarjetaCredito("Cliente 1", 500f, "1111222233334444", "06/26", "111"),
                        new PayPal("Cliente 2", 250.75f, "cliente2@email.com"),
                        new TransferenciaBancaria("Cliente 3", 1000f, "9876543210", "Banco del Pacífico", "TEF")
                    };
                    GestorPagos g4 = new GestorPagos("Lote de Pagos");
                    g4.ejecutarPagos(pagos);
                    break;
                    
                case 5:
                    PruebasFuncionales.ejecutarTodasLasPruebas();
                    break;
                    
                case 0:
                    System.out.println("\n¡Gracias por usar el sistema!");
                    break;
                    
                default:
                    System.out.println("\n⚠ Opción inválida");
            }
            
        } while (opcion != 0);
        
        scanner.close();
    }
}

/*
╔══════════════════════════════════════════════════════════════════════╗
║                    DISEÑO DEL SISTEMA Y JUSTIFICACIÓN                 ║
╠══════════════════════════════════════════════════════════════════════╣
║                                                                      ║
║  DISEÑO:                                                              ║
║  • Clase abstracta MetodoPago: Define la estructura común          ║
║  • Tres subclases concretas: Implementan procesarPago()             ║
║  • Clase GestorPagos: Coordina el procesamiento polimórfico        ║
║                                                                      ║
║  JUSTIFICACIÓN DEL POLIMORFISMO:                                     ║
║  1. Flexibilidad: Un solo método puede處理ar diferentes tipos       ║
║  2. Extensibilidad: Agregar nuevos métodos sin modificar código     ║
║  3. Mantenibilidad: Código limpio y fácil de mantener               ║
║  4. Reutilización: GestorPagos funciona con cualquier método       ║
║                                                                      ║
╚══════════════════════════════════════════════════════════════════════╝
*/
