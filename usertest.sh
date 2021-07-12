if [ ! -d srctestbyscript ]; then
	mkdir srctestbyscript
fi
cp -- src/* srctestbyscript
cd srctestbyscript
if ! make angle > /dev/null; then
	echo "angle 编译失败"
else
	echo "angle 编译成功"
	echo 三角形自测
	RA=0
	RAT=1
	if echo "65 72 97" | ./angle | grep "right" > /dev/null; then
		echo "输入 65 72 97 输出正确"
		let RA=RA+1
	else
		echo "输入 65 72 97 输出错误"
	fi
	if echo "55 73 48" | ./angle | grep "right" > /dev/null; then
		echo "输入 55 73 48 输出正确"
		let RA=RA+1
	else
		echo "输入 55 73 48 输出错误"
	fi
	if echo "5 4 3" | ./angle | grep "right" > /dev/null; then
		echo "输入 5 4 3 输出正确"
	else
		echo "输入 5 4 3 输出错误"
		RAT=0
	fi
	echo "5 4 3" | ./angle | grep "obtuse" > /dev/null && echo "输入 5 4 3 输出错误" && let RAT=0
	echo "5 4 3" | ./angle | grep "acute" > /dev/null && echo "输入 5 4 3 输出错误" && let RAT=0
	let RA=RA+RAT
	echo 三角形自测完毕
	echo 自测 oj.c
	echo "5 4 3" > in.txt
	./angle < in.txt > out.txt
	cp out.txt right.txt > /dev/null
	mv angle program > /dev/null
	if ! make oj > /dev/null; then
		echo "oj.c 编译失败"
	else
		echo "oj.c 编译成功"
		R=0
		if ./oj | grep "Accept" > /dev/null; then
			let R=R+1
		else
			echo "错误"
		fi
		echo "" >> right.txt
		if ./oj | grep "Accept" > /dev/null; then
			let R=R+1
		else
			echo "处理换行错误"
		fi
		echo "" >> right.txt
		if ./oj | grep "Wrong" > /dev/null; then
			let R=R+1
		else
			echo "处理多个换行错误"
		fi
	fi
	echo "oj.c 自测完毕"
	echo "angle 测试共 3 组，正确 $RA 组。"
	echo "oj 测试共 3 组，正确 $R 组。"
fi
