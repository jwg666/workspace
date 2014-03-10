@echo 更新文件
svn update
@echo -----------------------------------------------------------------------------
@echo 打包
@echo -----------------------------------------------------------------------------
mvn clean package -Dmaven.test.skip=true -Pproduction
pause