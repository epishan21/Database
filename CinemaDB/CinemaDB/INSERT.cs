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
    public partial class INSERT : Form
    {

        public static MySqlConnection connection = new MySqlConnection("server = 127.0.0.1; uid=root;pwd=1234;database=cinema");

        public INSERT(MySqlConnection insert_connection)
        {
            InitializeComponent();

            connection = insert_connection;
        }

        private void insert_btn_Click(object sender, EventArgs e)
        {

            MySqlCommand insertFilmCommand = new MySqlCommand("INSERT INTO films(Length, Genre, Rating, Name, Actors, Directors, Description, Film_company) VALUES(@Length, @Genre, @Rating, @Name, @Actors, @Directors, @Description, @Film_company);", connection);

            insertFilmCommand.Parameters.AddWithValue("Length", Length_numeric.Text);       
            insertFilmCommand.Parameters.AddWithValue("Genre", Genre_textBox.Text);       
            insertFilmCommand.Parameters.AddWithValue("Rating", Rating_numeric.Text);       
            insertFilmCommand.Parameters.AddWithValue("Name", Name_textBox.Text);       
            insertFilmCommand.Parameters.AddWithValue("Actors", Actros_textBox.Text);       
            insertFilmCommand.Parameters.AddWithValue("Directors", Directors_textBox.Text);       
            insertFilmCommand.Parameters.AddWithValue("Description", Description_textBox.Text);       
            insertFilmCommand.Parameters.AddWithValue("Film_company", Company_textBox.Text);

            try 
            {
                insertFilmCommand.ExecuteNonQuery();

                Close();

            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.Message, "Ошибка!", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
                
        }

        private void cancel_bth_Click(object sender, EventArgs e)
        {
            Close();
        }

    }
}
