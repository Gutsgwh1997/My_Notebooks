#C++第１３章　类继承
Friday, 26. July 2019 08:27am 

1. 使用公有继承，基类的公有成员将成为派生类的共有成员；基类的私有部分也将成为派生类的一部分，但是只能通过基类的公有和保护方法访问。
2. 构造函数、析构函数、赋值运算符、友元函数不能继承。
>构造函数不同于其他类方法，因为他创建新的对象，而其他类方法只是被现有的对象调用。
3. 返回类型为void，可以进行单个的赋值，但是不能进行连续的赋值，例如a=b=c;
返回类型为baseDMA，则返回一个副本，增加程序的开销，降低效率。
4. 先调用的后析构，创建的时候先调用基类的构造函数，析构的时候先调用派生类的析构函数。
5. 需要，析构函数不会继承，自己不写，编译器会生成一个默认的。 