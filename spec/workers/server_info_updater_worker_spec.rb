require 'spec_helper'

describe ServerInfoUpdaterWorker do

  let(:server) { create :server }
  let(:server_info) { double(:server_info) }

  before do
    Server.should_receive(:find).with(server.id).and_return(server)
    ServerInfo.should_receive(:new).with(server).and_return(server_info)
    allow(ServerMetric).to receive(:new)
  end
  it "gets the server info" do
    server_info.should_receive(:status)
    server_info.should_receive(:get_stats)
    server_info.should_receive(:get_rcon_status)
    ServerInfoUpdaterWorker.perform_async(server.id)
  end

  it "logs an error if something went wrong" do
    server_info.should_receive(:status).and_raise { ArgumentError }

    Rails.logger.should_receive(:warn).with(anything)

    ServerInfoUpdaterWorker.perform_async(server.id)
  end

end


