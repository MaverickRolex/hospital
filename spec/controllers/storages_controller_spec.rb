require 'rails_helper'

RSpec.describe StoragesController, type: :controller do

  describe "GET index" do
    it "returns a success response" do
      get :index
      expect(response).to be_success
    end

    it "renders index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "returns storage items list" do
      storage_item = Storage.create(item_name: "New storage item")
      get :index
      expect(assigns(:items)).to include(storage_item)
    end

    it "returns departments list" do
      department = Department.create(dep_name: "New department")
      get :index
      expect(assigns(:departments)).to include(department)
    end
  end

  describe "GET new" do    
    before(:each) do
      user = create(:user, :operational_user)
      sign_in user
    end

    it "returns a success response" do
      get :new
      expect(response).to be_success
    end

    it "renders new form template" do
      get :new
      expect(response).to render_template("new")
    end

    it "returns a new storage instance" do
      get :new
      expect(assigns(:item)).to be_a(Storage)
    end

    context "validate_permitions before_action" do
      it "doesn't redirect to storages_path when current_user is a sistem_manager" do
        user = create(:user, :system_manager_user)
      sign_in user
        get :new
        expect(response).to render_template("new")
      end

      it "doesn't redirect to storages_path when current_user belongs to storage department" do
        user = create(:user, :storage_user)
      sign_in user
        get :new
        expect(response).to render_template("new")
      end

      it "redirects to storages_path when current_user isn't a system_manager or storage department" do
        user = create(:user, :generic_user)
      sign_in user
        get :new
        expect(response).to redirect_to(storages_path)
      end
    end
  end

  describe "POST create" do
    it "creates a new storage item" do
      expect { post :create, storage: { item_name: "New Storage Item" } }.
          to change { Storage.count }.from(0).to(1)
    end

    it "redirects to storages_path" do
      post :create, storage: { item_name: "New Storage Item" }
      expect(response).to redirect_to(storages_path)
    end

    context "params[:storage]" do
      it "saves a new storage item" do
        expect { post :create, storage: { item_name: "New Storage Item" } }.
          to change { Storage.count }.from(0).to(1)
      end

      it "raises error when not present" do
        expect { post :create }.
          to raise_error(ActionController::ParameterMissing)
      end
    end
  end

  describe "GET show" do
    before(:each) do
      @item = Storage.create(item_name: "New Storage Item")
    end

    it "returns a success response" do
      get :show, id: @item.id
      expect(response).to be_success
    end
    
    it "returns department list" do
      department = Department.create(dep_name: "New department")
      get :show, id: @item.id
      expect(assigns(:departments)).to include(department)
    end

    it "renders the show template" do
      get :show, id: @item.id
      expect(response).to render_template("show")
    end

    context "params[:id]" do
      it "returns a storage item" do
        get :show, id: @item.id
        expect(assigns(:item)).to be_a(Storage)
      end

      it "raises error when not present" do
        expect { get :show }.to raise_error(ActionController::UrlGenerationError)
      end

      it "raises error when not match" do
        expect { get :show, id: "no id" }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it "raises error when not found" do
        expect { get :show, id: 100 }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "GET edit" do
    before(:each) do
      user = create(:user, :operational_user)
      sign_in user
      @item = Storage.create(item_name: "New Storage Item")
    end

    it "returns a success response" do
      get :edit, id: @item.id
      expect(response).to be_success
    end

    it "renders the edit template" do
      get :edit, id: @item.id
      expect(response).to render_template("edit")
    end

    context "validate_permitions before_action" do
      it "doesn't redirect to storages_path when current_user is a sistem_manager" do
        user = create(:user, :system_manager_user)
      sign_in user
        get :edit, id: @item.id
        expect(response).to render_template("edit")
      end

      it "doesn't redirect to storages_path when current_user belongs to storage department" do
        user = create(:user, :storage_user)
      sign_in user
        get :edit, id: @item.id
        expect(response).to render_template("edit")
      end

      it "redirects to storages_path when current_user isn't a system_manager or storage department" do
        user = create(:user, :generic_user)
      sign_in user
        get :edit, id: @item.id
        expect(response).to redirect_to(storages_path)
      end
    end
    
    context "params[:id]" do
      it "returns a storage item" do
        get :edit, id: @item.id
        expect(assigns(:item)).to be_a(Storage)
      end

      it "raises error when not present" do
        expect { get :edit }.to raise_error(ActionController::UrlGenerationError)
      end

      it "raises error when not match" do
        expect { get :edit, id: "no id" }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it "raises error when not found" do
        expect { get :edit, id: 100 }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "PUT update" do
    before(:each) do
      @item = Storage.create(item_name: "New Storage Item")
    end
     
    it "redirects to storages path" do
      put :update, id: @item.id, storage: { item_name: "New Item Name" }
      expect(response).to redirect_to(storages_path)
    end

    context "params[:storage]" do
      it "updates a storage item" do
        expect { put :update, id: @item.id, storage: { item_name: "New Item Name" } }.
          to change { @item.reload.item_name }.from("New Storage Item").to("New Item Name")
      end

      it "raises error when storage params not present" do
        expect { put :update, id: @item.id }.to raise_error(ActionController::ParameterMissing)
      end
    end

    context "params[:id]" do
      it "returns a storage item" do
        put :update, id: @item.id, storage: { item_name: "New Item Name" }
        expect(assigns(:item)).to be_a(Storage)
      end

      it "raises error when not present" do
        expect { put :update }.to raise_error(ActionController::UrlGenerationError)
      end

      it "raises error when not match" do
        expect { put :update, id: "no id" }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it "raises error when not found" do
        expect { put :update, id: 100 }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "DELETE destroy" do
    before(:each) do
      user = create(:user, :operational_user)
      sign_in user
      @item = Storage.create( item_name: "New Storage Item")
    end

    it "destroy a storage item" do
      expect { delete :destroy, id: @item.id }.
        to change { Storage.count }.from(1).to(0)
    end

    it "redirects to storages_path" do
      delete :destroy, id: @item.id
      expect(response).to redirect_to(storages_path)
    end

    context "validate_permitions before_action" do
      it "doesn't redirect to storages_path when current_user is a sistem_manager" do
        user = create(:user, :system_manager_user)
        sign_in user
        delete :destroy, id: @item.id
        expect(response).to redirect_to(storages_path)
      end

      it "doesn't redirect to storages_path when current_user is belongs to storage department" do
        user = create(:user, :storage_user)
        sign_in user
        delete :destroy, id: @item.id
        expect(response).to redirect_to(storages_path)
      end

      it "redirects to storages_path when current_user isn't a system_manager or storage department" do
        user = create(:user, :generic_user)
        sign_in user
        delete :destroy, id: @item.id
        expect(response).to redirect_to(storages_path)
      end
    end

    context "params[:id]" do
      it "returns a storage item" do
        delete :destroy, id: @item.id
        expect(assigns(:item)).to be_a(Storage)
      end

      it "destroys a storage item reccord in database" do
        expect { delete :destroy, id: @item.id }.
          to change { Storage.count }.from(1).to(0)
      end

      it "raises error when not present" do
        expect { delete :destroy }.to raise_error(ActionController::UrlGenerationError)
      end

      it "raises error when not match" do
        expect { delete :destroy, id: "no id" }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it "raises error when not found" do
        expect { delete :destroy, id: 100 }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

end
