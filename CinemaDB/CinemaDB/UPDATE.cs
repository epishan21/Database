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
    public partial class UPDATE : Form
    {

        public static MySqlConnection connection = new MySqlConnection("server = 127.0.0.1; uid=root;pwd=1234;database=cinema");

        private int id;

        public UPDATE(MySqlConnection update_connection, int id)
        {
            InitializeComponent();

            connection = update_connection;

            this.id = id;
        }

        private void UPDATE_Load(object sender, EventArgs e)
        {
            MySqlDataReader sqlReader = null;

            MySqlCommand getFilmInfoCommand = new MySqlCommand("SELECT Length, Genre, Rating, Name, Actors, Directors, Description, Film_company FROM films WHERE id_films=@id;", connection);

            getFilmInfoCommand.Parameters.AddWithValue("id", id);

            try
            {
                sqlReader = getFilmInfoCommand.ExecuteReader();

                while (sqlReader.Read())
                {
                    Length_numeric.Text = Convert.ToString(sqlReader["Length"]);
                    Genre_textBox.Text = Convert.ToString(sqlReader["Genre"]);
                    Rating_numeric.Text = Convert.ToString(sqlReader["Rating"]);
                    Name_textBox.Text = Convert.ToString(sqlReader["Name"]);
                    Actros_textBox.Text = Convert.ToString(sqlReader["Actors"]);
                    Directors_textBox.Text = Convert.ToString(sqlReader["Directors"]);
                    Description_textBox.Text = Convert.ToString(sqlReader["Description"]);
                    Company_textBox.Text = Convert.ToString(sqlReader["Film_company"]); 
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

        private void update_btn_Click(object sender, EventArgs e)
        {
            MySqlCommand updateFilmCommand = new MySqlCommand("UPDATE films SET Length=@Length, Genre=@Genre, Rating=@Rating, Name=@Name, Actors=@Actors, Directors=@Directors, Description=@Description, Film_company=@Film_company WHERE id_films=@id", connection);

            updateFilmCommand.Parameters.AddWithValue("id", id);
            updateFilmCommand.Parameters.AddWithValue("Length", Length_numeric.Text);
            updateFilmCommand.Parameters.AddWithValue("Genre", Genre_textBox.Text);
            updateFilmCommand.Parameters.AddWithValue("Rating", Rating_numeric.Text);
            updateFilmCommand.Parameters.AddWithValue("Name", Name_textBox.Text);
            updateFilmCommand.Parameters.AddWithValue("Actors", Actros_textBox.Text);
            updateFilmCommand.Parameters.AddWithValue("Directors", Directors_textBox.Text);
            updateFilmCommand.Parameters.AddWithValue("Description", Description_textBox.Text);
            updateFilmCommand.Parameters.AddWithValue("Film_company", Company_textBox.Text);

            try
            {
                updateFilmCommand.ExecuteNonQuery();

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
