// use test spec file name as description to allow navigation from the test results view
describe("my first test", function () {

    it("First test", function(done) {
        expect(true).toBe(true);
        done();
    });
});
