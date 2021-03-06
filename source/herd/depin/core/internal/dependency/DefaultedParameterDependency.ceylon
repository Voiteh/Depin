
import herd.depin.core {
	log,
	Dependency
}
import ceylon.language.meta.declaration {
	FunctionOrValueDeclaration
}
import herd.depin.core.internal {
	defaulted
}




shared class DefaultedParameterDependency(
	String name,
	TypeIdentifier identifier,
 	FunctionOrValueDeclaration  declaration,
 	Tree tree
 ) extends ParameterDependency(name,identifier,declaration,tree){
		
	shared actual Anything resolve{
		log.trace("Resolving defaulted parameter dependency: ``identifier``");
		Dependency? dependency=provide;
		if(exists dependency){
			Anything resolve=doResolve(dependency);
			log.debug("[Resolved defaulted parameter dependency]: `` resolve else "null" ``, for type identifier: ``identifier`` and name: ``name``");
			return resolve;
		}
		log.trace("Resolved defaulted parameter dependency: ``defaulted`` for type identifier: ``identifier`` and name ``name``");
		return defaulted;
	}
}