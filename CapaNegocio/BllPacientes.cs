using CapaDatos;
using System;
using System.Collections.Generic;
using VO;

namespace CapaNegocio
{
    public class BllPacientes
    {
        public static List<PacientesVO> ListarPacientes()
        {
            List<PacientesVO> listaPacientes = new List<PacientesVO>();
            try
            {
                return DalPacientes.ListarPacientes();
            }
            catch (Exception ex)
            {
                return listaPacientes;
            }
        }
        public static PacientesVO ObtenerPacientePorId(int idPaciente)
        {
            try
            {
                return DalPacientes.ObtenerPacientePorId(idPaciente);
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        public static string AgregarPaciente(string nombre, string apellidoPaterno, string apellidoMaterno, DateTime fechaNacimiento, char sexo, string telefono, string correoElectronico, string direccion, string fotoPerfil)
        {
            try
            {
                DalPacientes.InsertarPaciente(nombre, apellidoPaterno, apellidoMaterno, fechaNacimiento, sexo, telefono, correoElectronico, direccion, fotoPerfil);
                return "Paciente agregado correctamente.";
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        public static string ActualizarPaciente(int idPaciente, string nombre, string apellidoPaterno, string apellidoMaterno, DateTime? fechaNacimiento, char sexo, string telefono, string correoElectronico, string direccion)
        {
            try
            {
                List<PacientesVO> listaPacientes = DalPacientes.ListarPacientes();
                bool Existe = false;

                foreach (PacientesVO item in listaPacientes)
                {
                    if (item.IdPaciente == idPaciente)
                    {
                        Existe = true;
                    }
                }

                if (Existe)
                {
                    DalPacientes.ActualizarPaciente(idPaciente, nombre, apellidoPaterno, apellidoMaterno, fechaNacimiento, sexo, telefono, correoElectronico, direccion);
                    return "Paciente actualizado correctamente.";
                }

                else
                {
                    return "El paciente no existe.";
                }
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        public static string EliminarPaciente(int idPaciente)
        {
            try
            {
                PacientesVO paciente = DalPacientes.ObtenerPacientePorId(idPaciente);
                if (paciente == null)
                {
                    return "El paciente no existe.";
                }

                DalPacientes.EliminarPaciente(idPaciente);
                return "Paciente eliminado correctamente.";

            }
            catch (Exception ex)
            {
                throw;
            }
        }
    }
}
