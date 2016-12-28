<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<%@ include file="/commons/basejs.jsp" %>
<script type="text/javascript">
    $(function() {
    	$("#goP").combobox({
    		
    		url:'${path }/godown/getUser',
    		valueField:"userId",
    		textField:"userName"

    	})

        $('#godownAddForm').form({
            url : '${path }/godown/add',
            onSubmit : function() {
                progressLoad();
                var isValid = $(this).form('validate');
                if (!isValid) {
                    progressClose();
                }
                return isValid;
            },
            success : function(result) {
                progressClose();
                result = $.parseJSON(result);
                if (result.success) {
                    parent.$.modalDialog.openner_dataGrid.datagrid('reload');//之所以能在这里调用到parent.$.modalDialog.openner_dataGrid这个对象，是因为user.jsp页面预定义好了
                    parent.$.modalDialog.handler.dialog('close');
                } else {
                    parent.$.messager.alert('提示', result.msg, 'warning');
                }
            }
        });
        
    });
    
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;">
        <form id="godownAddForm" method="post">
            <table class="grid">
                <tr>
                	<td></td>
                    <td>仓库名字</td>
                    <td><input name="goWhid" type="text" placeholder="请输入仓库名称" class="easyui-validatebox" data-options="required:true" value=""></td>
                </tr>
                <tr>
                	<td></td>
                	<td>管理员</td>
                    <td><input name="goP" placeholder="请输入姓名" class="easyui-validatebox" data-options="required:true"></td>
                </tr>
                <tr>
                	<td></td>
                    <td>仓库容积</td>
                    <td><input name="password" type="number" placeholder="请输入仓库容积" class="easyui-validatebox" data-options="required:true">&nbsp;m³</td>
                </tr>
            </table>
        </form>
    </div>
</div>