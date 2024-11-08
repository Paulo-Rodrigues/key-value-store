describe MicroRedis::Application do
  context 'initializes the storage' do
    it 'returns empty' do
      redis = described_class.new

      expect(redis.storage).to match({})
      expect(redis.storage).to be_empty
    end
  end

  context '#GET' do
    let(:redis) { described_class.new }

    it 'return nil if key not found' do
      expect(redis.get('any_key')).to be_nil
    end

    it 'return value from the key' do
      redis.set(:key, 'value')

      expect(redis.get(:key)).to eq('value')
    end
  end

  context '#SET' do
    let(:redis) { described_class.new }

    it 'set a key value pair' do
      redis.set(:key, 'value')

      expect(redis.exists?(:key)).to be_truthy
    end

    it 're set a value to a existing key' do
      redis.set(:key, 'value1')
      expect(redis.get(:key)).to eq('value1')

      redis.set(:key, 'value2')
      expect(redis.get(:key)).to eq('value2')

      expect(redis.size).to eq(1)
    end
  end

  context '#DEL' do
    let(:redis) { described_class.new }

    it 'delete the key value pair and return them' do
      redis.set(:key, 'value')
      redis.del(:key)

      expect(redis.exists?(:key)).to be_falsey
    end
  end

  context '#size' do
    let(:redis) { described_class.new }

    it 'get the size of the storage' do
      expect(redis.size).to eq(0)

      redis.set(:key, 'value')
      expect(redis.size).to eq(1)

      redis.set(:key2, 'value')
      expect(redis.size).to eq(2)
    end
  end

  context '#exists?' do
    let(:redis) { described_class.new }

    it 'return true if key in storage' do
      redis.set(:key, 1)

      expect(redis.exists?(:key)).to be_truthy
    end

    it 'return false if key not in storage' do
      expect(redis.exists?(:key)).to be_falsey
    end
  end

  context '#not_exists?' do
    let(:redis) { described_class.new }

    it 'return false if key in storage' do
      redis.set(:key, 1)

      expect(redis.not_exists?(:key)).to be_falsey
    end

    it 'return true if key not in storage' do
      expect(redis.not_exists?(:key)).to be_truthy
    end
  end

  context '#type' do
    let(:redis) { described_class.new }

    it 'return the type of the value stored' do
      redis.set(:key, 1)
      redis.set(:key2, 'value')
      redis.set(:key3, 2.3)

      expect(redis.type(:key)).to be(Integer)
      expect(redis.type(:key2)).to be(String)
      expect(redis.type(:key3)).to be(Float)
    end
  end

  context '#len' do
    let(:redis) { described_class.new }

    it 'return the length of a string value' do
      redis.set(:key, 'value')

      expect(redis.len(:key)).to eq(5)
    end

    it 'return an error if vaalue is not a string' do
      redis.set(:key, 1)

      expect { redis.len(:key) }.to raise_error(TypeError)
    end
  end

  context '#incr' do
    let(:redis) { described_class.new }

    it 'increment by 1 if value is integer' do
      redis.set(:key, 1)
      redis.incr(:key)

      expect(redis.get(:key)).to eq(2)
    end

    it 'cannot increment if value is not integer' do
      redis.set(:key, 'value')

      expect { redis.incr(:key) }.to raise_error(TypeError)
    end
  end

  context '#decr' do
    let(:redis) { described_class.new }

    it 'decrement by 1 if value is integer' do
      redis.set(:key, 2)
      redis.decr(:key)

      expect(redis.get(:key)).to eq(1)
    end

    it 'cannot decrement if value is not integer' do
      redis.set(:key, 'value')

      expect { redis.decr(:key) }.to raise_error(TypeError)
    end
  end

  context '#incr_by' do
    let(:redis) { described_class.new }

    it 'increment by 2 if value is integer' do
      redis.set(:key, 1)
      redis.incr_by(:key, 2)

      expect(redis.get(:key)).to eq(3)
    end

    it 'cannot increment if value is not integer' do
      redis.set(:key, 'value')

      expect { redis.incr_by(:key, 2) }.to raise_error(TypeError)
    end
  end

  context '#decr_by' do
    let(:redis) { described_class.new }

    it 'decrement by 2 if value is integer' do
      redis.set(:key, 4)
      redis.decr_by(:key, 2)

      expect(redis.get(:key)).to eq(2)
    end

    it 'cannot decrement if value is not integer' do
      redis.set(:key, 'value')

      expect { redis.decr(:key) }.to raise_error(TypeError)
    end
  end

  context '#keys' do
    let(:redis) { described_class.new }

    it 'return an array of keys stored' do
      redis.set(:key, 4)
      redis.set(:key2, 3)
      redis.set(:key3, 'bla')

      expect(redis.keys).to match(%i[key key2 key3])
    end
  end
end
