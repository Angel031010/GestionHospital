using CapaNegocio;
using GestionHospital.Utils;
using System;
using System.Web.UI.WebControls;

namespace GestionHospital.Catalogos.Pacientes
{
    public partial class ListaPacientes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    RefrescarGrid();
                }
            }
            catch (Exception ex)
            {
                Utils.UtilControls.SweetBox("ERROR!", ex.Message, "danger", this.Page, this.GetType());
            }
        }

        public void RefrescarGrid()
        {
            GVPacientes.DataSource = CapaNegocio.BllPacientes.ListarPacientes();
            GVPacientes.DataBind();
        }

        protected void GVPacientes_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GVPacientes.EditIndex = e.NewEditIndex;
            RefrescarGrid();
        }

        protected void GVPacientes_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            string idPaciente = GVPacientes.DataKeys[e.RowIndex].Values["IdPaciente"].ToString();
            string nombre = e.NewValues["Nombre"].ToString();
            string apellidoPaterno = e.NewValues["ApellidoPaterno"].ToString();
            string apellidomaterno = e.NewValues["ApellidoMaterno"].ToString();
            string fechaNacimiento = e.NewValues["FechaNacimiento"].ToString();
            string sexo = e.NewValues["Sexo"].ToString();
            string telefono = e.NewValues["Telefono"].ToString();
            string correo = e.NewValues["CorreoElectronico"].ToString();
            string direccion = e.NewValues["Direccion"].ToString();
            //string fotoPerfil = e.NewValues["FotoPerfilRuta"].ToString();

            try
            {
                // CapaNegocio.BllPacientes.ActualizarPaciente(...);
                BllPacientes.ActualizarPaciente(int.Parse(idPaciente), nombre, apellidoPaterno, apellidomaterno, DateTime.Parse(fechaNacimiento), char.Parse(sexo), telefono, correo, direccion);

                GVPacientes.EditIndex = -1;
                RefrescarGrid();
                UtilControls.SweetBox("Éxito!", "Paciente actualizado correctamente", "success", this.Page, this.GetType());
            }
            catch (Exception ex)
            {
                Utils.UtilControls.SweetBox("ERROR!", ex.Message, "danger", this.Page, this.GetType());
            }
        }

        protected void GVPacientes_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GVPacientes.EditIndex = -1;
            RefrescarGrid();
        }

        protected void GVPacientes_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string idPaciente = GVPacientes.DataKeys[e.RowIndex].Values["IdPaciente"].ToString();
            try
            {
                string resultado = BllPacientes.EliminarPaciente(int.Parse(idPaciente));

                string titulo = "";
                string clase = "";

                if (resultado == "Paciente eliminado correctamente.")
                {
                    titulo = "Éxito";
                    clase = SweetAlertConstants.Success;

                    UtilControls.SweetBox(titulo, resultado, clase, this.Page, this.GetType());
                    RefrescarGrid();
                }
                else
                {
                    titulo = "Advertencia";
                    clase = SweetAlertConstants.Warning;
                }
            }
            catch (Exception ex)
            {
                UtilControls.SweetBox("ERROR!", ex.Message, SweetAlertConstants.Error, this.Page, this.GetType());
            }
        }


    }
}