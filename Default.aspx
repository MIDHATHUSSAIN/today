<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Default" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <telerik:RadStyleSheetManager id="RadStyleSheetManager1" runat="server" />
</head>
<body>
    <form id="form1" runat="server">
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
        </Scripts>
    </telerik:RadScriptManager>
    <div>
        <div style="display: flex; gap: 10px; align-items: center;">
    <!-- WTG List -->
    <telerik:RadComboBox RenderMode="Lightweight" ID="wtgList" runat="server" EnableCheckAllItemsCheckBox="true" CheckBoxes="true" Width="200px">
        <Items>
            <telerik:RadComboBoxItem Text="Turbine A" Value="T1" />
            <telerik:RadComboBoxItem Text="Turbine B" Value="T2" />
            <telerik:RadComboBoxItem Text="Turbine C" Value="T3" />
        </Items>
    </telerik:RadComboBox>

    <!-- Start Date -->
    <telerik:RadDateTimePicker RenderMode="Lightweight" ID="RadDateTimePicker1" AutoPostBack="true"
        DateInput-DisplayDateFormat="dd-MMM-yyyy HH:mm:ss" ShowPopupOnFocus="true" Width="400px" runat="server">
    </telerik:RadDateTimePicker>

    <!-- End Date -->
    <telerik:RadDateTimePicker RenderMode="Lightweight" ID="RadDateTimePicker2" AutoPostBack="true"
        DateInput-DisplayDateFormat="dd-MMM-yyyy HH:mm:ss" ShowPopupOnFocus="true" Width="400px" runat="server">
    </telerik:RadDateTimePicker>

    <!-- Add Button -->
    <asp:Button ID="btnAdd" runat="server" Text="Add" OnClick="btnAdd_Click" />
</div>


    </div>
    </form>
</body>
</html>
