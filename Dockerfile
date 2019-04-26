# Builder means we are specifying the phase
FROM node:alpine as builder 
WORKDIR '/app'
COPY package.json . 
RUN npm install
COPY . .
RUN npm run build

#no need to specify any phase here by putting seconf from will be assumed as previous block has completed
# as any single block have single from statement, second from statment will terminate from that block

FROM nginx 
#expose Port for us to access from beanstalk
#specify the foolder we want to copy from previous phase and to location where ngnix use to server static contents
#mentined at https://hub.docker.com/_/nginx "/usr/share/nginx/html"
COPY --from=builder /app/build /usr/share/nginx/html
# no specific command reuired to start up ngnix, when we start container it will start up ngnix service
