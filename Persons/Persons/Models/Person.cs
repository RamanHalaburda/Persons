using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;

namespace Persons.Models
{
    public class Person
    {
        public string firstName { get; set; }
        public string lastName { get; set; }
        public string seria { get; set; }
        public string number { get; set; }

        public Person(SqlDataReader _rdr)
        {
            this.firstName = _rdr[0].ToString();
            this.lastName = _rdr[1].ToString();
            this.seria = _rdr[2].ToString();
            this.number = _rdr[3].ToString();
        }
    }
}