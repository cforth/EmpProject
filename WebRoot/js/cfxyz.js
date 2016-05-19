function validateEmpty(eleName) {
    var obj = document.getElementById(eleName); //取得对象
    var msg = document.getElementById(eleName + "Msg"); //提示信息
    if(obj.value != "") { //进行内容验证
        obj.className = "right";
        msg.innerHTML = "<font color='green'>内容输入正确！</font>";
        return true ;
    } else {
        obj.className = "wrong";
        msg.innerHTML = "<font color='red'>内容为空！</font>";
        return false ;
    }
}

function validateRegex(eleName, regex) {
    var obj = document.getElementById(eleName); //取得对象
    var msg = document.getElementById(eleName + "Msg"); //提示信息
    if(regex.test(obj.value)) { //进行内容验证
        obj.className = "right";
        msg.innerHTML = "<font color='green'>内容输入正确！</font>";
        return true ;
    } else {
        obj.className = "wrong";
        msg.innerHTML = "<font color='red'>内容输入错误！</font>";
        return false ;
    }
}

function changColor(obj, color) {
	obj.bgColor = color;
}

function checkboxSelect(obj, eleName) {
	var item = document.all(eleName);
	if(item.length == undefined){ //表示只有一个元素。不是数组
		document.getElementById(eleName).checked = obj.checked ;
	} else {
		for(var i =0; i<item.length; i++) {
			item[i].checked = obj.checked ;
		}
	}
}

//url表示要删除的操作路径
//paramName表示要传递的参数名称
//eleName表示要取得数据的ID名称
function deleteAll(url, paramName, eleName) {
	var data = ""; //保存所有要删除的数据编号
	//但是数据有可能是数组，也有可能只有一个
	var item = document.all(eleName);
	var count = 0 ; //保存要删除的数据个数
	//要判断是否有要删除的数据
	if(item.length == undefined){ //表示只有一个元素。不是数组
		if(document.getElementById(eleName).checked == true) {//表示被选中
			data += document.getElementById(eleName).value;
			count++;
		}
	} else {
		for(var x = 0; x < item.length; x++) {
			if(item[x].checked == true) {
				count++;
				data += item[x].value + "|";
			}
		}
	}
	if(count > 0) { //有要删除的数据
		if(window.confirm("确定要删除这些数据吗？")) {
			window.location = url + "&" + paramName + "=" + data ;
		}
	} else {
		alert("您还未选择任何要删除的数据！");
	}
}

function openPage(url) {
	window.open(url, "查看详细信息", "width=600;height=500;scollable=yes")
}

function closePage() {
	window.close();
}

//修改验证码
function changeCode(obj) {
	obj.src = "pages/image.jsp?tm=" + Math.random();
}