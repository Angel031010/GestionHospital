using System;
using System.Collections.Generic;
using CapaDatos;
using VO;

namespace CapaNegocio
{
    public class BllEspecialidades
    {
        public static List<EspecialidadesVO> ListarEspecialidades()
        {
            try
            {
                return DalEspecialidades.ListarEspecialidades();
            }
            catch (Exception)
            {
                return new List<EspecialidadesVO>();
            }
        }

        public static EspecialidadesVO ObtenerEspecialidadPorId(int idEspecialidad)
        {
            try
            {
                return DalEspecialidades.ObtenerEspecialidadPorId(idEspecialidad);
            }
            catch (Exception)
            {
                throw;
            }
        }

        public static string AgregarEspecialidad(string nombreEspecialidad)
        {
            try
            {
                DalEspecialidades.InsertarEspecialidad(nombreEspecialidad);
                return "Especialidad agregada correctamente.";
            }
            catch (Exception ex)
            {
                return "Error al agregar especialidad: " + ex.Message;
            }
        }

        public static string ActualizarEspecialidad(int idEspecialidad, string nombreEspecialidad)
        {
            try
            {
                var existente = DalEspecialidades.ObtenerEspecialidadPorId(idEspecialidad);
                if (existente == null)
                    return "La especialidad no existe.";

                DalEspecialidades.ActualizarEspecialidad(idEspecialidad, nombreEspecialidad);
                return "Especialidad actualizada correctamente.";
            }
            catch (Exception ex)
            {
                return "Error al actualizar especialidad: " + ex.Message;
            }
        }

        public static string EliminarEspecialidad(int idEspecialidad)
        {
            try
            {
                var existente = DalEspecialidades.ObtenerEspecialidadPorId(idEspecialidad);
                if (existente == null)
                    return "La especialidad no existe.";

                DalEspecialidades.EliminarEspecialidad(idEspecialidad);
                return "Especialidad eliminada correctamente.";
            }
            catch (Exception ex)
            {
                return "Error al eliminar especialidad: " + ex.Message;
            }
        }

        public static List<EspecialidadesVO> BuscarEspecialidades(string textoBusqueda)
        {
            try
            {
                return DalEspecialidades.BuscarEspecialidadesPorNombre(textoBusqueda);
            }
            catch (Exception)
            {
                return new List<EspecialidadesVO>();
            }
        }
    }
}
