import ceylon.test {

	testExtension,
	test
}
import depin.test.extension {

	LoggingTestExtension
}
import herd.depin.core {

	scanner
}
import test.herd.depin.engine.integration.dependency {
	ExtendingClass
}
import test.herd.depin.engine.integration.scannable {

	Scannable,
	Scanned
}
import test.herd.depin.engine.integration.scannable.excluded {

	Excluded
}

testExtension (`class LoggingTestExtension`)
shared class ScannerSunnyTest(){
	
	
	
	shared test void shouldScannInhertiedDependencies(){
		value result=scanner.dependencies({`class ExtendingClass`});
		assert(result.contains(`value ExtendingClass.name`));
		assert(result.contains(`value ExtendingClass.age`));
	}
	shared test void whenScannedInSearchOfInterfaceSatisfingDeclarations_shouldFindSingleClass(){
		value result=scanner.subtypeDependencies(`interface Scannable`,{`module`},{`class Excluded`});
		assert(result.size==1);
	}
	shared test void whenScannedInSearchOfClassExteingDeclarations_shouldFind2Classes(){
		value result=scanner.subtypeDependencies(`class Scanned`,{`module`},{`class Excluded`});
		assert(result.size==2);
	}
}
