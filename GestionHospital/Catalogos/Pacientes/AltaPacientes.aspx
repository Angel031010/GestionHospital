<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AltaPacientes.aspx.cs" Inherits="GestionHospital.Catalogos.Pacientes.AltaPacientes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="row">
            <h3>Registro de Paciente</h3>
            <hr />
            <%-- NOMBRE DEL PACIENTE --%>
            <div class="col-md-12">
                <div class="form-group">
                    <asp:Label ID="lblNombres" runat="server" Text="Nombres"></asp:Label>

                    <asp:TextBox ID="txtNombre" runat="server" placeholder="Nombres" MaxLength="100"
                        CssClass="form-control"></asp:TextBox>

                    <asp:RequiredFieldValidator ID="rfvtxtNombre" ControlToValidate="txtNombre"
                        CssClass="text-danger" runat="server"
                        ErrorMessage="El nombre del paciente es requerido"></asp:RequiredFieldValidator>
                </div>
            </div>

            <%-- APELLIDO PATERNO DEL PACIENTE --%>
            <div class="col-md-12">
                <div class="form-group">
                    <asp:Label ID="lblApellidoPaterno" runat="server" Text="Apellido Paterno"></asp:Label>

                    <asp:TextBox ID="txtApellidoPaterno" runat="server" placeholder="Apellido Paterno"
                        MaxLength="100" CssClass="form-control"></asp:TextBox>

                    <asp:RequiredFieldValidator ID="rfvtxtApellidoPaterno" ControlToValidate="txtApellidoPaterno"
                        CssClass="text-danger" runat="server"
                        ErrorMessage="El apellido paterno del paciente es requerido"></asp:RequiredFieldValidator>
                </div>
            </div>

            <%-- APELLIDO MATERNO DEL PACIENTE --%>
            <div class="col-md-12">
                <div class="form-group">
                    <asp:Label ID="lblApellidoMaterno" runat="server" Text="Apellido Materno"></asp:Label>

                    <asp:TextBox ID="txtApellidoMaterno" runat="server" placeholder="Apellido Materno" MaxLength="100" CssClass="form-control"></asp:TextBox>

                    <asp:RequiredFieldValidator ID="rftxtApellidoMaterno" ControlToValidate="txtApellidoMaterno" CssClass="text-danger" runat="server" ErrorMessage="El apellido materno es requerido"></asp:RequiredFieldValidator>
                </div>
            </div>

            <%-- FECHA DE NACIMIENTO DEL PACIENTE --%>
            <div class="col-md-12">
                <div class="form-group">
                    <asp:Label ID="lblFechaNacimiento" runat="server" Text="Fecha de Nacimiento"></asp:Label>

                    <asp:TextBox ID="txtFechaNacimiento" runat="server" TextMode="Date"
                        CssClass="form-control"></asp:TextBox>

                    <asp:RequiredFieldValidator ID="rfvtxtFechaNacimiento" ControlToValidate="txtFechaNacimiento"
                        CssClass="text-danger" runat="server"
                        ErrorMessage="La fecha de nacimiento del paciente es requerida"></asp:RequiredFieldValidator>
                </div>
            </div>

            <%-- SEXO DEL PACIENTE --%>
            <div class="col-md-12">
                <div class="form-group">
                    <asp:Label for="<%ddlSexo.PacienteID%>" ID="lblSexo" runat="server" Text="Sexo"></asp:Label>

                    <asp:DropDownList ID="ddlSexo" runat="server" CssClass="form-control"></asp:DropDownList>

                    <asp:RequiredFieldValidator ID="rfvddlSexo" ControlToValidate="ddlSexo"
                        CssClass="text-danger" runat="server"
                        ErrorMessage="El sexo del paciente es requerido"></asp:RequiredFieldValidator>
                </div>
            </div>

            <%-- TELÉFONO DEL PACIENTE --%>
            <div class="col-md-12">
                <div class="form-group">
                    <asp:Label ID="lblTelefono" runat="server" Text="Teléfono"></asp:Label>

                    <asp:TextBox ID="txtTelefono" runat="server" placeholder="(999) 999-9999" MaxLength="20"
                        CssClass="form-control"></asp:TextBox>

                    <asp:RequiredFieldValidator ID="rfvtxtTelefono" ControlToValidate="txtTelefono"
                        CssClass="text-danger" runat="server"
                        ErrorMessage="El teléfono del paciente es requerido"></asp:RequiredFieldValidator>
                </div>
            </div>

            <%-- CORREO ELECTRÓNICO DEL PACIENTE --%>
            <div class="col-md-12">
                <div class="form-group">
                    <asp:Label ID="lblCorreo" runat="server" Text="Correo Electrónico"></asp:Label>

                    <asp:TextBox ID="txtCorreo" runat="server" placeholder="ejemplo@correo.com" MaxLength="100"
                        CssClass="form-control" TextMode="Email"></asp:TextBox>

                    <asp:RequiredFieldValidator ID="rfvtxtCorreo" ControlToValidate="txtCorreo"
                        CssClass="text-danger" runat="server"
                        ErrorMessage="El correo electrónico del paciente es requerido"></asp:RequiredFieldValidator>

                    <asp:RegularExpressionValidator ID="revCorreo" runat="server"
                        ControlToValidate="txtCorreo"
                        CssClass="text-danger"
                        ErrorMessage="Formato de correo no válido"
                        ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$">
                    </asp:RegularExpressionValidator>
                </div>
            </div>

            <%-- DIRECCIÓN DEL PACIENTE --%>
            <div class="col-md-12">
                <div class="form-group">
                    <asp:Label ID="lblDireccion" runat="server" Text="Dirección"></asp:Label>

                    <asp:TextBox ID="txtDireccion" runat="server" placeholder="Calle, Número, Colonia, Ciudad"
                        MaxLength="200" CssClass="form-control"></asp:TextBox>

                    <asp:RequiredFieldValidator ID="rfvtxtDireccion" ControlToValidate="txtDireccion"
                        CssClass="text-danger" runat="server"
                        ErrorMessage="La dirección del paciente es requerida"></asp:RequiredFieldValidator>
                </div>
            </div>

            <%-- FOTO DEL PACIENTE --%>
          <%--  <div class="col-md-12">
                <div class="form-group">
                    <asp:Label ID="lblFoto" runat="server" Text="Foto del Paciente"></asp:Label>

                    <asp:FileUpload ID="fuFoto" runat="server" CssClass="form-control" />

                    <asp:Image ID="imgFoto" runat="server" Width="150px" Height="150px"
                        CssClass="mt-2" Visible="false" />
                </div>
            </div>--%>

            <%-- BOTONES DE ACCIÓN --%>
            <div class="col-md-12">
                <div class="form-group">
                    <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="btn btn-success"
                        OnClick="btnGuardar_Click" />
                    <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-secondary"
                        OnClick="btnCancelar_Click" CausesValidation="false" />
                </div>
            </div>

        </div>
    </div>
</asp:Content>
