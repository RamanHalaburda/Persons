using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using Persons.Models;
using System.Text;

namespace Persons
{
    public partial class ProjectPairs : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                DataTable dt = this.GetData();
                StringBuilder html = new StringBuilder();
                html.Append("<table border = '1'>");

                html.Append("<tr>");
                foreach (DataColumn column in dt.Columns)
                {
                    html.Append("<th>");
                    html.Append(column.ColumnName);
                    html.Append("</th>");
                }
                html.Append("</tr>");

                foreach (DataRow row in dt.Rows)
                {
                    html.Append("<tr>");
                    foreach (DataColumn column in dt.Columns)
                    {
                        html.Append("<td>");
                        html.Append(row[column.ColumnName]);
                        html.Append("</td>");
                    }
                    html.Append("</tr>");
                }

                html.Append("</table>");

                PlaceHolder1.Controls.Add(new Literal { Text = html.ToString() });
            }
        }

        private DataTable GetData()
        {
            string constr = ConfigurationManager.ConnectionStrings["PassportConnection"].ConnectionString;
            string query = "select a.last_name as [one last name], b.last_name as [two last name], p.title as [title of project]"
                               + " from project_pairs"
                               + "  join students as a"
                               + "      on project_pairs.project1_id = a.id"
                               + "  join students as b"
                               + "      on project_pairs.project2_id = b.id"
                               + "  join [dbo].[student_projects] as p"
                               + "      on project_pairs.id = p.id;";
            //string query = "select a.last_name, b.last_name, p.title from project_pairs join students as a on project_pairs.project1_id = a.id join students as b on project_pairs.project2_id = b.id join [dbo].[student_projects] as p on project_pairs.id = p.id;";
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand(query))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);
                            return dt;
                        }
                    }
                }
            }
        }
    }
}