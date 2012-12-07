<% module_namespacing do -%>
class <%= controller_class_name %>Controller < ApplicationController
  load_and_authorize_resource

  def index
    @<%= plural_table_name %> = <%= class_name %>.paginate(page: params[:page])

    respond_to do |format|
      format.html
      format.json { render json: <%= "@#{plural_table_name}" %> }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: <%= "@#{singular_table_name}" %> }
    end
  end

  def new
    respond_to do |format|
      format.html
      format.json { render json: <%= "@#{singular_table_name}" %> }
    end
  end

  def create
    respond_to do |format|
      if @<%= orm_instance.save %>
        format.html { redirect_to @<%= singular_table_name %>, notice: t('tj.succeeded') }
        format.json { render json: <%= "@#{singular_table_name}" %>, status: :created, location: <%= "@#{singular_table_name}" %> }
      else
        format.html { render action: "new" }
        format.json { render json: <%= "@#{orm_instance.errors}" %>, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @<%= orm_instance.update_attributes("params[:#{singular_table_name}]") %>
        format.html { redirect_to @<%= singular_table_name %>, notice: t('tj.succeeded') }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: <%= "@#{orm_instance.errors}" %>, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @<%= orm_instance.destroy %>

    respond_to do |format|
      format.html { redirect_to <%= index_helper %>_url }
      format.json { head :no_content }
    end
  end
end
<% end -%>