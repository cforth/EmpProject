function validateDeptno() {
	return validateEmpty("deptno") ;
}

function validateDname() {
	return validateEmpty("dname") ;
}

function validateLoc() {
	return validateEmpty("loc") ;
}

function validateInsert() {
	return validateDeptno() && validateDname() && validateLoc();
}

function validateUpdate() {
	return validateDname() && validateLoc();
}