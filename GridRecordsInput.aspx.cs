
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Curtailment : System.Web.UI.Page
{
    private DataTable DateTimeTable
    {
        get
        {
            if (ViewState["DateTimeTable"] == null)
            {
                DataTable dt = new DataTable();
                dt.Columns.Add("userId", typeof(int));
                dt.Columns.Add("dateFrom", typeof(DateTime));
                dt.Columns.Add("dateTo", typeof(DateTime));
                dt.Columns.Add("wtgName", typeof(string));
                dt.Columns.Add("systemNumber", typeof(string));

                ViewState["DateTimeTable"] = dt;

            }
            return (DataTable)ViewState["DateTimeTable"];
        }
        set
        {
            ViewState["DateTimeTable"] = value;
            
        }


    }

    protected void Page_Load(object sender, EventArgs e)
    {
        //InitializeDataTable();
        if (!IsPostBack)
        {
            PopulateWTGList();
            BindGrid();
        }
        else
        {

            UpdateUIState();
        }
    }





    public void PopulateWTGList()
    {


        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["APM"].ConnectionString);
        SqlCommand cmd = new SqlCommand("SP_GetWTGsList", con)
        {
            CommandType = CommandType.StoredProcedure
        };


        SqlDataAdapter DA = new SqlDataAdapter(cmd);
        con.Open();
        DataTable dT = new DataTable();
        DA.Fill(dT);
        con.Close();


        wtgList.DataTextField = "NAME";
        wtgList.DataValueField = "ID";



        wtgList.DataSource = dT;
        wtgList.DataBind();
    }

    //private void InitializeDataTable()
    //{
    //    if (DateTimeTable == null)
    //    {

    //        DateTimeTable = new DataTable();
    //        DateTimeTable.Columns.Add("userId", typeof(int));
    //        DateTimeTable.Columns.Add("dateFrom", typeof(DateTime));
    //        DateTimeTable.Columns.Add("dateTo", typeof(DateTime));
    //        DateTimeTable.Columns.Add("wtgName", typeof(string));

    //        //DateTimeTable.Add("systemNumber", typeof(int));
    //        DateTimeTable.Columns.Add("systemNumber", typeof(string));
    //    }

    //}


    private bool ValidateDates(out DateTime dateFrom, out DateTime dateTo)
    {
        lblErrorMessage.Visible = false;
        dateFrom = DateTime.MinValue;
        dateTo = DateTime.MinValue;

        if (string.IsNullOrEmpty(dateFromTime.Value) || string.IsNullOrEmpty(dateToTime.Value))
        {
            ShowAlert("Kindly fill in both fields.");
            return false;
        }

        if (!DateTime.TryParse(dateFromTime.Value, out dateFrom) || !DateTime.TryParse(dateToTime.Value, out dateTo))
        {
            ShowAlert("The date/time format is invalid. Please enter a valid start and end date/time.");
            return false;
        }

        if (dateFrom >= dateTo)
        {
            ShowAlert("Start date/time must be earlier than end date/time.");
            return false;
        }

        return true;

    }


    private void ShowAlert(string message)
    {
        ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('" + message + "');", true);
    }


    private void UpdateUIState()
    {
        if (DateTimeTable != null)
        //if (DateTimeTable == null || DateTimeTable.Rows.Count <= 0)
        {


            btnRemoveAll.Enabled = true;

        }
        else
        {
            //btnRemoveAll.Enabled = false;
        }
    }


    protected void btnAdd_Click(object sender, EventArgs e)
    {
        DateTime dateFrom;
        DateTime dateTo;

        if (!ValidateDates(out dateFrom, out dateTo))
            return;
        bool exist = false;
        for (int i = 0; i < DateTimeTable.Columns.Count; i++)
        {

            if (DateTimeTable.Columns[i].ColumnName == "wtgName")
            {
                exist = true;
            }
        }
        if (exist == false)
        {
            DateTimeTable.Columns.Add("wtgName", typeof(string));
        }

        var selectedItems = wtgList.CheckedItems;

        if (selectedItems.Count == 0)
        {
            ShowAlert("Please select at least one item from the WTG list.");
            return;
        }

        foreach (var item in selectedItems)
        {
            string wtgName = item.Text;
            string wtgId = item.Value;

            bool exists = DateTimeTable.AsEnumerable().Any(row =>
                row.Field<string>("systemNumber") == wtgId &&
                row.Field<DateTime>("dateFrom") == dateFrom &&
                row.Field<DateTime>("dateTo") == dateTo
            );

            if (exists)
            {
                //ShowAlert("The WTG " + wtgName + "with the specified date range already exists in the table.");
                ShowAlert("Some WTGs with the specified date range already exists in the table.");
                continue;
            }

            DataRow newRow = DateTimeTable.NewRow();
            newRow["userId"] = Session["ID"];
            newRow["systemNumber"] = wtgId;
            newRow["wtgName"] = wtgName;
            newRow["dateFrom"] = dateFrom;
            newRow["dateTo"] = dateTo;
            DateTimeTable.Rows.Add(newRow);
        }

        dateFromTime.Value = "";
        dateToTime.Value = "";

        BindGrid();
    }


    protected void btnRemoveAll_Click(object sender, EventArgs e)

    {

        //btnRemoveAll.Enabled = DateTimeTable != null && DateTimeTable.Rows.Count > 0;

        InsertGridRecord(DateTimeTable);




    }


    protected void btnRemove_Command(object sender, CommandEventArgs e)
    {
        int rowIndex = Convert.ToInt32(e.CommandArgument);
        if (rowIndex >= 0 && rowIndex < DateTimeTable.Rows.Count)
        {
            DateTimeTable.Rows.RemoveAt(rowIndex);
            BindGrid();
        }
        //DateTimeTable.Rows.RemoveAt(rowIndex);
        //BindGrid();
    }

    private void BindGrid()
    {
        gridView.DataSource = DateTimeTable;
        gridView.DataBind();
        //UpdateUIState();
    }

    private void InsertGridRecord(DataTable DateTimeTable)
    {
        try
        {
            DateTimeTable.Columns.Remove("wtgName");

            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["APM"].ConnectionString);
            SqlCommand cmd = new SqlCommand("sp_get_tbl_user_grid_outage_manual", con)
            {
                CommandType = CommandType.StoredProcedure
            };
            cmd.Parameters.AddWithValue("@records", DateTimeTable);

            SqlDataAdapter DA = new SqlDataAdapter(cmd);
            con.Open();
            DataTable dT = new DataTable();
            DA.Fill(dT);
            con.Close();
            DateTimeTable.Clear();
            BindGrid();


            lblErrorMessage.Text = "Records Successfully Updated!";
            lblErrorMessage.ForeColor = Color.Green;
            lblErrorMessage.Visible = true;
        }
        catch (Exception e)
        {
            lblErrorMessage.Text = "Insert Operation Failed.";
            lblErrorMessage.ForeColor = Color.Red;
            lblErrorMessage.Visible = true;

        }
    }
}
