<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true"
    CodeBehind="AltaDoctores.aspx.cs"
    Inherits="GestionHospital.Catalogos.Doctores.AltaDoctores" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
  <div class="container">
    <div class="row">
      <h3>Registro de Doctor</h3>
      <hr />

      <!-- Nombre -->
      <div class="col-md-12">
        <div class="form-group">
          <asp:Label ID="lblNombre" runat="server" Text="Nombre"></asp:Label>
          <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control"
              MaxLength="100" placeholder="Nombre"></asp:TextBox>
          <asp:RequiredFieldValidator ID="rfvNombre" runat="server"
              ControlToValidate="txtNombre" CssClass="text-danger"
              ErrorMessage="El nombre es requerido" />
        </div>
      </div>

      <!-- Apellido Paterno -->
      <div class="col-md-12">
        <div class="form-group">
          <asp:Label ID="lblApellidoPaterno" runat="server" Text="Apellido Paterno"></asp:Label>
          <asp:TextBox ID="txtApellidoPaterno" runat="server" CssClass="form-control"
              MaxLength="100" placeholder="Apellido Paterno"></asp:TextBox>
          <asp:RequiredFieldValidator ID="rfvApellidoPaterno" runat="server"
              ControlToValidate="txtApellidoPaterno" CssClass="text-danger"
              ErrorMessage="El apellido paterno es requerido" />
        </div>
      </div>

      <!-- Apellido Materno -->
      <div class="col-md-12">
        <div class="form-group">
          <asp:Label ID="lblApellidoMaterno" runat="server" Text="Apellido Materno"></asp:Label>
          <asp:TextBox ID="txtApellidoMaterno" runat="server" CssClass="form-control"
              MaxLength="100" placeholder="Apellido Materno"></asp:TextBox>
          <asp:RequiredFieldValidator ID="rfvApellidoMaterno" runat="server"
              ControlToValidate="txtApellidoMaterno" CssClass="text-danger"
              ErrorMessage="El apellido materno es requerido" />
        </div>
      </div>

      <!-- Especialidad -->
      <div class="col-md-12">
        <div class="form-group">
          <asp:Label ID="lblEspecialidad" runat="server" Text="Especialidad"></asp:Label>
          <asp:DropDownList ID="ddlEspecialidad" runat="server" CssClass="form-control"></asp:DropDownList>
          <asp:RequiredFieldValidator ID="rfvEspecialidad" runat="server"
              ControlToValidate="ddlEspecialidad" CssClass="text-danger"
              InitialValue="" ErrorMessage="Seleccione una especialidad" />
        </div>
      </div>

      <!-- Teléfono -->
      <div class="col-md-12">
        <div class="form-group">
          <asp:Label ID="lblTelefono" runat="server" Text="Teléfono"></asp:Label>
          <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control"
              MaxLength="20" placeholder="(999) 999-9999"></asp:TextBox>
          <asp:RequiredFieldValidator ID="rfvTelefono" runat="server"
              ControlToValidate="txtTelefono" CssClass="text-danger"
              ErrorMessage="El teléfono es requerido" />
        </div>
      </div>

      <!-- Correo -->
      <div class="col-md-12">
        <div class="form-group">
          <asp:Label ID="lblCorreo" runat="server" Text="Correo"></asp:Label>
          <asp:TextBox ID="txtCorreo" runat="server" CssClass="form-control"
              MaxLength="100" placeholder="ejemplo@correo.com" TextMode="Email"></asp:TextBox>
          <asp:RequiredFieldValidator ID="rfvCorreo" runat="server"
              ControlToValidate="txtCorreo" CssClass="text-danger"
              ErrorMessage="El correo es requerido" />
          <asp:RegularExpressionValidator ID="revCorreo" runat="server"
              ControlToValidate="txtCorreo" CssClass="text-danger"
              ErrorMessage="Formato de correo inválido"
              ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$" />
        </div>
      </div>

      <!-- Foto de perfil -->
      <div class="col-md-12">
        <div class="form-group">
          <asp:Label ID="lblFoto" runat="server" Text="Foto de Perfil"></asp:Label>
          <asp:FileUpload ID="fuFoto" runat="server" CssClass="form-control" />
        </div>
      </div>

      <!-- Botones -->
      <div class="col-md-12">
        <div class="form-group">
          <asp:Button ID="btnGuardar" runat="server" Text="Guardar"
              CssClass="btn btn-success" OnClick="btnGuardar_Click" />
          <asp:Button ID="btnCancelar" runat="server" Text="Cancelar"
              CssClass="btn btn-secondary"
              OnClick="btnCancelar_Click" CausesValidation="false" />
        </div>
      </div>
    </div>
  </div>
</asp:Content>
