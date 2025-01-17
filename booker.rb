require 'initialiser'

get '/book/:id' do
  @book = Book.find(params[:id])
  if @book.content.nil?
    haml :waiting
  else
    haml :book
  end
end

get '/book/:id/delete' do
  @book = Book.find(params[:id])
  @book.delete
end

get '/book/:id/pdf' do
  @book = Book.find(params[:id])
  response.headers['content_type'] = "application/pdf"
  attachment("book.pdf")
  response.write(@book.pdf)
end

get '/' do
  haml :index
end

get '/wait' do
  haml :waiting
end

get '/about' do
  haml :about
end

get '/books' do
  @books = Book.all :limit => 10
  haml :books
end

post '/book' do
  book = Book.create(:title => params[:title], :url => params[:feedurl])
  book.save
  redirect '/book/'+book.id.to_s
end