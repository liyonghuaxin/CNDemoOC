https://www.jianshu.com/p/87ef6720a096

Native app有很大一部分的时间是在等待事件发生，然后响应事件，比如等待网络请求完成，等待用户的操作，等待某些状态值的改变等等，等这些事件发生后，再做进一步处理。 但是这些等待和响应，并没有一个统一的处理方式。Delegate, Notification, Block, KVO, 常常会不知道该用哪个最合适。有时需要chain或者compose某几个事件，就需要多个状态变量，而状态变量一多，复杂度也就上来了。为了解决这些问题，Github的工程师们开发了ReactiveCocoa。

- **ReactiveCocoa操作原理**
所有的信号（RACSignal）都可以进行操作处理，因为所有操作方法都定义在RACStream.h中，因此只要继承RACStream就有了操作处理方法

- **ReactiveCocoa操作思想**
运用的是Hook（钩子）思想，Hook是一种用于改变API(应用程序编程接口：方法)执行结果的技术. Hook用处：截获API调用的技术。 Hook原理：在每次调用一个API返回结果之前，先执行你自己的方法，改变结果的输出

- **ReactiveCocoa核心方法bind**
ReactiveCocoa操作的核心方法是bind（绑定）,而且RAC中核心开发方式，也是绑定，之前的开发方式是赋值，而用RAC开发，应该把重心放在绑定，也就是可以在创建一个对象的时候，就绑定好以后想要做的事情，而不是等赋值之后在去做事情


