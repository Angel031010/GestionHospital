using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaDatos
{
    internal class Configuracion
    {
        private static readonly string _cadenaConexion = @"Data Source = DESKTOP-UQELRD8; Initial Catalog = GestionHospital; Integrated Security=True";

        public static string CadenaConexion
        {
            get { return _cadenaConexion; }
        }
    }
}
