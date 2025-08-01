using System;
using System.Collections.Generic;
using System.Data;
using VO;

namespace CapaDatos
{
    public class DalDoctores
    {
        public static List<DoctorVO> ListarDoctores()
        {
            string sp = "Doctores_ObtenerTodos";
            DataSet ds = MetodoDatos.ExecuteDataSet(sp);
            var lista = new List<DoctorVO>();

            if (ds?.Tables.Count > 0)
            {
                foreach (DataRow dr in ds.Tables[0].Rows)
                    lista.Add(new DoctorVO(dr));
            }
            return lista;
        }

        public static DoctorVO ObtenerDoctorPorId(int idDoctor)
        {
            string sp = "Doctores_ObtenerPorId";
            DataSet ds = MetodoDatos.ExecuteDataSet(sp, "@IdDoctor", idDoctor);
            if (ds?.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                return new DoctorVO(ds.Tables[0].Rows[0]);
            return null;
        }

        public static void InsertarDoctor(
            string nombre,
            string apellidoPaterno,
            string apellidoMaterno,
            int especialidadId,
            string telefono,
            string correo,
            string fotoPerfilRuta)
        {
            string sp = "Doctores_Insertar";
            MetodoDatos.ExecuteNonQuery(sp,
                "@Nombre", nombre,
                "@ApellidoPaterno", apellidoPaterno,
                "@ApellidoMaterno", apellidoMaterno,
                "@EspecialidadId", especialidadId,
                "@Telefono", telefono,
                "@Correo", correo,
                "@FotoPerfilRuta", fotoPerfilRuta);
        }

        public static void ActualizarDoctor(
            int idDoctor,
            string nombre,
            string apellidoPaterno,
            string apellidoMaterno,
            int? especialidadId,
            string telefono,
            string correo,
            string fotoPerfilRuta)
        {
            string sp = "Doctores_Actualizar";
            MetodoDatos.ExecuteNonQuery(sp,
                "@IdDoctor", idDoctor,
                "@Nombre", nombre,
                "@ApellidoPaterno", apellidoPaterno,
                "@ApellidoMaterno", apellidoMaterno,
                "@EspecialidadId", especialidadId,
                "@Telefono", telefono,
                "@Correo", correo,
                "@FotoPerfilRuta", fotoPerfilRuta);
        }

        public static void EliminarDoctor(int idDoctor)
        {
            string sp = "Doctores_Eliminar";
            MetodoDatos.ExecuteNonQuery(sp, "@IdDoctor", idDoctor);
        }
    }
}
