import ceylon.test {
	testExtension,
	test
}
import depin.test.extension {
	LoggingTestExtension
}
import test.herd.depin.core.integration.newstructure.injection.\ifunction.dependency {
	topLevelFunction,
	topLevelFunctionWithParameter,
	someString
}
import herd.depin.core {
	Depin
}
import test.herd.depin.core.integration.newstructure.injection.\ifunction.injection {
	topLevelInjection,
	topLevelInjectionForFunctionWithParameter,
	factoryInjection
}

testExtension (`class LoggingTestExtension`)
shared class SunnyFunctionInjectionTest() {
	
	shared test void whenProvidedTopLevelFunction_then_shouldInjectItToInjection(){
		Depin({`function topLevelFunction`}).inject(`topLevelInjection`);
	}

	shared test void whenProvidedTopLevelDefaultedFunction_then_shouldInjectDefaultedParameterFromFunction(){
		Depin({`function topLevelFunctionWithParameter`}).inject(`topLevelInjectionForFunctionWithParameter`);
		
	}	
	
	shared test void whenProvidedFactoryFunction_then_shouldInjectItsResult(){
		Depin({`function someString`}).inject(`factoryInjection`);
	}
}