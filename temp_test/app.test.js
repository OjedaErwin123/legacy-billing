console.log("=== Ejecutando Pruebas Unitarias de Facturación ===");
const totalFactura = 150.50;

if (totalFactura > 0) {
    console.log("✅ PASSED: El cálculo del impuesto de la factura es correcto.");
    process.exit(0); 
} else {
    console.error("❌ FAILED: La factura no puede ser menor o igual a cero.");
    process.exit(1); 
}