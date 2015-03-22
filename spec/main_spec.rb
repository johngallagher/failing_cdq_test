class Entry < CDQManagedObject
end

describe "Application 'failing_cdq_test'" do
  before do
    class << self
      include CDQ
    end

    cdq.setup
  end

  after do
    cdq.reset!
  end

  it 'accurately sets startedAt for even seconds' do
    Entry.create(startedAt: Time.new(2014, 6, 2, 0, 0, 0)).startedAt.should == Time.new(2014, 6, 2, 0, 0, 0)
    Entry.create(startedAt: Time.new(2014, 6, 2, 0, 0, 2)).startedAt.should == Time.new(2014, 6, 2, 0, 0, 2)
  end

  it 'accurately sets startedAt for odd seconds' do
    Entry.create(startedAt: Time.new(2014, 6, 2, 0, 0, 1)).startedAt.should == Time.new(2014, 6, 2, 0, 0, 1)
    Entry.create(startedAt: Time.new(2014, 6, 2, 0, 0, 3)).startedAt.should == Time.new(2014, 6, 2, 0, 0, 3)
  end

  it 'accurately sets startedAt for even seconds for NSDates' do
    Entry.create(startedAt: gmt_formatter.dateFromString("01/06/2014 23:00:00 GMT")).startedAt.should == gmt_formatter.dateFromString("01/06/2014 23:00:00 GMT")
    Entry.create(startedAt: gmt_formatter.dateFromString("01/06/2014 23:00:02 GMT")).startedAt.should == gmt_formatter.dateFromString("01/06/2014 23:00:02 GMT")
  end

  it 'accurately sets startedAt for odd seconds for NSDates' do
    Entry.create(startedAt: gmt_formatter.dateFromString("01/06/2014 23:00:01 GMT")).startedAt.should == gmt_formatter.dateFromString("01/06/2014 23:00:01 GMT")
    Entry.create(startedAt: gmt_formatter.dateFromString("01/06/2014 23:00:03 GMT")).startedAt.should == gmt_formatter.dateFromString("01/06/2014 23:00:03 GMT")
  end
end

def gmt_formatter
  formatter = NSDateFormatter.alloc.init
  formatter.setDateFormat("dd/MM/yyyy HH:mm:ss z")
  formatter
end
