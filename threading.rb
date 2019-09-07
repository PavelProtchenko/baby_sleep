que = Queue.new

producer = Thread.new{sleep(15);que<<567}

t = Thread.new do
  loop {
    puts que.pop
    break unless producer.alive?
  }
end

$stdout.sync = true

que << 123
que << 345
que << 456

que << 3232
que << 8473874
que << 4784
que << 47347
t.join

