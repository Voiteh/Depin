import ceylon.language.meta.declaration {
	NestableDeclaration,
	FunctionOrValueDeclaration,
	ConstructorDeclaration,
	CallableConstructorDeclaration,
	ValueConstructorDeclaration
}
import ceylon.language.meta.model {
	ClassModel,
	Type
}

import herd.depin.api {
	Injection,
	Dependency
}
import herd.depin.engine {
	TargetSelector,
	log
}
import herd.depin.engine.dependency {
	DependencyFactory
}
shared class InjectionFactory(DependencyFactory dependencyFactory,TargetSelector selector) {
	shared Injection create(ClassModel<Object> model) {
	
		ConstructorDeclaration constructorDeclaration = selector.select(model.declaration);

		switch(constructorDeclaration)
		case(is ValueConstructorDeclaration){
			if(is NestableDeclaration containerDeclaration=model.declaration.container){
				assert(is Type<Object> containerType=model.container);
				value constructor=constructorDeclaration.memberApply<Nothing,Object>(containerType);
				value containerDependency=dependencyFactory.create(containerDeclaration, false);
				 value memberValueInjection = MemberValueInjection(constructor, containerDependency);
				 log.debug("Created member value injection: ``memberValueInjection`` with container dependency:``containerDependency``");
				 return memberValueInjection;
			}
			value constructor=constructorDeclaration.apply<Object>();
			value valueConstructorInjection = ValueConstructorInjection(constructor);
			log.debug("Created  value constructor injection: ``valueConstructorInjection``");
			return valueConstructorInjection;
		}
		case(is CallableConstructorDeclaration){
			if(is NestableDeclaration containerDeclaration=model.declaration.container){
				assert(is Type<Object> containerType=model.container);
				value constructor=constructorDeclaration.memberApply<>(containerType, *model.typeArgumentList);
				value containerDependency=dependencyFactory.create(containerDeclaration, false);
				{Dependency*} parameters=constructor.declaration.parameterDeclarations.collect((FunctionOrValueDeclaration element) => dependencyFactory.create(element,true));
				 value memberCallableConstructorInjection = MemberCallableConstructorInjection(constructor, containerDependency,parameters);
				 log.debug("Created member  callable constructor injection: ``memberCallableConstructorInjection`` with container dependency: ``containerDependency``, using parameters: ``parameters``");
				 return memberCallableConstructorInjection;
			}
			value constructor=constructorDeclaration.apply<Object>(*model.typeArgumentList);
			{Dependency*} parameters=constructor.declaration.parameterDeclarations.collect((FunctionOrValueDeclaration element) => dependencyFactory.create(element,true));
			value callableConstructorInjection = CallableConstructorInjection(constructor, parameters);
			log.debug("Created  callable constructor injection: ``callableConstructorInjection``, using parameters: ``parameters``");
			return callableConstructorInjection;
		}
	
		else{
			throw Exception("unsupported injection for``model``"); 
		}
		
		
	}
	


	
}