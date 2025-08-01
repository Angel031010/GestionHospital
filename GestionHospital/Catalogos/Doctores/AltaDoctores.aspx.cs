using CapaNegocio;
using GestionHospital.Utils;
using System;
using System.IO;
using System.Web.UI;

namespace GestionHospital.Catalogos.Doctores
{
    public partial class AltaDoctores : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Cargar dropdown de especialidades
                ddlEspecialidad.DataSource = BllEspecialidades.ListarEspecialidades();
                ddlEspecialidad.DataTextField = "NombreEspecialidad";
                ddlEspecialidad.DataValueField = "IdEspecialidad";
                ddlEspecialidad.DataBind();
                ddlEspecialidad.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Seleccione--", ""));
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            try
            {
                // Leer campos
                string nombre = txtNombre.Text.Trim();
                string apPat = txtApellidoPaterno.Text.Trim();
                string apMat = txtApellidoMaterno.Text.Trim();
                int especialidadId = int.Parse(ddlEspecialidad.SelectedValue);
                string telefono = txtTelefono.Text.Trim();
                string correo = txtCorreo.Text.Trim();

                // Manejar carga de foto (opcional)
                string fotoRuta = null;
                if (fuFoto.HasFile)
                {
                    string nombreArchivo = Path.GetFileName(fuFoto.FileName);
                    string carpeta = Server.MapPath("~/Uploads/Doctores/");
                    if (!Directory.Exists(carpeta))
                        Directory.CreateDirectory(carpeta);
                    fuFoto.SaveAs(Path.Combine(carpeta, nombreArchivo));
                    fotoRuta = "/Uploads/Doctores/" + nombreArchivo;
                }

                // Insertar
                string resultado = BllDoctores.AgregarDoctor(
                    nombre, apPat, apMat,
                    especialidadId, telefono, correo, fotoRuta);

                bool exito = resultado
                    .IndexOf("agregado correctamente", StringComparison.OrdinalIgnoreCase) >= 0;

                if (exito)
                {
                    UtilControls.SweetBoxConfirm(
                        "Éxito!",
                        resultado,
                        SweetAlertConstants.Success,
                        "/Catalogos/Doctores/ListaDoctores.aspx",
                        this.Page, this.GetType());
                }
                else
                {
                    UtilControls.SweetBox(
                        "Atención!",
                        resultado,
                        SweetAlertConstants.Warning,
                        this.Page, this.GetType());
                }
            }
            catch (Exception ex)
            {
                UtilControls.SweetBox(
                    "ERROR!",
                    ex.Message,
                    SweetAlertConstants.Error,
                    this.Page, this.GetType());
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            UtilControls.SweetBoxConfirm(
                "Cancelado",
                "Se ha cancelado el registro de doctor",
                SweetAlertConstants.Warning,
                "/Catalogos/Doctores/ListaDoctores.aspx",
                this.Page, this.GetType());
        }
    }
}
