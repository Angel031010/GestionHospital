using CapaNegocio;
using GestionHospital.Utils;
using System;
using System.Web.UI.WebControls;
using VO;

namespace GestionHospital.Catalogos.Especialidades
{
    public partial class ListaEspecialidades : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                RefrescarGrid();
        }

        private void RefrescarGrid()
        {
            GVEspecialidades.DataSource = BllEspecialidades.ListarEspecialidades();
            GVEspecialidades.DataBind();
        }

        protected void GVEspecialidades_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GVEspecialidades.EditIndex = e.NewEditIndex;
            RefrescarGrid();
        }

        protected void GVEspecialidades_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GVEspecialidades.EditIndex = -1;
            RefrescarGrid();
        }

        protected void GVEspecialidades_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            // Obtener clave y nuevo valor
            int id = Convert.ToInt32(GVEspecialidades.DataKeys[e.RowIndex].Value);
            string nuevoNombre = e.NewValues["NombreEspecialidad"]?.ToString();

            try
            {
                var resultado = BllEspecialidades.ActualizarEspecialidad(id, nuevoNombre);

                GVEspecialidades.EditIndex = -1;
                RefrescarGrid();

                bool exito = resultado.IndexOf("actualizada correctamente", StringComparison.OrdinalIgnoreCase) >= 0;
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

        protected void GVEspecialidades_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(GVEspecialidades.DataKeys[e.RowIndex].Value);

            try
            {
                var resultado = BllEspecialidades.EliminarEspecialidad(id);
                RefrescarGrid();

                bool exito = resultado.IndexOf("eliminada correctamente", StringComparison.OrdinalIgnoreCase) >= 0;
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

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            string texto = txtFiltroNombre.Text.Trim();

            // Si el texto está vacío, mostramos todo:
            if (string.IsNullOrEmpty(texto))
            {
                RefrescarGrid();
                return;
            }

            // Llamamos al método de búsqueda en la BLL
            var resultados = BllEspecialidades.BuscarEspecialidades(texto);

            GVEspecialidades.DataSource = resultados;
            GVEspecialidades.DataBind();

            if (resultados.Count == 0)
            {
                UtilControls.SweetBox(
                    "Atención",
                    $"No se encontraron especialidades que contengan: «{texto}»",
                    SweetAlertConstants.Info,
                    this.Page,
                    this.GetType());
            }
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            txtFiltroNombre.Text = string.Empty;
            RefrescarGrid();
        }

    }
}
