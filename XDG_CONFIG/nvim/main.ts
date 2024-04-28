type TestProps = {
  name: string;
  age: number;
  city: string;
};

export class Test {
  private data: Record<keyof TestProps, string>;

  add(name: string, value: string) {
    this.data[name] = value;

    return this;

  }

  build() {
    return this.data;
  }
}

const test = new Test();
const tests = new Array();


function reateTest() {
  test
    .add('name', 'John')
    .add('age', '25')
    .add('city', 'New York'); tests.push(test.build());
  test.add('name', 'Jane').add('age', '30').add('city', 'Los Angeles');
  test.build();
}



reateTest();
console.log(tests);


