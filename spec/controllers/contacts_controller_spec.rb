require 'rails_helper'

describe ContactsController do
  # describe "administrator access" doo
    let(:contact) do
      create(:contact, firstname: 'Lawrence', lastname: 'Smith')
    end

    shared_examples_for 'public access to contacts' do
      describe 'GET #index' do
        context 'with params[:letter]' do
          it "populates an array of contacts starting with the letter" do
            smith = create(:contact, lastname: 'Smith')
            jones = create(:contact, lastname: 'Jones')
            get :index, letter: 'S'
            expect(assigns(:contacts)).to match_array([smith])
          end

          it "renders the :index template" do
            get :index, letter: 'S'
            expect(response).to render_template :index
          end
        end

        context 'without params[:letter]' do
          it "populates an array of all contacts" do
            smith = create(:contact, lastname: 'Smith')
            jones = create(:contact, lastname: 'Jones')
            get :index
            expect(assigns(:contacts)).to match_array([smith, jones])
          end

          it "renders the :index template" do
            get :index
            expect(response).to render_template :index
          end
        end
      end

      describe 'GET #show' do
        # let(:contact) { build_stubbed(:contact,
        #   firstname: 'Lawrence', lastname: 'Smith') }
        
        # before :each do
        #   allow(Contact).to receive(:persisted?).and_return(true)
        #   allow(Contact).to \
        #     receive(:order).with('lastname, firstname').and_return([contact])
        #   allow(Contact).to \
        #     receive(:find).with(contact.id.to_s).and_return(contact)
        #   allow(Contact).to receive(:save).and_return(true)
          
        #   get :show, id: contact
        # end

        it "assigns the requested contact to @contact" do
          # contact = create(:contact)
          get :show, id: contact
          expect(assigns(:contact)).to eq contact
        end

        it "renders the :show template" do
          # contact = create(:contact)
          get :show, id: contact
          expect(response).to render_template :show
        end
      end
    end
    # este cierra linea 10 shared_examples_for 'public access to contacts'

  shared_examples 'full access to contacts' do
    describe 'GET #new' do
      it "assigns a new Contact to @contact" do
        get :new
        expect(assigns(:contact)).to be_a_new(Contact)
      end

      it "assigns a home, office, and mobile phone to the new contact" do
        get :new
        phones = assigns(:contact).phones.map do |p|
          p.phone_type
        end
        expect(phones).to match_array %w(home office mobile)
      end

      it "renders the :new template" do
        get :new
        expect(response).to render_template :new
      end
    end

    describe 'GET #edit' do
      it "assigns the requested contact to @contact" do
        contact = create(:contact)
        get :edit, id: contact
        expect(assigns(:contact)).to eq contact
      end

      it "renders the :edit template" do
        contact = create(:contact)
        get :edit, id: contact
        expect(response).to render_template :edit
      end
    end

    describe "POST #create" do
      before :each do
        @phones = [
          attributes_for(:phone),
          attributes_for(:phone),
          attributes_for(:phone)
        ]
      end

      context "with valid attributes" do
        it "saves the new contact in the database" do
          expect{
            post :create, 
            contact: attributes_for(
              :contact,
              phones_attributes: @phones
            )
          }.to change(Contact, :count).by(1)
        end

        it "redirects to contacts#show" do
          post :create, contact: attributes_for(:contact,
            phones_attributes: @phones)
          expect(response).to redirect_to contact_path(assigns[:contact])
        end
      end

      context "with invalid attributes" do
        it "does not save the new contact in the database" do
          expect{
            post :create,
            contact: attributes_for(:invalid_contact)
          }.not_to change(Contact, :count)
        end

        it "re-renders the :new template" do
          post :create,
            contact: attributes_for(:invalid_contact)
          expect(response).to render_template :new
        end
      end
    end
  
    describe 'PATCH #update' do
      before :each do
        @contact = create(:contact,
          firstname: 'Lawrence',
          lastname: 'Smith')
      end

      context "valid attributes" do
        it "locates the requested @contact" do
          patch :update, id: @contact, contact: attributes_for(:contact)
          expect(assigns(:contact)).to eq(@contact)
        end

        it "changes @contact's attributes" do
          patch :update, 
          id: @contact,
          contact: attributes_for(:contact,
            firstname: 'Larry',
            lastname: 'Smith'
          )
          @contact.reload
          expect(@contact.firstname).to eq('Larry')
          expect(@contact.lastname).to eq('Smith')
        end

        it "redirects to the updated contact" do
          patch :update, id: @contact, contact: attributes_for(:contact)
          expect(response).to redirect_to @contact
        end
      end

      context "with invalid attributes" do
        it "locates the requested @contact" do
          patch :update, id: @contact, contact: attributes_for(:invalid_contact)
          expect(assigns(:contact)).to eq @contact
        end

        it "does not change the contact's attributes" do
          patch :update, id: @contact,
          contact: attributes_for(:contact,
            firstname: 'Larry',
            lastname: nil)
          @contact.reload
          expect(@contact.firstname).not_to eq('Larry')
          expect(@contact.lastname).to eq('Smith')
        end

        it "re-renders the :edit template" do
          patch :update, id: @contact,
          contact: attributes_for(:invalid_contact)
          expect(response).to render_template :edit
        end
      end
    end

    describe 'DELETE #destroy' do
      # before :each do
      #   @contact = create(:contact)
      # end

      it "deletes the contact" do
        contact
        expect{
          delete :destroy, id: contact
        }.to change(Contact,:count).by(-1)
      end

      it "redirects to contacts#index" do
        delete :destroy, id: contact
        expect(response).to redirect_to contacts_url
      end
    end
  end 
  # end

  describe "administrator access" do
    # before :each doo
    #   user = create(:admin)
    #   session[:user_id] = user.id
    # end

    before :each do
      set_user_session create(:admin)
    end

    it_behaves_like 'public access to contacts'
    it_behaves_like 'full access to contacts'
  end

  describe "user access" do
    # before :each do
    #   user = create(:user)
    #   session[:user_id] = user.id
    # end

    before :each do
      set_user_session create(:user)
    end

    it_behaves_like 'public access to contacts'
    it_behaves_like 'full access to contacts'
  end

  describe "guest access" do
    # GET #index and GET #show examples are the same as those 4
    # administrators and users
    it_behaves_like 'public access to contacts'

    describe 'GET #new' do
      it "requires login" do
        get :new
        # expect(response).to redirect_to login_url
        expect(response).to require_login
      end
    end
    
    describe 'GET #edit' do
      it "requires login" do
        contact = create(:contact)
        get :edit, id: contact
        # expect(response).to redirect_to login_url
        expect(response).to require_login
      end
    end
    
    describe "POST #create" do
      it "requires login" do
        post :create, id: create(:contact),
        contact: attributes_for(:contact)
        # expect(response).to redirect_to login_url
        expect(response).to require_login
      end
    end
    
    describe 'PATCH #update' do
      it "requires login" do
        put :update, id: create(:contact),
        contact: attributes_for(:contact)
        # expect(response).to redirect_to login_url
        expect(response).to require_login
      end
    end
    
    describe 'DELETE #destroy' do
      it "requires login" do
        delete :destroy, id: create(:contact)
        # expect(response).to redirect_to login_url
        expect(response).to require_login
      end
    end
  end
end
