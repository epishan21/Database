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
        int type;

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

            if (type == 1)
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
            else if (type == 2)
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
            else if (type == 3)
            {
            }
            else if (type == 4)
            {
                DataBase.Columns.Clear();

                // Показать сетку
                DataBase.GridLines = true;

                // Выделение целой строки при нажатии
                DataBase.FullRowSelect = true;

                DataBase.View = View.Details;

                DataBase.Columns.Add("Жанр");
                DataBase.Columns[0].Width = 250;

                DataBase.Columns.Add("Средняя длина фильма");
                DataBase.Columns[1].Width = 180;

                LoadFilms();
            }
        }

        // Загрузить данные
        public void LoadFilms()
        {
            // Загрузить фильмы
            if (type == 1)
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
            else if (type == 2)
            {
                MySqlDataReader sqlReader = null;

                MySqlCommand getFilmsCommand = new MySqlCommand("SELECT Id_session, Date, Time, Format, Number, Name FROM sessions JOIN films ON sessions.Id_session = films.Id_films JOIN halls ON sessions.Id_hall = halls.Id_hall;", connection);

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
            else if (type == 3)
            {
            }
            // Вывести среднюю длину фильма каждого жанра
            else if (type == 4)
            {
                MySqlDataReader sqlReader = null;

                MySqlCommand ShowTicketsCommand = new MySqlCommand("SELECT Genre, AVG(Length) AS Genre_Lenth FROM films GROUP BY Genre Order by Genre_Lenth desc; ", connection);

                try
                {
                    sqlReader = ShowTicketsCommand.ExecuteReader();

                    while (sqlReader.Read())
                    {
                        ListViewItem item = new ListViewItem(new string[] {
                        Convert.ToString(sqlReader["Genre"]),
                        Convert.ToString(sqlReader["Genre_Lenth"])
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

            type = 1;

            Films.Enabled = false;
            sessions.Enabled = true;
            Insert_Button.Enabled = true;
            Update_btn.Enabled = true;
            toolStripButton5.Enabled = true;
            Delete_StripButton.Enabled = true;


            Form1_Load();
        }

        // Показать таблицу записей сессий и работать с ней
        private void sessions_Click(object sender, EventArgs e)
        {

            DataBase.Items.Clear();

            type = 2;

            sessions.Enabled = false;
            Films.Enabled = true;
            Insert_Button.Enabled = true;
            Update_btn.Enabled = true;
            toolStripButton5.Enabled = true;
            Delete_StripButton.Enabled = true;

            Form1_Load();
        }

        // Показать количество проданных билетов за определенный период
        private void Show_tickets_Click(object sender, EventArgs e)
        {

            DataBase.Items.Clear();

            DataBase.Columns.Clear();

            Films.Enabled = true;
            sessions.Enabled = true;
            Show_length.Enabled = true;
            Insert_Button.Enabled = false;
            Update_btn.Enabled = false;
            toolStripButton5.Enabled = false;
            Delete_StripButton.Enabled = false;

            type = 3;

            Form1_Load();

            window_show_ticket show_tick = new window_show_ticket(connection);

            show_tick.Show();

        }

        // Показать среднюю длину фильма для каждого жанра
        private void Show_length_Click(object sender, EventArgs e)
        {

            DataBase.Items.Clear();

            type = 4;

            Films.Enabled = true;
            sessions.Enabled = true;
            Show_tickets.Enabled = true;
            Insert_Button.Enabled = false;
            Update_btn.Enabled = false;
            toolStripButton5.Enabled = false;
            Delete_StripButton.Enabled = false;

            Form1_Load();
        }

        // Добавление записи
        private void Insert_Button_Click(object sender, EventArgs e)
        {
            if (type == 1)
            {
                INSERT insert = new INSERT(connection);

                insert.Show();
            }
            else if (type == 2)
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
            if (type == 1)
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
            else if (type == 2)
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
            if (type == 1)
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
            else if (type == 2)
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


