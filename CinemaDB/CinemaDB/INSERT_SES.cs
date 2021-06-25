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
    public partial class INSERT_SES : Form
    {

        public static MySqlConnection connectionn = new MySqlConnection("server = 127.0.0.1; uid=root;pwd=1234;database=cinema");


        public INSERT_SES(MySqlConnection insert_connection)
        {
            InitializeComponent();

            connectionn = insert_connection;
        }

        private void insert_ses_btn_Click(object sender, EventArgs e)
        {
            MySqlCommand insertFilmCommand = new MySqlCommand("INSERT INTO sessions(Date, Time, Format, Id_hall, Id_films) VALUES(@Date, @Time, @Format, @Id_hall, @Id_films);", connectionn);

            insertFilmCommand.Parameters.AddWithValue("Date", date.Text);
            insertFilmCommand.Parameters.AddWithValue("Time", Time_box.Text);
            insertFilmCommand.Parameters.AddWithValue("Format", Format_textBox.Text);
            insertFilmCommand.Parameters.AddWithValue("Id_hall", Hall_textBox.Text);
            insertFilmCommand.Parameters.AddWithValue("Id_films", film_textBox.Text);

            try
            {
                insertFilmCommand.ExecuteNonQuery();

                Close();

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Ошибка!", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void cancel_ses_bth_Click(object sender, EventArgs e)
        {
            Close();
        }
    }
}
