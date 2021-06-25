using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data;
using MySql.Data;
using MySql.Data.MySqlClient;

namespace CinemaDB
{
    public partial class UPDATE_SES : Form
    {
        public static MySqlConnection connection = new MySqlConnection("server = 127.0.0.1; uid=root;pwd=1234;database=cinema;");

        private int id;

        public UPDATE_SES(MySqlConnection update_connection, int id)
        {
            InitializeComponent();

            connection = update_connection;

            this.id = id;
        }

        // Отмена
        private void cancel_bth_Click(object sender, EventArgs e)
        {
            Close();
        }

        // Сохранить данные
        private void Save_btn_Click(object sender, EventArgs e)
        {
            MySqlCommand updateSESCommand = new MySqlCommand("UPDATE sessions JOIN films ON sessions.Id_session = films.Id_films JOIN halls ON sessions.Id_hall = halls.Id_hall SET Date=@Date, Time=@Time, Format=@Format, Number=@Number, Name=@Name WHERE id_session=@id;", connection);

            updateSESCommand.Parameters.AddWithValue("id", id);
            updateSESCommand.Parameters.AddWithValue("Date", Convert.ToDateTime(date.Text));
            updateSESCommand.Parameters.AddWithValue("Time", Time_box.Text);
            updateSESCommand.Parameters.AddWithValue("Format", Format_textBox.Text);
            updateSESCommand.Parameters.AddWithValue("Number", Hall_textBox.Text);
            updateSESCommand.Parameters.AddWithValue("Name", Film_textBox.Text);

            try
            {
                updateSESCommand.ExecuteNonQuery();

                Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Ошибка!", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        // Отоброзить поля
        private void UPDATE_SES_Load(object sender, EventArgs e)
        {
            MySqlDataReader sqlReader = null;

            MySqlCommand getSESInfoCommand = new MySqlCommand("SELECT Date, Time, Format, Number, Name FROM sessions JOIN films ON sessions.Id_session = films.Id_films JOIN halls ON sessions.Id_hall = halls.Id_hall WHERE id_session=@id;", connection);

            getSESInfoCommand.Parameters.AddWithValue("id", id);

            try
            {
                sqlReader = getSESInfoCommand.ExecuteReader();

                while (sqlReader.Read())
                {
                    date.Text = Convert.ToString(sqlReader["Date"]);
                    Time_box.Text = Convert.ToString(sqlReader["Time"]);
                    Format_textBox.Text = Convert.ToString(sqlReader["Format"]);
                    Hall_textBox.Text = Convert.ToString(sqlReader["Number"]);
                    Film_textBox.Text = Convert.ToString(sqlReader["Name"]);
                }

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Ошибка!", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            finally
            {
                if (sqlReader != null && !sqlReader.IsClosed)
                {
                    sqlReader.Close();
                }
            }
        }
    }
}
