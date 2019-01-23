# coding: utf-8
 
require "erb"
 
module SimpleUpload
    def index(env)
        # Это необязательно. Здесь просто показываю как воспользоваться языком разметки ERB
        @title = 'RUBY'
        ERB.new( File.open("form.html.erb", 'r').read ).result(binding)
    end
    def upload(env)
        # Параметры было можно считать вот так, но благодаря статье: [url]http://www.wooptoot.com/file-upload-with-sinatra[/url]
        # стало понятно что в нем используется модуль Rack::Multipart см. ниже метод parse_multipart
        #req = Rack::Request.new(env)                 
        #puts req.params['the-file'][:tempfile].read  
 
        params = parse_multipart(env)
        
        # Берем первый ключ полученного хеша. Этот ключ указывает на имя формы. И этот ключ содержит весь остальной хеш
        form_name = params.keys[0]
 
        # Получаем имя передаваемого файла
        file_name = params[ form_name ][:filename]
        
        # Получаем объект указывающий на файл
        tempfile  = params[ form_name ][:tempfile]
 
        save_file_to_disk( tempfile,file_name )
 
        'uloaded!'
    end
    def save_file_to_disk( tempfile,file_name )
 
        File.open( file_name, "w" ) do |f|
            # Сохраняем файл на сервере. Обратите внимание на метод .read не пропустите его
            f.write( tempfile.read )
        end
 
    end
    # Метод спаситель. Как раз здесь, происходит избавление от boundary и прочей ереси (ответ на вопрос моего поста)
    def parse_multipart(env)
        Rack::Multipart.parse_multipart(env)            
    end
end
