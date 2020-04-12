

import test.herd.depin.core.integration {
	fixture
}
import test.herd.depin.core.integration.dependency {
	Interface
}
import herd.depin.core {

	dependency
}
class UnsharedDependency() satisfies Interface{
	shared actual String exposed = fixture.unshared.exposed;
	
}

dependency Interface exposing=UnsharedDependency();