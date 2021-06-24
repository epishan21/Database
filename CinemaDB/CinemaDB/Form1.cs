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
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        public static MySqlConnection connection = new MySqlConnection("server = 127.0.0.1; uid=root;pwd=1234;database=cinema");

        public async void Form1_Load(object sender, EventArgs e)
        {

            // Открытие подключения БД
            connection.Open();

            // Показать сетку
            listView1.GridLines = true;

            // Выделение целой строки при нажатии
            listView1.FullRowSelect = true;

            listView1.View = View.Details;

            listView1.Columns.Add("Id_films");
            listView1.Columns.Add("Length");
            listView1.Columns.Add("Genre");
            listView1.Columns.Add("Rating");
            listView1.Columns.Add("Name");
            listView1.Columns.Add("Actors");
            listView1.Columns.Add("Directors");
            listView1.Columns.Add("Description");
            listView1.Columns.Add("Film_company");

            LoadFilms();
        }

        
        private void Form1_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (connection != null && connection.State != ConnectionState.Closed)
                connection.Close();
        }
        
        public void LoadFilms()
        {

            MySqlDataReader sqlReader = null;

            MySqlCommand getFilmsCommand = new MySqlCommand("SELECT Id_films, Length, Genre, Rating, Name, Actors, Directors, Description, Film_company FROM films;", connection);

            try
            {
                sqlReader = getFilmsCommand.ExecuteReader();

                while (sqlReader.Read()) 
                {
                    ListViewItem item = new ListViewItem(new string[] {
                        Convert.ToString(sqlReader["Id_films"]),
                        Convert.ToString(sqlReader["Length"]),
                        Convert.ToString(sqlReader["Genre"]),
                        Convert.ToString(sqlReader["Rating"]),
                        Convert.ToString(sqlReader["Name"]),
                        Convert.ToString(sqlReader["Actors"]),
                        Convert.ToString(sqlReader["Directors"]),
                        Convert.ToString(sqlReader["Description"]),
                        Convert.ToString(sqlReader["Film_company"])
                    });

                    listView1.Items.Add(item);
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

        private void toolStripButton5_Click(object sender, EventArgs e)
        {
            listView1.Items.Clear();

            LoadFilms();
        }

        //Insert_Button
        private void toolStripButton1_Click(object sender, EventArgs e)
        {
            INSERT insert = new INSERT(connection);

            insert.Show();
        }

        // Update
        private void toolStripButton2_Click(object sender, EventArgs e)
        {
            if (listView1.SelectedItems.Count > 0)
            {

                UPDATE update = new UPDATE(connection, Convert.ToInt32(listView1.SelectedItems[0].SubItems[0].Text));

                update.Show();
            }
            else
            {
                MessageBox.Show("Ни одна строка не была выделена!", "Ошибка!", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void Delete_StripButton_Click(object sender, EventArgs e)
        {

            if (listView1.SelectedItems.Count > 0)
            {
                DialogResult res = MessageBox.Show("Вы действительно хотите удалить эту строку?", "Удаление строки", MessageBoxButtons.OKCancel, MessageBoxIcon.Exclamation);

                switch (res)
                {
                    case DialogResult.OK:

                        MySqlCommand deleteFilmCommand = new MySqlCommand("DELETE FROM films WHERE id_films = @id", connection);

                        deleteFilmCommand.Parameters.AddWithValue("id", Convert.ToInt32(listView1.SelectedItems[0].SubItems[0].Text));

                        try
                        {
                            deleteFilmCommand.ExecuteNonQuery();
                        }
                        catch (Exception ex)
                        {
                            MessageBox.Show(ex.Message, "Ошибка!", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        }

                        break;
                }
            } 
            else
            {
                MessageBox.Show("Ни одна строка не была выделена!", "Ошибка!", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
    }
}


