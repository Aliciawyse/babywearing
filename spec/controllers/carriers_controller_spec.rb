RSpec.describe CarriersController, type: :controller do


    describe "GET #show" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(302)
      end
    end

    describe "POST #search" do
        it "should return search results" do
        end
      end
  end