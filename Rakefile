desc "Deployneme to jako nufinka"
task :deploy do
  system("middleman build")
  system("scp -r build/* deploy@95.85.60.237:/opt/apps/jocellyn")
end
