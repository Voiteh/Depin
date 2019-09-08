
import herd.depin.engine {
	log,
	Dependency
}

import herd.depin.engine.meta {

	invoke,
	safe
}
shared class ValueDependency(
	Dependency.Definition definition,
	Dependency? container
) extends Dependency(definition,container,empty){
	
	
	shared actual Anything resolve {
		if(exists container, exists resolved=container.resolve){
			value result=safe(()=>invoke(definition.declaration, resolved))
				((Throwable error)=>ResolutionError("Resolution failed for ``definition`` with container ``container``"));
			log.debug("Resolved value member dependency ``result else "null"`` for definition ``definition`` and container ``container``");
			return result;
		}
		value result=safe(()=>invoke(definition.declaration))
		((Throwable error) => ResolutionError("Resolution failed for definition ``definition``"));
		log.debug("[Registered] value dependency: ``result else "null"``, for definition: ``definition``");
		return result;
	}
		
}