import ceylon.test {
	testExtension
}
import depin.test.extension {
	LoggingTestExtension
}

testExtension (`class CoreLogPriorityTestExtension`)
testExtension (`class LoggingTestExtension`)
module test.herd.depin.core "SNAPSHOT" {
	import ceylon.test "1.3.3";
	shared import herd.depin.core "0.2.0";
	shared import depin.test.extension "0";
}
