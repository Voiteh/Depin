import ceylon.test {
	testExtension,
	test
}
import depin.test.extension {

	LoggingTestExtension
}
import test.herd.depin.core.integration.newstructure.injection.clazz.injection {

	ClassInjection
}
import test.herd.depin.core.integration.newstructure.injection.clazz.dependency {

	ClassDependency
}
import herd.depin.core {

	Depin
}

testExtension (`class LoggingTestExtension`)
shared class SunnyClassInjectionTest() {
	
	
	
	shared test void whenProvidedConcreteClassDependencyWithItsDepdendencies_then_shouldInjectItToClassInjection(){
		value inject = Depin({`class ClassDependency`,`value fixture.classParam`})
		.inject(`ClassInjection`);
		assert(inject.classDependency.classParam==fixture.classParam);		
	}
	
	
}