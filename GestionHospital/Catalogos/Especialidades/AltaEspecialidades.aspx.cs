using CapaNegocio;
using GestionHospital.Utils;
using System;
using System.Web.UI;

namespace GestionHospital.Catalogos.Especialidades
{
    public partial class AltaEspecialidades : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            try
            {
                string nombre = txtNombreEspecialidad.Text.Trim();

                string resultado = BllEspecialidades.AgregarEspecialidad(nombre);

                bool exito = resultado.IndexOf(
                    "agregada correctamente", StringComparison.OrdinalIgnoreCase) >= 0;

                if (exito)
                {
                    UtilControls.SweetBoxConfirm(
                        "Éxito!",
                        resultado,
                        SweetAlertConstants.Success,
                        "/Catalogos/Especialidades/ListaEspecialidades.aspx",
                        this.Page,
                        this.GetType());
                }
                else
                {
                    UtilControls.SweetBox(
                        "Atención!",
                        resultado,
                        SweetAlertConstants.Warning,
                        this.Page,
                        this.GetType());
                }
            }
            catch (Exception ex)
            {
                UtilControls.SweetBox(
                    "ERROR!",
                    ex.Message,
                    SweetAlertConstants.Error,
                    this.Page,
                    this.GetType());
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            UtilControls.SweetBoxConfirm(
                "Cancelado",
                "Se ha cancelado el registro de especialidad",
                SweetAlertConstants.Warning,
                "/Catalogos/Especialidades/ListaEspecialidades.aspx",
                this.Page,
                this.GetType());
        }
    }
}
