

import herd.depin.core {

	dependency
}
shared class DataSourceConfiguration() {
	
	shared dependency String driverClassName="com.mysql.cj.jdbc.Driver";
	shared dependency String userName="mysqluser";
	shared dependency String password="mysqlpass";
	shared dependency String url="jdbc:mysql://localhost:3306/myDb?createDatabaseIfNotExist=true";
	
}