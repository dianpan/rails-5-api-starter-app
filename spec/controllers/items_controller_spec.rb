require 'rails_helper'

RSpec.describe ItemsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Item. As you add validations to Item, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ItemsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      item = Item.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      item = Item.create! valid_attributes
      get :show, params: {id: item.to_param}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Item" do
        expect {
          post :create, params: {item: valid_attributes}, session: valid_session
        }.to change(Item, :count).by(1)
      end

      it "renders a JSON response with the new item" do

        post :create, params: {item: valid_attributes}, session: valid_session
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        # expect(response.location).to eq(item_url(Item.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new item" do

        post :create, params: {item: invalid_attributes}, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested item" do
        item = Item.create! valid_attributes
        put :update, params: {id: item.to_param, item: new_attributes}, session: valid_session
        item.reload
        skip("Add assertions for updated state")
      end

      it "renders a JSON response with the item" do
        item = Item.create! valid_attributes

        put :update, params: {id: item.to_param, item: valid_attributes}, session: valid_session
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the item" do
        item = Item.create! valid_attributes

        put :update, params: {id: item.to_param, item: invalid_attributes}, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested item" do
      item = Item.create! valid_attributes
      expect {
        delete :destroy, params: {id: item.to_param}, session: valid_session
      }.to change(Item, :count).by(-1)
    end
  end

end
