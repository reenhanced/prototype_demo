Given "AJAX requests do not respond" do
  page.execute_script(%{
    $.mockjax({
      url: '*',
      status: 500,
      responseTime: 400,
      responseText: 'fail',
      log: false
    });
  })
end
