<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true"
    CodeBehind="ListaDoctores.aspx.cs"
    Inherits="GestionHospital.Catalogos.Doctores.ListaDoctores" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
  <div class="row">
    <h3>Lista de Doctores</h3>
    <hr />

    <div class="col-md-12 table-responsive">
      <div class="col-12 mb-2">
        <button class="btn btn-success btn-xs"
                onclick="location.href='AltaDoctores.aspx'; return false;">
          Registrar nuevo doctor
        </button>
      </div>

      <asp:GridView ID="GVDoctores" runat="server"
          AutoGenerateColumns="false"
          CssClass="table table-bordered table-striped mt-3 table-condensed"
          DataKeyNames="IdDoctor"
          OnRowEditing="GVDoctores_RowEditing"
          OnRowUpdating="GVDoctores_RowUpdating"
          OnRowCancelingEdit="GVDoctores_RowCancelingEdit"
          OnRowDeleting="GVDoctores_RowDeleting">
        
        <Columns>
          <asp:BoundField DataField="IdDoctor" HeaderText="ID" ReadOnly="True" />

          <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
          <asp:BoundField DataField="ApellidoPaterno" HeaderText="Apellido Paterno" />
          <asp:BoundField DataField="ApellidoMaterno" HeaderText="Apellido Materno" />
          <asp:BoundField DataField="EspecialidadId" HeaderText="Especialidad (ID)" />
          <asp:BoundField DataField="Telefono" HeaderText="Teléfono" />
          <asp:BoundField DataField="Correo" HeaderText="Correo" />

          <asp:TemplateField HeaderText="Foto">
            <ItemTemplate>
              <asp:Image ID="imgFoto" runat="server"
                ImageUrl='<%# Eval("FotoPerfilRuta") %>'
                Width="50px" Height="50px"
                Visible='<%# !String.IsNullOrEmpty(Eval("FotoPerfilRuta").ToString()) %>' />
            </ItemTemplate>
          </asp:TemplateField>

          <asp:TemplateField HeaderText="Acciones">
            <ItemTemplate>
              <asp:LinkButton runat="server" CommandName="Edit"
                  CssClass="btn btn-sm btn-primary" ToolTip="Editar">
                <i class="fas fa-edit"></i>
              </asp:LinkButton>
              <asp:LinkButton runat="server" CommandName="Delete"
                  CssClass="btn btn-sm btn-danger" ToolTip="Eliminar"
                  OnClientClick="return confirm('¿Eliminar este doctor?');">
                <i class="fas fa-trash-alt"></i>
              </asp:LinkButton>
            </ItemTemplate>
            <EditItemTemplate>
              <asp:LinkButton runat="server" CommandName="Update"
                  CssClass="btn btn-sm btn-success" ToolTip="Guardar">
                <i class="fas fa-save"></i>
              </asp:LinkButton>
              <asp:LinkButton runat="server" CommandName="Cancel"
                  CssClass="btn btn-sm btn-secondary" ToolTip="Cancelar">
                <i class="fas fa-times"></i>
              </asp:LinkButton>
            </EditItemTemplate>
          </asp:TemplateField>
        </Columns>
      </asp:GridView>
    </div>
  </div>
</asp:Content>
