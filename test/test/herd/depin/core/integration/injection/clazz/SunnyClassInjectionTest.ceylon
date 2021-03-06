import ceylon.test {
	testExtension,
	test
}
import depin.test.extension {

	LoggingTestExtension
}
import test.herd.depin.core.integration.injection.clazz.injection {...}
import test.herd.depin.core.integration.injection.clazz.dependency {...}
import herd.depin.core {

	Depin,
	DependencyAnnotation,
	scanner
}
import ceylon.language.meta.declaration {

	FunctionOrValueDeclaration
}


shared class SunnyClassInjectionTest() {
	
	
	
	shared test void whenProvidedConcreteClassDependencyWithItsDepdendencies_then_shouldInjectItToClassInjection(){
		value inject = Depin({`class DerivedClassDependency`,`value fixture.classParam`})
		.inject(`NestedClassInjection`);
		assert(inject.derivedClassDependency.classParam==fixture.classParam);		
	}
	shared test void whenProvidedNonDefaultParameterDependency_then_shouldInjectItIntoClassWithDefaultedParameter(){
			value result = Depin({`value nonDefault`}).inject(`ClassWithDefaultedInitializerParameterInjection`);
			assert(result.defaultedParameter ==fixture.defaultParameter.text);
			assert(result.nonDefault ==fixture.defaultParameter.nonDefault);
		
	}
	
	shared test void whenProvidedNoDependecies_then_shouldInjectClassWithDefaualtedParameter(){
		assert(Depin().inject(`ClassWithDefaultedParameterFunctionInjection`).defaultedFunction()
			==fixture.defaultedParameterFunction.param);
	}
	shared test void whenProvidedDependency_shouldInjectTargetedConstructorToClassWithTwoConstructors(){
		assert(Depin({`value something`}).inject(`ClassWithTargetConstructorInjection`).something
			==fixture.targetWithTwoCallableConstructors.param.reversed);
	}
	shared test void whenProvidedDependencyToParentAndMemberClass_then_shouldInjectRequiredDependenciesIntoParentAndMemberClass(){
		assert(Depin({`value nesting`,`value nested`}).inject(`ClassWithMemberClassInjection.MemberClass`).sum==fixture.memberClass.nested+fixture.memberClass.nesting);
	}
	
	shared test void whenProvidedObjectContainedDependencies_then_shouldInjectThemIntoClass(){
		assert(Depin({
			`value dependencyHolder.innerObjectDependency`
		}).inject(`AnonymousObjectTarget`).innerObjectDependency
			==fixture.objectDependencies.innerObjectDependency);
	}
	
	shared test void whenProvidedUnsharedDependencies_then_shouldInjectImplementedInterface(){
		value declarations=scanner.dependencies({`package test.herd.depin.core.integration.injection.clazz.dependency.unshared`});
		assert(Depin(declarations).inject(`ClassWithInterfaceAttribute`).exposing.exposed==fixture.unshared.exposed);
	}
	
}