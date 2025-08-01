<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="ListaEspecialidades.aspx.cs"
    Inherits="GestionHospital.Catalogos.Especialidades.ListaEspecialidades" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <h3>Lista de Especialidades</h3>
        <hr />
        <div class="col-md-12 table-responsive">
            <div class="col-12 mb-2">
                <button class="btn btn-success btn-xs"
                    onclick="location.href='AltaEspecialidades.aspx'; return false;">
                    Registrar nueva especialidad
                </button>
            </div>
            <asp:UpdatePanel ID="upEspecialidades" runat="server">
                <ContentTemplate>
                    <div class="row mb-2">
                        <div class="col-md-4">
                            <asp:TextBox ID="txtFiltroNombre" runat="server"
                                CssClass="form-control"
                                placeholder="Buscar especialidad..."></asp:TextBox>
                        </div>
                        <div class="col-md-2">
                            <asp:Button ID="btnBuscar" runat="server"
                                Text="Buscar" CssClass="btn btn-primary"
                                OnClick="btnBuscar_Click" />
                        </div>
                        <div class="col-md-2">
                            <asp:Button ID="btnLimpiar" runat="server"
                                Text="Mostrar Todo" CssClass="btn btn-secondary"
                                OnClick="btnLimpiar_Click" />
                        </div>
                    </div>


                    <asp:GridView ID="GVEspecialidades" runat="server"
                        AutoGenerateColumns="false"
                        CssClass="table table-bordered table-striped mt-3 table-condensed"
                        DataKeyNames="IdEspecialidad"
                        OnRowEditing="GVEspecialidades_RowEditing"
                        OnRowUpdating="GVEspecialidades_RowUpdating"
                        OnRowCancelingEdit="GVEspecialidades_RowCancelingEdit"
                        OnRowDeleting="GVEspecialidades_RowDeleting">

                        <Columns>
                            <asp:BoundField DataField="IdEspecialidad" HeaderText="ID"
                                ReadOnly="True" />

                            <asp:BoundField DataField="NombreEspecialidad"
                                HeaderText="Especialidad" />

                            <asp:TemplateField HeaderText="Acciones">
                                <ItemTemplate>
                                    <asp:LinkButton runat="server" CommandName="Edit"
                                        CssClass="btn btn-sm btn-primary" ToolTip="Editar">
                <i class="fas fa-edit"></i>
                                    </asp:LinkButton>
                                    <asp:LinkButton runat="server" CommandName="Delete"
                                        CssClass="btn btn-sm btn-danger" ToolTip="Eliminar">
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
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>
