using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VO
{
    public class EspecialidadesVO
    {
        private int _idEspecialidad;
        private string _nombreEspecialidad;

        public int IdEspecialidad
        {
            get => _idEspecialidad; 
            set => _idEspecialidad = value;
        }

        public string NombreEspecialidad
        {
            get => _nombreEspecialidad; 
            set => _nombreEspecialidad = value;
        }

        public EspecialidadesVO(DataRow registro)
        {
            _idEspecialidad = int.Parse(registro["IdEspecialidad"].ToString());
            _nombreEspecialidad = registro["NombreEspecialidad"].ToString();
        }

        public EspecialidadesVO()
        {
            _idEspecialidad = 0;
            _nombreEspecialidad = string.Empty;
        }
    }
}
