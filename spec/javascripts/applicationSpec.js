describe("application", function() {

  //This will be called before running each spec
  beforeEach(function() {
    // For executing code before each test described below
    formData = "<div id='test'> Test Data </div>";
    $(document.body).append(formData);
  });

  describe("deleting column", function(){

    //Spec for sum operation
    it("should be able to delete columns ", function() {
      deleteColumn('test');

      expect($('#test').text()).toBe("");
    });
  });
});
