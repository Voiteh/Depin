import herd.depin.core {

	Collector,
	subtype
}
import test.herd.depin.core.integration.injection.collector {

	Collectable
}
shared class SubtypeCollectorInjection(shared subtype Collector<Collectable> collector){}