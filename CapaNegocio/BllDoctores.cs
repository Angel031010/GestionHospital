using System;
using System.Collections.Generic;
using CapaDatos;
using VO;

namespace CapaNegocio
{
    public class BllDoctores
    {
        public static List<DoctorVO> ListarDoctores()
        {
            try
            {
                return DalDoctores.ListarDoctores();
            }
            catch
            {
                return new List<DoctorVO>();
            }
        }

        public static DoctorVO ObtenerDoctorPorId(int idDoctor)
        {
            try
            {
                return DalDoctores.ObtenerDoctorPorId(idDoctor);
            }
            catch
            {
                throw;
            }
        }

        public static string AgregarDoctor(
            string nombre,
            string apellidoPaterno,
            string apellidoMaterno,
            int especialidadId,
            string telefono,
            string correo,
            string fotoPerfilRuta)
        {
            try
            {
                DalDoctores.InsertarDoctor(
                    nombre, apellidoPaterno, apellidoMaterno,
                    especialidadId, telefono, correo, fotoPerfilRuta);
                return "Doctor agregado correctamente.";
            }
            catch (Exception ex)
            {
                return "Error al agregar doctor: " + ex.Message;
            }
        }

        public static string ActualizarDoctor(
            int idDoctor,
            string nombre,
            string apellidoPaterno,
            string apellidoMaterno,
            int especialidadId,
            string telefono,
            string correo,
            string fotoPerfilRuta)
        {
            try
            {
                var existente = DalDoctores.ObtenerDoctorPorId(idDoctor);
                if (existente == null)
                    return "El doctor no existe.";

                DalDoctores.ActualizarDoctor(
                    idDoctor, nombre, apellidoPaterno, apellidoMaterno,
                    especialidadId, telefono, correo, fotoPerfilRuta);
                return "Doctor actualizado correctamente.";
            }
            catch (Exception ex)
            {
                return "Error al actualizar doctor: " + ex.Message;
            }
        }

        public static string EliminarDoctor(int idDoctor)
        {
            try
            {
                var existente = DalDoctores.ObtenerDoctorPorId(idDoctor);
                if (existente == null)
                    return "El doctor no existe.";

                DalDoctores.EliminarDoctor(idDoctor);
                return "Doctor eliminado correctamente.";
            }
            catch (Exception ex)
            {
                return "Error al eliminar doctor: " + ex.Message;
            }
        }
    }
}
