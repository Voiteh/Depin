import ceylon.test {
	test,
	testExtension
}

import herd.depin.engine {
	Depin,
	DefaultScanner,
	log
}

import test.herd.depin.engine.integration.dependency {
	...
}
import test.herd.depin.engine.integration.injection {
	Person,
	DataSource,
	DefaultParametersConstructor,
	DefaultedParametersByFunction,
	DefaultedParameterFunction,
	TargetWithTwoCallableConstructors,
	Nesting,
	AnonymousObjectTarget,
	SingletonTarget,
	PrototypeTarget,
	ExposedTarget
}
import ceylon.language.meta.declaration {
	ValueDeclaration,
	FunctionOrValueDeclaration
}
import herd.depin.api {
	DependencyAnnotation
}
import depin.test.extension {

	LoggingTestExtension
}
import ceylon.logging {

	debug
}

testExtension (`class LoggingTestExtension`)
shared class ClassInjectionTest() {
	
	log.priority=debug;
		
	shared test void shouldInjectJohnPerson(){
			assert(Depin({`value name`,`value age`}).inject(`Person`)==fixture.person.john);
	}
	
	shared test void shouldInjectMysqlDataSource(){
		value select = `class DataSourceConfiguration`.memberDeclarations<ValueDeclaration>()
				.select((ValueDeclaration element) => element.annotated<DependencyAnnotation>());
		assert(Depin(select).inject(`DataSource`)==fixture.dataSouce.mysqlDataSource);
	}
	shared test void shouldInjectNonDefaultParameters(){
		assert(Depin({`value nonDefault`}).inject(`DefaultParametersConstructor`)
			==fixture.defaultParameter.instance);
	}
	shared test void shouldInjectDefaultedParameterFromFunction(){
		assert(Depin({`function defaultedByFunction`}).inject(`DefaultedParametersByFunction`)
			==fixture.defaultedParameterByFunction.instance);
	}
	shared test void shouldInjectDefaultedParameterClassFunction(){
		assert(Depin().inject(`DefaultedParameterFunction`).defaultedFunction()
			==fixture.defaultedParameterFunction.param);
	}
	shared test void shouldInjectTargetedConstructor(){
		assert(Depin({`value something`}).inject(`TargetWithTwoCallableConstructors`).something
			==fixture.targetWithTwoCallableConstructors.param.reversed);
	}
	
	shared test void shouldInjectNestedClass(){
		assert(Depin({`value nesting`,`value nested`}).inject(`Nesting.Nested`)==fixture.nesting.instance);
	}
	shared test void shouldInjectObjectContainedDependencies(){
		value select = `class dependencyHolder`.memberDeclarations<FunctionOrValueDeclaration>()
				.select((FunctionOrValueDeclaration element) => element.annotated<DependencyAnnotation>());
		assert(Depin(select).inject(`AnonymousObjectTarget`).innerObjectDependency
			==fixture.objectDependencies.innerObjectDependency);
	}
	

	
	shared test void shouldInjectExposedInterface(){
		value declarations=DefaultScanner().scan({`package test.herd.depin.engine.integration.dependency.unshared`});
		assert(Depin(declarations).inject(`ExposedTarget`).exposing.exposed==fixture.unshared.exposed);
	}
	
	
}