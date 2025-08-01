using System;
using System.Collections.Generic;
using System.Data;
using VO;

namespace CapaDatos
{
    public class DalPacientes
    {
        public static List<PacientesVO> ListarPacientes()
        {
            string query = "Pacientes_ObtenerTodos";
            DataSet dsPacientes = MetodoDatos.ExecuteDataSet(query);
            try
            {
                dsPacientes = MetodoDatos.ExecuteDataSet(query);
                if (dsPacientes.Tables[0].Rows.Count > 0)
                {
                    List<PacientesVO> listaPacientes = new List<PacientesVO>();

                    foreach (DataRow dr in dsPacientes.Tables[0].Rows)
                    {
                        PacientesVO paciente = new PacientesVO(dr);
                        listaPacientes.Add(paciente);
                    }
                    return listaPacientes;
                }
                return null;
            }
            catch (Exception ex)
            {
                throw;
            }
        }


        public static PacientesVO ObtenerPacientePorId(int idPaciente)
        {
            try
            {
                string query = "Pacientes_ObtenerPorId";
                DataSet dsPacientes = MetodoDatos.ExecuteDataSet(query, "@IdPaciente", idPaciente);

                if (dsPacientes.Tables[0].Rows.Count > 0)
                {
                    DataRow dr = dsPacientes.Tables[0].Rows[0];
                    PacientesVO paciente = new PacientesVO(dr);
                    return paciente;
                }
                else
                {
                    return null;
                }
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        public static void InsertarPaciente(string nombre, string apellidoPaterno, string apellidoMaterno, DateTime fechaNacimiento, char sexo, string telefono, string correoElectronico, string direccion, string fotoPerfil)
        {
            try
            {
                int result;
                result = MetodoDatos.ExecuteNonQuery("Pacientes_Insertar",
                    "@Nombre", nombre,
                    "@ApellidoPaterno", apellidoPaterno,
                    "@ApellidoMaterno", apellidoMaterno,
                    "@FechaNacimiento", fechaNacimiento,
                    "@Sexo", sexo,
                    "@Telefono", telefono,
                    "@Correo", correoElectronico,
                    "@Direccion", direccion,
                    "@FotoPerfilRuta", fotoPerfil);
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        public static void ActualizarPaciente(int idPaciente, string nombre, string apellidoPaterno, string apellidoMaterno, DateTime? fechaNacimiento, char sexo, string telefono, string correoElectronico, string direccion)
        {
            try
            {
                int result;
                result = MetodoDatos.ExecuteNonQuery("Pacientes_Actualizar",
                    "@IdPaciente", idPaciente,
                    "@Nombre", nombre,
                    "@ApellidoPaterno", apellidoPaterno,
                    "@ApellidoMaterno", apellidoMaterno,
                    "@FechaNacimiento", fechaNacimiento,
                    "@Sexo", sexo,
                    "@Telefono", telefono,
                    "@Correo", correoElectronico,
                    "@Direccion", direccion);
                    //"@FotoPerfilRuta", fotoPerfil);
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        public static void EliminarPaciente(int idPaciente)
        {
            try
            {
                int result;
                result = MetodoDatos.ExecuteNonQuery("Pacientes_Eliminar", "@IdPaciente", idPaciente);
            }
            catch (Exception ex)
            {
                throw;
            }
        }
    }
}
