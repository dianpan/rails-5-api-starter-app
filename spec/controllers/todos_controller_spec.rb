require 'rails_helper'

RSpec.describe TodosController, type: :controller do
  let(:valid_attributes) do
    { title: 'learn elm', created_by: 'Foo' }
  end

  let(:invalid_attributes) do
    { something: 'anything' }
  end

  describe "GET #index" do
    let!(:todo) { Todo.create! valid_attributes }
    before { get :index }

    it 'returns todos' do
      expect(JSON.parse(response.body).length).to eq 1
    end

    it "returns a success response" do
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    let(:todo) { Todo.create! valid_attributes }

    context 'when the record exists' do
      before { get :show, params: { id: todo.to_param } }

      it 'returns the todo' do
        expect(JSON.parse(response.body)['id']).to eq todo.id
      end

      it "returns a success response" do
        expect(response).to be_success
      end
    end

    context 'when record does not exist' do
      before { get :show, params: { id: 100} }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to eq "Couldn't find Todo with 'id'=100"
      end
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Todo" do
        expect {
          post :create, params: {todo: valid_attributes}
        }.to change(Todo, :count).by(1)
      end

      it "renders a JSON response with the new todo" do
        post :create, params: {todo: valid_attributes}
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(todo_url(Todo.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new todo" do
        post :create, params: {todo: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { created_by: 'Bar' }
      }

      it "updates the requested todo" do
        todo = Todo.create! valid_attributes
        put :update, params: {id: todo.to_param, todo: new_attributes}
        todo.reload
        expect(response).to have_http_status(:ok)
        expect(todo.created_by).to eq 'Bar'
      end

      it "renders a JSON response with the todo" do
        todo = Todo.create! valid_attributes

        put :update, params: {id: todo.to_param, todo: valid_attributes}
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "DELETE #destroy" do
    let(:todo) { Todo.create! valid_attributes }

    it 'returns status code 204 no content' do
      delete :destroy, params: {id: todo.to_param}
      expect(response).to have_http_status(:no_content)
    end

    it "destroys the requested todo" do
      todo = Todo.create! valid_attributes
      expect {
        delete :destroy, params: {id: todo.to_param}
      }.to change(Todo, :count).by(-1)
    end
  end

end
