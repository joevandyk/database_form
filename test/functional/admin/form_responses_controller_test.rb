require File.dirname(__FILE__) + '/../../test_helper'

# Re-raise errors caught by the controller.
Admin::FormResponsesController.class_eval { def rescue_action(e) raise e end }

class Admin::FormResponsesControllerTest < Test::Unit::TestCase
  fixtures :form_responses, :form_files
  test_helper :login

  def setup
    @controller = Admin::FormResponsesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    login_as :existing
  end

  def test_index
    get :index
    assert_response :success
    assert_template 'index'
    assert_not_nil assigns(:filter)
    assert_not_nil assigns(:form_names)
  end

  def test_export_xml
    post :export, :commit => "Export as XML"
    assert_response :success
    assert_match 'application/xml', @response.headers['type']
    assert_select 'form-responses'
  end

  def test_export_xml_filter
    post :export, :commit => "Export as XML", :filter => { :name => 'contact' }
    assert_response :success
    assert_match '<name>nap</name', @response.body
    assert_select 'name', :text => 'ian'
    assert_select 'name', :text => 'inforequest', :count => 0
  end
  
  def test_export_html
    post :export, :commit => "View online"
    assert_response :success
    assert_match 'text/html', @response.headers['type']
    assert_select 'table'
  end

  def test_export_xml_filter
    post :export, :commit => "View online", :filter => { :name => 'contact' }
    assert_response :success
    assert_match '<td>nap</td', @response.body
    assert_select 'table td', :text => 'ian'
    assert_select 'table td', :text => 'inforequest', :count => 0
  end
  
  def test_export_uploads
    post :export, :commit => "View online", :filter => { :name => 'fileupload' }
    assert_response :success
    assert_select 'table td', :text => 'Attachment', :count => 2
    assert_select 'table td', :text => 'testfile1.txt'
  end
  
end
