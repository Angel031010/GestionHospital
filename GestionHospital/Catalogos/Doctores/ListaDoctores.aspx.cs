using System;
using System.Web.UI.WebControls;
using CapaNegocio;
using GestionHospital.Utils;

namespace GestionHospital.Catalogos.Doctores
{
    public partial class ListaDoctores : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                    RefrescarGrid();
            }
            catch (Exception ex)
            {
                UtilControls.SweetBox("ERROR!", ex.Message, SweetAlertConstants.Error, this.Page, this.GetType());
            }
        }

        public void RefrescarGrid()
        {
            GVDoctores.DataSource = BllDoctores.ListarDoctores();
            GVDoctores.DataBind();
        }

        protected void GVDoctores_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GVDoctores.EditIndex = e.NewEditIndex;
            RefrescarGrid();
        }

        protected void GVDoctores_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            // Obtener los valores directamente de e.NewValues
            int id = Convert.ToInt32(GVDoctores.DataKeys[e.RowIndex].Value);
            string nombre = e.NewValues["Nombre"]?.ToString();
            string apellidoPaterno = e.NewValues["ApellidoPaterno"]?.ToString();
            string apellidoMaterno = e.NewValues["ApellidoMaterno"]?.ToString();
            string espIdStr = e.NewValues["EspecialidadId"]?.ToString();
            string telefono = e.NewValues["Telefono"]?.ToString();
            string correo = e.NewValues["Correo"]?.ToString();

            if (!int.TryParse(espIdStr, out int espId))
            {
                UtilControls.SweetBox("ERROR!", "Especialidad inválida", SweetAlertConstants.Warning, this.Page, this.GetType());
                return;
            }

            try
            {
                string resultado = BllDoctores.ActualizarDoctor(
                    id, nombre, apellidoPaterno, apellidoMaterno,
                    espId, telefono, correo, null);

                GVDoctores.EditIndex = -1;
                RefrescarGrid();

                bool exito = resultado.IndexOf("actualizado correctamente", StringComparison.OrdinalIgnoreCase) >= 0;
                UtilControls.SweetBox(
                    exito ? "Éxito!" : "Advertencia",
                    resultado,
                    exito ? SweetAlertConstants.Success : SweetAlertConstants.Warning,
                    this.Page, this.GetType());
            }
            catch (Exception ex)
            {
                UtilControls.SweetBox("ERROR!", ex.Message, SweetAlertConstants.Error, this.Page, this.GetType());
            }
        }

        protected void GVDoctores_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GVDoctores.EditIndex = -1;
            RefrescarGrid();
        }

        protected void GVDoctores_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(GVDoctores.DataKeys[e.RowIndex].Value);
            try
            {
                string resultado = BllDoctores.EliminarDoctor(id);
                RefrescarGrid();

                bool exito = resultado.IndexOf("eliminado correctamente", StringComparison.OrdinalIgnoreCase) >= 0;
                UtilControls.SweetBox(
                    exito ? "Éxito!" : "Advertencia",
                    resultado,
                    exito ? SweetAlertConstants.Success : SweetAlertConstants.Warning,
                    this.Page, this.GetType());
            }
            catch (Exception ex)
            {
                UtilControls.SweetBox("ERROR!", ex.Message, SweetAlertConstants.Error, this.Page, this.GetType());
            }
        }
    }
}
