require 'rails_helper'

RSpec.describe ItemTransfersController, type: :controller do

  before(:each) do
    @item = create(:storage)
    @dep = create(:department)
  end

  describe "GET index" do
    it "returns a success response" do
      get :index
      expect(response).to be_success
    end

    it "render index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "returns item transactions list" do
      trans = create(:item_transfer, )
      get :index
      expect(assigns(:transfers)).to include(trans)
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

    it "render new form template" do
      get :new
      expect(response).to render_template("new")
    end

    it "returns a new item_transfer instance" do
      get :new
      expect(assigns(:transfer)).to be_a(ItemTransfer)
    end

    it "returns storage item list" do
      get :new
      expect(assigns(:items)).to include(@item)
    end

    it "returns departments list" do
      get :new
      expect(assigns(:departments)).to include(@dep)
    end

    context "validate_permitions before_action" do
      it "doesn't redirect to item_transfers_path when current_user is a sistem_manager" do
        user = create(:user, :system_manager_user)
        sign_in user
        get :new
        expect(response).to render_template("new")
      end

      it "doesn't redirect to item_transfers_path when current_user belonga a storage department" do
        user = create(:user, :storage_user)
        sign_in user
        get :new
        expect(response).to render_template("new")
      end

      it "redirects to item_transfers_path when current_user isn't a system_manager or storage department" do
        user = create(:user, :generic_user)
        sign_in user
        get :new
        expect(response).to redirect_to(item_transfers_path)
      end
    end
  end

  describe "POST create" do
    it "creates a new item transfer" do
      expect { post :create, 
        item_transfer: { item_id: @item.id, origin_dep_id: nil, 
                        destiny_dep_id: @dep.id, quantity: 2 } }.
        to change { ItemTransfer.count }.from(0).to(1)
    end

    it "redirect to item transfers path" do
      post :create, item_transfer:{ item_id: @item.id, origin_dep_id: nil, 
                                    destiny_dep_id: @dep.id, quantity: 2 }
      expect(response).to redirect_to(item_transfers_path)
    end

    context "params[:item_transfer]" do
      it "saves a new item transfer" do
        expect { post :create, 
          item_transfer: { item_id: @item.id, origin_dep_id: nil, 
                          destiny_dep_id: @dep.id, quantity: 2 } }.
          to change { ItemTransfer.count }.from(0).to(1)
      end

      it "raises error when not present" do
        expect { post :create }.
          to raise_error(ActionController::ParameterMissing)
      end
    end
  end

  describe "GET edit" do
    before(:each) do
      @trans = create(:item_transfer)
      user = create(:user, :operational_user)
      sign_in user
    end

    it "returns a success response" do
      get :edit, id: @trans.id
      expect(response).to be_success
    end

    it "render a edit form template" do
      get :edit, id: @trans.id
      expect(response).to render_template("edit")
    end

    it "return storage item list" do
      get :edit, id: @trans.id
      expect(assigns(:items)).to include(@item)
    end

    it "return department list" do
      get :edit, id: @trans.id
      expect(assigns(:departments)).to include(@dep)
    end

    context "params[:id]" do
      it "returns a item transfer" do
        get :edit, id: @trans.id
        expect(assigns(:transfer)).to be_a(ItemTransfer)
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

    context "validate_permitions before_action" do
      it "doesn't redirect to item_transfers_path when current_user is a sistem_manager" do
        user = create(:user, :system_manager_user)
        sign_in user
        get :edit, id: @trans.id
        expect(response).to render_template("edit")
      end

      it "doesn't redirect to item_transfers_path when current_user belonga a storage department" do
        user = create(:user, :storage_user)
        sign_in user
        get :edit, id: @trans.id
        expect(response).to render_template("edit")
      end

      it "redirects to item_transfers_path when current_user isn't a system_manager or storage department" do
        user = create(:user, :generic_user)
        sign_in user
        get :edit, id: @trans.id
        expect(response).to redirect_to(item_transfers_path)
      end
    end
  end

  describe "PUT update" do
    before(:each) do
      @trans = ItemTransfer.create(item_id: @item.id, origin_dep_id: nil, 
                                  destiny_dep_id: @dep.id, quantity: 2)
    end

    it "redirects to item transfers path" do
      put :update, id: @trans.id, item_transfer: { quantity: 9 }
      expect(response).to redirect_to(item_transfers_path)
    end

    context "params[:item_transfer]" do
      it "updates a storage item" do
        new_item = create(:storage) 
        expect { put :update, id: @trans.id, item_transfer: { item_id: new_item.id } }.
          to change { @trans.reload.item_id }.from(@item.id).to(new_item.id)
      end

      it "updates a transfer origin department" do
        new_dep = create(:department) 
        expect { put :update, id: @trans.id, item_transfer: { origin_dep_id: new_dep.id } }.
          to change { @trans.reload.origin_dep_id }.from(nil).to(new_dep.id)
      end

      it "updates a transfer destiny department" do
        new_dep = create(:department)
        expect { put :update, id: @trans.id, item_transfer: { destiny_dep_id: new_dep.id } }.
          to change { @trans.reload.destiny_dep_id }.from(@dep.id).to(new_dep.id)
      end

      it "updates a transfer item quantity" do
        expect { put :update, id: @trans.id, item_transfer: { quantity: 9 } }.
          to change { @trans.reload.quantity }.from(2).to(9)
      end

      it "raises error when storage params not present" do
        expect { put :update, id: @trans.id }.to raise_error(ActionController::ParameterMissing)
      end
    end

    context "params[:id]" do
      it "returns a item transfer" do
        put :update, id: @trans.id, item_transfer: { quantity: 9 }
        expect(assigns(:transfer)).to be_a(ItemTransfer)
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
      @trans = create(:item_transfer)
      user = create(:user, :operational_user)
      sign_in user
    end

    it "destroy a item transfer" do
      expect { delete :destroy, id: @trans.id }.
        to change { ItemTransfer.count }.from(1).to(0)
    end

    it "redirects to item_transfers_path" do
      delete :destroy, id: @trans.id
      expect(response).to redirect_to(item_transfers_path)
    end

    context "validate_permitions before_action" do
      it "doesn't redirect to item_transfers_path when current_user is a sistem_manager" do
        user = create(:user, :system_manager_user)
        sign_in user
        delete :destroy, id: @trans.id
        expect(response).to redirect_to(item_transfers_path)
      end

      it "doesn't redirect to item_transfers_path when current_user belonga a storage department" do
        user = create(:user, :storage_user)
        sign_in user
        delete :destroy, id: @trans.id
        expect(response).to redirect_to(item_transfers_path)
      end

      it "redirects to item_transfers_path when current_user isn't a system_manager or storage department" do
        user = create(:user, :generic_user)
        sign_in user
        delete :destroy, id: @trans.id
        expect(response).to redirect_to(item_transfers_path)
      end
    end

    context "params[:id]" do
      it "returns a item transfer" do
        delete :destroy, id: @trans.id
        expect(assigns(:transfer)).to be_a(ItemTransfer)
      end

      it "destroys a item transfer reccord in database" do
        expect { delete :destroy, id: @trans.id }.
          to change { ItemTransfer.count }.from(1).to(0)
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