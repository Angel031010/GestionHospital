using CapaNegocio;
using GestionHospital.Utils;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static GestionHospital.Utils.Enumeradores;

namespace GestionHospital.Catalogos.Pacientes
{
    public partial class AltaPacientes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                UtilControls.EnumToListBox(typeof(Genero), ddlSexo, false);

                ddlSexo.SelectedIndex = 0; // Seleccionar el primer elemento por defecto
            }
        }


        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            try
            {
                string nombre = txtNombre.Text.Trim();
                string apellidoPaterno = txtApellidoPaterno.Text.Trim();
                string apellidoMaterno = txtApellidoMaterno.Text.Trim();
                DateTime fechaNacimiento = DateTime.Parse(this.txtFechaNacimiento.Text);
                char sexo = ddlSexo.SelectedValue.FirstOrDefault();
                string telefono = txtTelefono.Text.Trim();
                string correoElectronico = txtCorreo.Text.Trim();
                string direccion = txtDireccion.Text.Trim();
                string fotoPerfil = null;

                string resultado = BllPacientes.AgregarPaciente(
                    nombre, apellidoPaterno, apellidoMaterno,
                    fechaNacimiento, sexo, telefono, correoElectronico, direccion, fotoPerfil);

                if (resultado.Equals("Paciente agregado correctamente.", StringComparison.OrdinalIgnoreCase))
                {
                    UtilControls.SweetBoxConfirm(
                        "Éxito!",
                        "Paciente guardado exitosamente",
                        SweetAlertConstants.Success,
                        "/Catalogos/Pacientes/ListaPacientes.aspx",
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
                UtilControls.SweetBox("ERROR!", ex.Message, SweetAlertConstants.Error, this.Page, this.GetType());
            }
        }


        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            // Redirigir a la lista de pacientes
            UtilControls.SweetBoxConfirm("Cancelar", "Ha cancelado el registro", SweetAlertConstants.Warning, "/Catalogos/Pacientes/ListaPacientes.aspx", this.Page, this.GetType());
        }
    }
}