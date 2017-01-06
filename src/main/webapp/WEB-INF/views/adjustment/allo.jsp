<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/commons/basejs.jsp" %>
    <meta http-equiv="X-UA-Compatible" content="edge" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>新增调拨单</title>
    <script type="text/javascript">

        var dataGrid;

        $(function() {
            dataGrid = $('#dataGrid').datagrid({
                url : '${path }/cargo/select',
                fit : true,
                striped : true,
                rownumbers : true,
                pagination : true,
                singleSelect : false,
                height : '27',
                idField : 'cId',
                sortName : 'id',
                sortOrder : 'asc',
                pageSize : 20,
                pageList : [ 10, 20, 30, 40, 50, 100, 200, 300, 400, 500 ],
                columns : [ [ {
                    width : '90',
                    title : '货物名称',
                    field : 'cName',
                    sortable : true
                }, {
                    width : '70',
                    title : '货主',
                    field : 'cStorerid',
                    sortable : true
                },{
                    width : '100',
                    title : '供应商',
                    field : 'cSupplierid',
                    sortable : true
                },  {
                    width : '120',
                    title : '客户托单号',
                    field : 'cShippingno',
                    sortable : true
                }, {
                    width : '70',
                    title : '仓库编码',
                    field : 'cWhid',
                    sortable : true
                },{
                    width : '60',
                    title : '数量',
                    field : 'cNum',
                    sortable : true
                },{
                        width : '80',
                        title : '总货毛重',
                        field : 'cTotalweight',
                        sortable : true
                },{
                    width : '60',
                    title : '总货体积',
                    field : 'cTotalvolume',
                    sortable : true
                },{
                    width : '150',
                    title : '入库时间',
                    field : 'cReceivedate',
                    sortable : true
                },{
                    width : '70',
                    title : '货物型号',
                    field : 'cSkumodel',
                    sortable : true
                }] ],
                toolbar : '#toolbar'
            });
        });


       function addFun() {
           var rows = dataGrid.datagrid('getSelections');
           if(rows != null && rows != ""){
               var data = [];
               for(var i=0;i<rows.length;i++){
                   if(rows.length >0){
                       data.push(rows[i].cId);
                       data.push(rows[i].cName);
                       data.push(rows[i].cWhid);
                       data.push(rows[i].cSkumodel);
                       data.push("");
                       data.push("");
                   }
               }
               window.location.href = '${path }/make/ToDiskExcel?data='+data;
           }else{
               parent.$.messager.alert('提示',"请选择您要导出的数据", 'info');
           }
        }

        function searchFun() {
            dataGrid.datagrid('load', $.serializeObject($('#searchForm')));
        }
        function cleanFun() {
            $('#searchForm input').val('');
            dataGrid.datagrid('load', {});
        }
    </script>
</head>
<body class="easyui-layout" data-options="fit:true,border:false">
<div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
    <form id="searchForm">
        <table>
            <tr>
                <th>货物型号:</th>
                <td><input name="cSkumodel" placeholder="请输入货物型号"/></td>
                <th>创建时间:</th>
                <td>
                    <input name="createdateStart" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly" />至<input  name="createdateEnd" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly" />
                    <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="searchFun();">查询</a><a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-cancel',plain:true" onclick="cleanFun();">清空</a>
                </td>
            </tr>
        </table>
    </form>

</div>
<div data-options="region:'center',border:true,title:'货物表'" >
    <table id="dataGrid" data-options="fit:true,border:false"></table>
</div>
<div id="toolbar" style="display: none;padding:5px;">
    <shiro:hasPermission name="/allo/insert">
        <a onclick="addFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-folder'">打印调拨单</a>
    </shiro:hasPermission>
</div>
</body>
</html>