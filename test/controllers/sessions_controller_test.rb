require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'should new' do
    get login_url
    assert_response :success
  end

  test 'should login' do
    post login_url, params: { email: users(:client).email, password: 'secret' }
    assert_equal users(:client).id, controller.send(:cookies).signed[:user_id]
    assert_redirected_to home_url
    assert_equal flash[:notice], 'Successfuly logged in'
  end

  test 'should login(remember me)' do
    post login_url, params: { email: users(:client).email, password: 'secret', remember_me: true }
    assert_equal users(:client).id, controller.send(:cookies).permanent.signed[:user_id]
    assert_redirected_to home_url
    assert_equal flash[:notice], 'Successfuly logged in'
  end

  test 'should fail login' do
    post login_url, params: { email: users(:client).email, password: 'wrong' }
    assert_redirected_to login_url
    assert_equal flash[:notice], 'Invalid email/password combination'
  end

  test 'should logout if logged in' do
    login_as :client
    delete logout_url
    assert controller.send(:cookies).signed[:user_id].nil?, 'Sessions must be empty!'
    assert_redirected_to home_url
    assert_equal flash[:notice], 'Logged out'
  end
end
