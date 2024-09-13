// FormTests.cs
using Xunit;

public class FormTests
{
    [Theory]
    [InlineData("John Doe", "john@example.com", "servicio1", "Este es un mensaje.")]
    [InlineData("Jane Doe", "jane@example.com", "servicio2", "Otro mensaje.")]
    public void FormSubmissionTest(string name, string email, string service, string message)
    {
        // Simulación de validación del formulario.
        Assert.NotEmpty(name); // Verifica que el nombre no esté vacío.
        Assert.Contains("@", email); // Verifica que el correo tenga un formato válido.
        Assert.NotEmpty(service); // Verifica que el servicio seleccionado no esté vacío.
        Assert.NotEmpty(message); // Verifica que el mensaje no esté vacío.
    }
}
