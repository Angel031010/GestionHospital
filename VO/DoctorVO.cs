using System;
using System.Data;

namespace VO
{
    public class DoctorVO
    {
        public int IdDoctor { get; set; }
        public string Nombre { get; set; }
        public string ApellidoPaterno { get; set; }
        public string ApellidoMaterno { get; set; }
        public int EspecialidadId { get; set; }
        public string Telefono { get; set; }
        public string Correo { get; set; }
        public string FotoPerfilRuta { get; set; }

        public DoctorVO()
        {
            IdDoctor = 0;
            Nombre = string.Empty;
            ApellidoPaterno = string.Empty;
            ApellidoMaterno = string.Empty;
            EspecialidadId = 0;
            Telefono = string.Empty;
            Correo = string.Empty;
            FotoPerfilRuta = string.Empty;
        }

        public DoctorVO(DataRow dr)
        {
            IdDoctor = Convert.ToInt32(dr["IdDoctor"]);
            Nombre = dr["Nombre"].ToString();
            ApellidoPaterno = dr["ApellidoPaterno"].ToString();
            ApellidoMaterno = dr["ApellidoMaterno"].ToString();
            EspecialidadId = Convert.ToInt32(dr["EspecialidadId"]);
            Telefono = dr["Telefono"].ToString();
            Correo = dr["Correo"].ToString();
            FotoPerfilRuta = dr["FotoPerfilRuta"].ToString();
        }
    }
}
