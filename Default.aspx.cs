using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Web.Security;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Telerik.Web.UI;

public partial class Default : System.Web.UI.Page 
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
        
    }

    private bool ValidateDates(out DateTime dateFrom, out DateTime dateTo)
    {
      
        dateFrom = DateTime.MinValue;
        dateTo = DateTime.MinValue;

        if (string.IsNullOrEmpty(RadDateTimePicker1.SelectedDate?.ToString()) ||
            string.IsNullOrEmpty(RadDateTimePicker2.SelectedDate?.ToString()))
        {
            ShowAlert("Kindly fill in both date fields.");
            return false;
        }

        dateFrom = RadDateTimePicker1.SelectedDate.Value;
        dateTo = RadDateTimePicker2.SelectedDate.Value;

        if (dateFrom >= dateTo)
        {
            ShowAlert("Start date/time must be earlier than end date/time.");
            return false;
        }

        return true;
    }

    private void ShowAlert(string message)
    {
        ScriptManager.RegisterStartupScript(this, GetType(), "alert", $"alert('{message}');", true);
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        DateTime dateFrom;
        DateTime dateTo;
        

        if (!ValidateDates(out dateFrom, out dateTo))
            return;

        //bool columnExists = DateTimeTable.Columns.Contains("wtgName");
        //if (!columnExists)
        //{
        //    DateTimeTable.Columns.Add("wtgName", typeof(string));
        //}

        var selectedItems = wtgList.CheckedItems;


        var abc = dateFrom;
        var gg = dateTo; 

        if (selectedItems.Count == 0)
        {
            ShowAlert("Please select at least one item from the WTG list.");
            return;
        }

        foreach (var item in selectedItems)
        {
            string wtgName = item.Text;
            string wtgId = item.Value;

            //bool exists = DateTimeTable.AsEnumerable().Any(row =>
            //    row.Field<string>("systemNumber") == wtgId &&
            //    row.Field<DateTime>("dateFrom") == dateFrom &&
            //    row.Field<DateTime>("dateTo") == dateTo
            //);

            //if (exists)
            //{
            //    ShowAlert($"The WTG {wtgName} with the specified date range already exists.");
            //    continue;
            //}

            //DataRow newRow = DateTimeTable.NewRow();
            //newRow["userId"] = Session["ID"];
            //newRow["systemNumber"] = wtgId;
            //newRow["wtgName"] = wtgName;
            //newRow["dateFrom"] = dateFrom;
            //newRow["dateTo"] = dateTo;
            //DateTimeTable.Rows.Add(newRow);
        }

        RadDateTimePicker1.Clear();
        RadDateTimePicker2.Clear();

        //BindGrid();
    }

}
