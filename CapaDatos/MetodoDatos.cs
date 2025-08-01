using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaDatos
{
    internal class MetodoDatos
    {
        public static DataSet ExecuteDataSet(string storedProcedure, params object[] parameters)
        {
            DataSet ds = new DataSet();
            // Aquí se debe establecer la cadena de conexión a la base de datos.
            string cadenaConexion = Configuracion.CadenaConexion;
            // Se crea una conexión a la base de datos utilizando la cadena de conexión.
            SqlConnection connection = new SqlConnection(cadenaConexion);

            try
            {
                // Crear el objeto SqlCommand para ejecutar el procedimiento almacenado.
                SqlCommand cmd = new SqlCommand(storedProcedure, connection);

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = storedProcedure;

                //Se valida que los parametros esten completos
                if (parameters != null && parameters.Length % 2 != 0)
                {
                    throw new ApplicationException("Los parametros deben venir en pares");
                }
                else
                {
                    // Agregar los parámetros al comando.
                    for (int i = 0; i < parameters.Length; i += 2)
                    {
                        cmd.Parameters.AddWithValue(parameters[i].ToString(), parameters[i + 1]);
                    }

                    // Abrir la conexión a la base de datos.
                    connection.Open();

                    // Se ejecuta el comando y se llena el DataSet con los resultados.
                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);

                    adapter.Fill(ds);

                    // Cerrar la conexión a la base de datos.

                    connection.Close();
                }

                return ds;
            }
            catch (Exception ex)
            {
               return null; // O manejar la excepción de manera adecuada.
            }
            finally
            {
                if (connection.State == ConnectionState.Open)
                {
                    connection.Close();
                }
            }
        }

        public static int ExecuteNonQuery(string storedProcedure, params object[] parameters)
        {
            int exitoso = 0;

            // Aquí se debe establecer la cadena de conexión a la base de datos.
            string cadenaConexion = Configuracion.CadenaConexion;

            // Se crea una conexión a la base de datos utilizando la cadena de conexión.
            SqlConnection connection = new SqlConnection(cadenaConexion);

            try
            {
                // Crear el objeto SqlCommand para ejecutar el procedimiento almacenado.
                SqlCommand cmd = new SqlCommand(storedProcedure, connection);

                // Se set el tipo de comando y se envia el nombre del procedimiento almacenado.
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = storedProcedure;

                // Agregan los parametros
                for (int i = 0; i < parameters.Length; i += 2)
                {
                    cmd.Parameters.AddWithValue(parameters[i].ToString(), parameters[i + 1]);
                }

                connection.Open();

                cmd.ExecuteNonQuery();

                exitoso = 1; // Indica que la operación fue exitosa.
                connection.Close();

                return exitoso;
            }
            catch (Exception ex)
            {
                // Manejar la excepción de manera adecuada.
                return exitoso; // Indica que hubo un error en la operación.
            }
            finally
            {
                if (connection.State == ConnectionState.Open)
                {
                    connection.Close();
                }
            }
        }

        //Metodo que ejecuta un escalar
        public static int ExecuteEscalar(string sp, params object[] parametros)
        {
            int id = 0;

            //Traer la cadena de conexión
            string cadenaConexion = Configuracion.CadenaConexion;

            //Crear la conexion
            SqlConnection conn = new SqlConnection(cadenaConexion);

            try
            {
                //Crear el SqlCommand
                SqlCommand cmd = new SqlCommand(sp, conn);

                //Se selecciona el tipo de comando y el se le envía el nombre del storedProocedure
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = sp;

                //Agregan los parámetros
                for (int i = 0; i < parametros.Length; i = i + 2)
                {
                    cmd.Parameters.AddWithValue(parametros[i].ToString(), parametros[i + 1]);
                }

                //Abrir la conexion
                conn.Open();

                //Ejecutar el stored procedure
                id = int.Parse(cmd.ExecuteScalar().ToString());

                //Cerrar la conexion
                conn.Close();

                return id;
            }
            catch (Exception ex)
            {
                return id;
            }
            finally
            {
                if (conn.State == System.Data.ConnectionState.Open)
                {
                    conn.Close();
                }
            }
        }
    }
}
