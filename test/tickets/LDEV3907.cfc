component extends="org.lucee.cfml.test.LuceeTestCase" labels="orm"{
	function beforeAll(){
		variables.uri = createURI("LDEV3907");
	}

	function run( testResults, testBox ) {
		describe("Testcase for LDEV-3907", function() {
			it( title="updating the primary key in ORM entity and then accessing after saving", body=function( currentSpec ) {
				try {
					local.result = _InternalRequest(
						template : "#uri#\LDEV3907.cfm"
					).filecontent;  // Row was updated or deleted by another transaction (or unsaved-value mapping was incorrect) : [brand#]
				}
				catch(any e) {
					result = e.message;
				}
				expect(trim(result)).toBe("LDEV3907");
			});

			it( title="updating any value in the ORM entity and then accesssing after an ormsave", body=function( currentSpec ) {
				try {
					local.result = _InternalRequest(
						template : "#uri#\LDEV3907.cfm",
						url: {
							pk: false
						} 
					).filecontent; //  Row was updated or deleted by another transaction (or unsaved-value mapping was incorrect) : [brand#1]
				}
				catch(any e) {
					result = e.message;
				}
				expect(trim(result)).toBe("LDEV3907");
			});
		});
	}

	private string function createURI(string calledName) {
		var baseURI = "/test/#listLast(getDirectoryFromPath(getCurrenttemplatepath()),"\/")#/";
		return baseURI&""&calledName;
	}
}
