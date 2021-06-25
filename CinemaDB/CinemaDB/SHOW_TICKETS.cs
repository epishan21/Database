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
    public partial class window_show_ticket : Form
    {

        public static MySqlConnection connection = new MySqlConnection("server = 127.0.0.1; uid=root;pwd=1234;database=cinema;");

        public window_show_ticket(MySqlConnection show_tick_connection)
        {
            InitializeComponent();

            connection = show_tick_connection;
        }

        private void cancel_show_bth_Click(object sender, EventArgs e)
        {
            Close();         
        }

        private void calculate_tick_btn_Click(object sender, EventArgs e)
        {

            MySqlDataReader sqlReader = null;

            MySqlCommand ShowTicketsCommand = new MySqlCommand("SELECT COUNT(Id_tickets) as count_tick FROM tickets JOIN sessions ON tickets.Id_session = sessions.Id_session where date between @date1 and @date2;", connection);

            ShowTicketsCommand.Parameters.AddWithValue("date1", Convert.ToDateTime(date1.Text));
            ShowTicketsCommand.Parameters.AddWithValue("date2", Convert.ToDateTime(date2.Text));

            try
            {
                sqlReader = ShowTicketsCommand.ExecuteReader();

                while (sqlReader.Read())
                {
                    result.Text = Convert.ToString(sqlReader["count_tick"]);
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
