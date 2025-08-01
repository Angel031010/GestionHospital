using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VO
{
    public class PacientesVO
    {
        private int _idPaciente;
        private string _nombre;
        private string _apellidoPaterno;
        private string _apellidoMaterno;
        private DateTime _fechaNacimiento;
        private char _sexo;
        private string _telefono;
        private string _correoElectronico;
        private string _direccion;
        private string _fotoPerfilRuta;

        public int IdPaciente
        {
            get => _idPaciente; set => _idPaciente = value;
        }

        public string Nombre
        {
            get => _nombre; set => _nombre = value;
        }

        public string ApellidoPaterno
        {
            get => _apellidoPaterno; set => _apellidoPaterno = value;
        }

        public string ApellidoMaterno
        {
            get => _apellidoMaterno; set => _apellidoMaterno = value;
        }

        public DateTime FechaNacimiento
        {
            get => _fechaNacimiento; set => _fechaNacimiento = value;
        }

        public char Sexo
        {
            get => _sexo; set => _sexo = value;
        }

        public string Telefono
        {
            get => _telefono; set => _telefono = value;
        }

        public string CorreoElectronico
        {
            get => _correoElectronico; set => _correoElectronico = value;
        }

        public string Direccion
        {
            get => _direccion; set => _direccion = value;
        }

        public string FotoPerfilRuta
        {
            get => _fotoPerfilRuta; set => _fotoPerfilRuta = value;
        }

        public PacientesVO()
        {
            _idPaciente = 0;
            _nombre = string.Empty;
            _apellidoPaterno = string.Empty;
            _apellidoMaterno = string.Empty;
            _fechaNacimiento = DateTime.MinValue;
            _sexo = ' ';
            _telefono = string.Empty;
            _correoElectronico = string.Empty;
            _direccion = string.Empty;
            _fotoPerfilRuta = string.Empty;
        }

        public PacientesVO(DataRow registro)
        {
            _idPaciente = int.Parse(registro["IdPaciente"].ToString());
            _nombre = registro["Nombre"].ToString();
            _apellidoPaterno = registro["ApellidoPaterno"].ToString();
            _apellidoMaterno = registro["ApellidoMaterno"].ToString();
            _fechaNacimiento = DateTime.Parse(registro["FechaNacimiento"].ToString());
            _sexo = char.Parse(registro["Sexo"].ToString());
            _telefono = registro["Telefono"].ToString();
            _correoElectronico = registro["Correo"].ToString();
            _direccion = registro["Direccion"].ToString();
            _fotoPerfilRuta = registro["FotoPerfilRuta"].ToString();
        }
    }
}
