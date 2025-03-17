<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="GridRecordsInput.aspx.cs" Inherits="Curtailment" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<%--<script type="text/javascript" src="Scripts/AjaxControlToolkit.js"></script>--%>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentHead" runat="server">
    <title>Grid Outage Records</title>

    <style>
        body {
            font-family: sans-serif,Arial;
            background-color: #f4f7fc;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 100%;
            /*max-width: auto;*/
            /*max-height:100%;*/
            height: 100%;
            /*margin: 50px auto;*/
            padding: 20px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            font-size: 32px;
            font-weight: 700;
            color: #333;
            text-align: center;
            margin-bottom: 40px;
        }

        h2 {
            font-size: 24px;
            color: #333;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-btn {
            width: 100%;
        }

        .form-label {
            font-size: 16px;
            font-weight: 600;
            color: #333;
            margin-bottom: 5px;
            display: block;
        }

        .form-control {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border-radius: 4px;
            border: 1px solid #ddd;
            box-sizing: border-box;
            margin-bottom: 10px;
            margin-top: 30px;
        }

            .form-control:focus {
                border-color: #007bff;
                outline: none;
                box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
            }

        .btn {
            padding: 8px 10px;
            font-size: 16px;
            border-radius: 10px;
            gap: 100px;
            cursor: pointer;
            /* width: 40%;*/
            border: none;
            transition: background-color 0.3s;
            display: block;
            margin: 0 auto;
        }

        .btn-primary {
            background-color: #007bff;
            /*color: #fff;*/
        }

            .btn-primary:hover {
                background-color: #0056b3;
            }

        .btn-danger {
            background-color: #dc3545;
            color: #fff;
            border-radius:10px;
            padding:5px;
        }

            .btn-danger:hover {
                background-color: #c82333;
            }

        .btn-success {
            background-color: #28a745;
            color: #fff;
            margin-top: 30px;
            justify-content: center;
        }

            .btn-success:hover {
                background-color: #218838;
            }


        .btnsub {
            border-radius:5px;
        }

        /* .error-message {
            color: red;
            font-size: 16px;
            margin-top: 10px;
            margin-bottom: 20px;
            padding: 10px;
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            border-radius: 4px;
            text-align: center;
        }*/

        .table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
        }

            .table th,
            .table td {
                padding: 10px;
                text-align: left;
                border: 1px solid #ddd;
            }

            .table th {
                background-color: #f4f4f4;
                font-weight: 600;
                font-size: 20px;
            }

            .table tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            .table tr:hover {
                background-color: #f1f1f1;
            }

            .table .btn-sm {
                padding: 5px 10px;
                font-size: 14px;
                border-radius: 4px;
            }

        .new {
            max-height: 400px;
            overflow-y: auto;
            overflow-x: auto;
        }

        .pack {
            /*border:1px solid;*/
            /*margin-left: 500px;*/
            /*align-items:center;*/
            /*margin: auto;
            width: 70%;*/
            /*border: 3px solid green;*/
            /*padding: 10px;*/

            display: flex;
            justify-content: center;
            align-items: baseline;
            margin: auto;
            gap: 10px;
            width: 90%;
            padding: 10px;
        }

        .butn {
            padding: 8px 10px;
            font-size: 16px;
            border-radius: 10px;
            gap: 100px;
            cursor: pointer;
            /* width: 40%;*/
            border: none;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="server">
    <form id="form1" runat="server">
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" EnableAJAX="true" DefaultLoadingPanelID="RadAjaxLoadingPanel1">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="btnAdd">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="gridView" />
                        <telerik:AjaxUpdatedControl ControlID="btnRemoveAll" />
                        <telerik:AjaxUpdatedControl ControlID="lblErrorMessage" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="btnRemoveAll">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="gridView" />
                        <telerik:AjaxUpdatedControl ControlID="btnRemoveAll" />
                        <telerik:AjaxUpdatedControl ControlID="lblErrorMessage" />

                        <%--<telerik:AjaxUpdatedControl ControlID="btnRemoveAll" />--%>
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
            <AjaxSettings>
                <%-- <telerik:AjaxSetting AjaxControlID="gridView">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="gridView" />
                        <telerik:AjaxUpdatedControl ControlID="btnRemoveAll" />
                    </UpdatedControls>
                </telerik:AjaxSetting>--%>
            </AjaxSettings>
        </telerik:RadAjaxManager>

        <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="MetroTouch">
        </telerik:RadAjaxLoadingPanel>

        <div class="container">
            <h1>Grid Outage Records</h1>
            <div class="pack">
                <label for="startDateTime">WTG:</label>
                <telerik:RadComboBox RenderMode="Lightweight" ID="wtgList" runat="server" EnableCheckAllItemsCheckBox="true" CheckBoxes="true" Width="">
                </telerik:RadComboBox>
                <label for="startDateTime">Start Date/Time:</label>
                <input runat="server" type="datetime-local" step="1" id="dateFromTime" class="" />
                <label for="endDateTime">End Date/Time:</label>
                <input runat="server" type="datetime-local" step="1" id="dateToTime" class="" />
                <asp:Button ID="btnAdd" runat="server" Text="Add Record" OnClick="btnAdd_Click" CssClass="butn btn-primary" />


                <asp:GridView ID="gridView1" runat="server" AutoGenerateColumns="true"
                    CssClass="table table-bordered table-striped">
                </asp:GridView>

            </div>


            <h1 style="margin-top: 30px;">Records</h1>

            <div class="new">
                <asp:GridView ID="gridView" runat="server" AutoGenerateColumns="False" ShowHeaderWhenEmpty="False" CssClass="table" EmptyDataText="No Entry Exists." Width="100%">
                    <Columns>
                        <asp:TemplateField HeaderText="Serial No">
                            <ItemTemplate>
                                <%# ((GridViewRow)Container).RowIndex + 1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <%--<asp:BoundField DataField="systemNumber" HeaderText="WTG" SortExpression="systemNumber" />--%>

                        <asp:BoundField DataField="systemNumber" HeaderText="System Number" Visible="false" />

                        <asp:BoundField DataField="wtgName" HeaderText="WTG" Visible="True" />

                        <asp:BoundField DataField="dateFrom" HeaderText="Start Date/Time" SortExpression="StartDate" />

                        <asp:BoundField DataField="dateTo" HeaderText="End Date/Time" SortExpression="EndDate" />

                        <asp:TemplateField HeaderText="Remove">
                            <ItemTemplate>
                                <asp:Button CssClass="btn-danger" ID="btnRemove" runat="server" Text="Remove" CommandName="Remove" CommandArgument="<%# Container.DataItemIndex %>" OnCommand="btnRemove_Command" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>



            <asp:Label ID="lblErrorMessage" runat="server" Visible="false"></asp:Label>

            <div class="btnSub">
                <asp:Button ID="btnRemoveAll" runat="server" Text="Submit" OnClick="btnRemoveAll_Click" Enabled="false" CssClass="btn btn-success" />

            </div>
        </div>
    </form>
</asp:Content>
