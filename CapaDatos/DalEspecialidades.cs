using System;
using System.Collections.Generic;
using System.Data;
using VO;

namespace CapaDatos
{
    public class DalEspecialidades
    {
        public static List<EspecialidadesVO> ListarEspecialidades()
        {
            string sp = "Especialidades_ObtenerTodos";
            DataSet ds = MetodoDatos.ExecuteDataSet(sp);

            if (ds?.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                var lista = new List<EspecialidadesVO>();
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    lista.Add(new EspecialidadesVO(dr));
                }
                return lista;
            }
            return new List<EspecialidadesVO>();
        }

        public static EspecialidadesVO ObtenerEspecialidadPorId(int idEspecialidad)
        {
            string sp = "Especialidades_ObtenerPorId";
            DataSet ds = MetodoDatos.ExecuteDataSet(sp, "@IdEspecialidad", idEspecialidad);

            if (ds?.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                return new EspecialidadesVO(ds.Tables[0].Rows[0]);

            return null;
        }

        public static void InsertarEspecialidad(string nombreEspecialidad)
        {
            string sp = "Especialidades_Insertar";
            MetodoDatos.ExecuteNonQuery(sp,
                "@NombreEspecialidad", nombreEspecialidad);
        }

        public static void ActualizarEspecialidad(int idEspecialidad, string nombreEspecialidad)
        {
            string sp = "Especialidades_Actualizar";
            MetodoDatos.ExecuteNonQuery(sp,
                "@IdEspecialidad", idEspecialidad,
                "@NombreEspecialidad", nombreEspecialidad);
        }

        public static void EliminarEspecialidad(int idEspecialidad)
        {
            string sp = "Especialidades_Eliminar";
            MetodoDatos.ExecuteNonQuery(sp,
                "@IdEspecialidad", idEspecialidad);
        }

        public static List<EspecialidadesVO> BuscarEspecialidadesPorNombre(string texto)
        {
            string sp = "Especialidades_BuscarPorNombre";
            DataSet ds = MetodoDatos.ExecuteDataSet(sp,
                "@TextoBusqueda", texto);

            var lista = new List<EspecialidadesVO>();
            if (ds?.Tables.Count > 0)
            {
                foreach (DataRow dr in ds.Tables[0].Rows)
                    lista.Add(new EspecialidadesVO(dr));
            }
            return lista;
        }
    }
}
