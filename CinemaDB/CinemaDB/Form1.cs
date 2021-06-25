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
        bool res;

        public Form1()
        {
            InitializeComponent();
        }

        public static MySqlConnection connection = new MySqlConnection("server = 127.0.0.1; uid=root;pwd=1234;database=cinema;Convert Zero Datetime=True");

        public async void Form1_Load()
        {

            // Открытие подключения БД
            if(!(connection != null && connection.State != ConnectionState.Closed))
            connection.Open();

            if (res == true)
            {
                DataBase.Columns.Clear();

                // Показать сетку
                DataBase.GridLines = true;

                // Выделение целой строки при нажатии
                DataBase.FullRowSelect = true;

                DataBase.View = View.Details;

                DataBase.Columns.Add("Id фльма");
                DataBase.Columns[0].Width = 80;

                DataBase.Columns.Add("Длина");
                DataBase.Columns[1].Width = 80;

                DataBase.Columns.Add("Жанр");
                DataBase.Columns[2].Width = 200;

                DataBase.Columns.Add("Рейтинг");
                DataBase.Columns[3].Width = 80;

                DataBase.Columns.Add("Название");
                DataBase.Columns[4].Width = 200;

                DataBase.Columns.Add("Актеры");
                DataBase.Columns[5].Width = 200;

                DataBase.Columns.Add("Режиссеры");
                DataBase.Columns[6].Width = 150;

                DataBase.Columns.Add("Описание");
                DataBase.Columns[7].Width = 200;

                DataBase.Columns.Add("Киностудии");
                DataBase.Columns[8].Width = 200;



                LoadFilms();
            }
            else if (res == false)
            {
                DataBase.Columns.Clear();

                // Показать сетку
                DataBase.GridLines = true;

                // Выделение целой строки при нажатии
                DataBase.FullRowSelect = true;

                DataBase.View = View.Details;

                DataBase.Columns.Add("Id сеанса");
                DataBase.Columns[0].Width = 80;

                DataBase.Columns.Add("Дата");
                DataBase.Columns[1].Width = 90;

                DataBase.Columns.Add("Время");
                DataBase.Columns[2].Width = 80;

                DataBase.Columns.Add("Формат");
                DataBase.Columns[3].Width = 80;

                DataBase.Columns.Add("Номер зала");
                DataBase.Columns[4].Width = 100;

                DataBase.Columns.Add("Название фильма");
                DataBase.Columns[5].Width = 180;

                LoadFilms();
            }
        }
        
        // Загрузить данные
        public void LoadFilms()
        {
            // Загрузить фильмы
            if (res == true)
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

                        DataBase.Items.Add(item);
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
            // Загрузить сеансы
            else if (res == false)
            {
                MySqlDataReader sqlReader = null;

                MySqlCommand getFilmsCommand = new MySqlCommand("SELECT Id_session, Date, Time, Format, Number, Name " +
                    "FROM sessions " +
                    "JOIN films ON sessions.Id_films = films.Id_films JOIN halls ON sessions.Id_hall = halls.Id_hall;", connection);
                   
                try
                {
                    sqlReader = getFilmsCommand.ExecuteReader();

                    while (sqlReader.Read())
                    {
                        ListViewItem item = new ListViewItem(new string[] {
                        Convert.ToString(sqlReader["Id_session"]),
                        Convert.ToString(sqlReader["Date"]),
                        Convert.ToString(sqlReader["Time"]),
                        Convert.ToString(sqlReader["Format"]),
                        Convert.ToString(sqlReader["Number"]),
                        Convert.ToString(sqlReader["Name"])
                    });

                        DataBase.Items.Add(item);
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

        // Показать таблицу записей фильмов и работать с ней
        private void Films_Click(object sender, EventArgs e)
        {
            DataBase.Items.Clear();

            res = true;

            Films.Enabled = false;
            sessions.Enabled = true;


            Form1_Load();
        }

        // Показать таблицу записей сессий и работать с ней
        private void sessions_Click(object sender, EventArgs e)
        {

            DataBase.Items.Clear();

            res = false;

            sessions.Enabled = false;
            Films.Enabled = true;

            Form1_Load();
        }

        // Добавление записи
        private void Insert_Button_Click(object sender, EventArgs e)
        {
            if (res == true)
            {
                INSERT insert = new INSERT(connection);

                insert.Show();
            }
            else if (res == false)
            {
                INSERT_SES insert_ses = new INSERT_SES(connection);

                insert_ses.Show();
            }
        }

        // Обновление списка
        private void toolStripButton5_Click(object sender, EventArgs e)
        {
            DataBase.Items.Clear();

            LoadFilms();
        }

        // Закрытие соединения
        private void Form1_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (connection != null && connection.State != ConnectionState.Closed)
                connection.Close();
        }

        // Удаление записи
        private void Delete_StripButton_Click(object sender, EventArgs e)
        {
            // Удалить фильм
            if (res == true)
            {
                if (DataBase.SelectedItems.Count > 0)
                {
                    DialogResult res = MessageBox.Show("Вы действительно хотите удалить эту строку?", "Удаление строки", MessageBoxButtons.OKCancel, MessageBoxIcon.Exclamation);

                    switch (res)
                    {
                        case DialogResult.OK:

                            MySqlCommand deleteFilmCommand = new MySqlCommand("DELETE FROM films WHERE id_films = @id;", connection);

                            deleteFilmCommand.Parameters.AddWithValue("id", Convert.ToInt32(DataBase.SelectedItems[0].SubItems[0].Text));

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
            // Удалить сеанс
            else if (res == false)
            {
                if (DataBase.SelectedItems.Count > 0)
                {
                    DialogResult res = MessageBox.Show("Вы действительно хотите удалить эту строку?", "Удаление строки", MessageBoxButtons.YesNo, MessageBoxIcon.Exclamation);

                    switch (res)
                    {
                        case DialogResult.Yes:

                            MySqlCommand deleteSesCommand = new MySqlCommand("DELETE FROM sessions WHERE id_session = @id;", connection);

                            deleteSesCommand.Parameters.AddWithValue("id", Convert.ToInt32(DataBase.SelectedItems[0].SubItems[0].Text));

                            try
                            {
                                deleteSesCommand.ExecuteNonQuery();
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

        // Обновление записи
        private void Update_btn_Click(object sender, EventArgs e)
        {
            // Обновить фильм
            if (res == true)
            {
                if (DataBase.SelectedItems.Count > 0)
                {

                    UPDATE update = new UPDATE(connection, Convert.ToInt32(DataBase.SelectedItems[0].SubItems[0].Text));

                    update.Show();
                }
                else
                {
                    MessageBox.Show("Ни одна строка не была выделена!", "Ошибка!", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
            // Обновить сессию
            else if (res == false)
            {
                if (DataBase.SelectedItems.Count > 0)
                {

                    UPDATE_SES update_ses = new UPDATE_SES(connection, Convert.ToInt32(DataBase.SelectedItems[0].SubItems[0].Text));

                    update_ses.Show();
                }
                else
                {
                    MessageBox.Show("Ни одна строка не была выделена!", "Ошибка!", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
        }
    }
}


