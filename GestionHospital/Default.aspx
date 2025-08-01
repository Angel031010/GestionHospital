<%@ Page Title="Inicio Gestión Hospitalaria" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="GestionHospital._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

  <main>
    <!-- Jumbotron de bienvenida -->
    <div class="jumbotron text-center bg-light py-5 mb-4">
      <h1 class="display-4">Sistema de Gestión Hospitalaria</h1>
      <p class="lead">Administra pacientes, doctores y especialidades de forma sencilla.</p>
    </div>

    <!-- Módulos principales -->
    <div class="row">
      
      <!-- Pacientes -->
      <div class="col-md-4 mb-4">
        <div class="card h-100 text-center">
          <div class="card-body d-flex flex-column">
            <i class="fas fa-user-injured fa-3x mb-3 text-primary"></i>
            <h5 class="card-title">Pacientes</h5>
            <p class="card-text flex-grow-1">Registra y gestiona la información de tus pacientes.</p>
            <a href="/Catalogos/Pacientes/ListaPacientes.aspx" class="btn btn-primary mt-auto">Ir a Pacientes</a>
          </div>
        </div>
      </div>

      <!-- Doctores -->
      <div class="col-md-4 mb-4">
        <div class="card h-100 text-center">
          <div class="card-body d-flex flex-column">
            <i class="fas fa-user-md fa-3x mb-3 text-success"></i>
            <h5 class="card-title">Doctores</h5>
            <p class="card-text flex-grow-1">Administra perfiles y especialidades de los doctores.</p>
            <a href="/Catalogos/Doctores/ListaDoctores.aspx" class="btn btn-success mt-auto">Ir a Doctores</a>
          </div>
        </div>
      </div>

      <!-- Especialidades -->
      <div class="col-md-4 mb-4">
        <div class="card h-100 text-center">
          <div class="card-body d-flex flex-column">
            <i class="fas fa-stethoscope fa-3x mb-3 text-warning"></i>
            <h5 class="card-title">Especialidades</h5>
            <p class="card-text flex-grow-1">Define y edita las especialidades médicas disponibles.</p>
            <a href="/Catalogos/Especialidades/ListaEspecialidades.aspx" class="btn btn-warning mt-auto">Ir a Especialidades</a>
          </div>
        </div>
      </div>

    </div>

    <!-- Segunda fila: reportes y configuración -->
    <div class="row">
      <div class="col-md-6 mb-4">
        <div class="card h-100 text-center">
          <div class="card-body d-flex flex-column">
            <i class="fas fa-chart-bar fa-3x mb-3 text-info"></i>
            <h5 class="card-title">Reportes</h5>
            <p class="card-text flex-grow-1">Genera informes de actividad y estadísticas.</p>
            <a href="/Reportes/Default.aspx" class="btn btn-info mt-auto">Ver Reportes</a>
          </div>
        </div>
      </div>
      <div class="col-md-6 mb-4">
        <div class="card h-100 text-center">
          <div class="card-body d-flex flex-column">
            <i class="fas fa-cogs fa-3x mb-3 text-secondary"></i>
            <h5 class="card-title">Configuración</h5>
            <p class="card-text flex-grow-1">Ajusta parámetros del sistema y usuarios.</p>
            <a href="/Configuracion/Default.aspx" class="btn btn-secondary mt-auto">Configuración</a>
          </div>
        </div>
      </div>
    </div>
  </main>

</asp:Content>
