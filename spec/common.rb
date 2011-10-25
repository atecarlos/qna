module Common

  def mock_sign_in_with(user)
    controller.request.env['warden'] = mock(Warden, :authenticate => user, :authenticate! => user)
  end

  def mock_decent_exposure_model(name, stubs)
  	model = mock_model(name, stubs)
  	model.stub!(:attributes=)
  	model
  end

end