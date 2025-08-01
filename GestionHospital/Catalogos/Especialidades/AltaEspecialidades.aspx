<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true"
    CodeBehind="AltaEspecialidades.aspx.cs"
    Inherits="GestionHospital.Catalogos.Especialidades.AltaEspecialidades" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
  <div class="container">
    <div class="row">
      <h3>Registro de Especialidad</h3>
      <hr />

      <%-- NOMBRE DE LA ESPECIALIDAD --%>
      <div class="col-md-12">
        <div class="form-group">
          <asp:Label ID="lblNombre" runat="server" Text="Especialidad"></asp:Label>
          <asp:TextBox ID="txtNombreEspecialidad" runat="server"
                       CssClass="form-control" MaxLength="100"
                       placeholder="Nombre de la especialidad" />
          <asp:RequiredFieldValidator ID="rfvNombreEspecialidad"
              ControlToValidate="txtNombreEspecialidad"
              CssClass="text-danger" runat="server"
              ErrorMessage="El nombre de la especialidad es requerido" />
        </div>
      </div>

      <%-- BOTONES DE ACCIÓN --%>
      <div class="col-md-12">
        <div class="form-group">
          <asp:Button ID="btnGuardar" runat="server"
              Text="Guardar" CssClass="btn btn-success"
              OnClick="btnGuardar_Click" />
          <asp:Button ID="btnCancelar" runat="server"
              Text="Cancelar" CssClass="btn btn-secondary"
              OnClick="btnCancelar_Click" CausesValidation="false" />
        </div>
      </div>
    </div>
  </div>
</asp:Content>
