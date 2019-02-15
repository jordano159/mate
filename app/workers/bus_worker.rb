class BusWorker
  include Sidekiq::Worker

  def perform(mifal_id)
    mifal = Mifal.find(mifal_id)
    mifal.bus_proposal = mifal.make_bus_proposal
    mifal.save
  end
end
