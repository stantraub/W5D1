class HashSet
  attr_accessor :store, :count
  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    return false if include?(key)
    @store[key.hash % @store.length] << key
    @count += 1

    resize! if count > @store.length
    key
  end

  def include?(key)
    @store[key.hash % @store.length].include?(key)
  end

  def remove(key)
    if self.include?(key)
      store[key.hash % @store.length].delete(key)
      @count -= 1
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    current = @store
    @count = 0

    @store = Array.new(@store.length * 2) {Array.new}

    current.flatten.each do |ele|
      insert(ele)
    end
  end
end
