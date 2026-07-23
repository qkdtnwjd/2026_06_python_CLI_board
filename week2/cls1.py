class CoffeeFranchise:
    branch = 0
    def __int__(self,nm,beans=None, menu=None):
        self.nm = nm
        self.beans = beans
        self.menu = menu
        self.new_branch()
    def make_coffe(self):
        if self.beans:
            print(f'{self.nm}에서는 {self.beans}으로 커피를 만들어요')

        else:
            print(f'{self.nm}에서는 신선한 커피를 제공합니다')

    @classmethod
    def new_branch(cls):
        cls.branch += 1

    @classmethod
    def new_branch_cnt(cls):
        print(f'현재{cls.branch}개의 지점이 있습니다.')


future = CoffeeFranchise("미래융합점","미래 브랜드",{"아메리카노":3000})
city = CoffeeFranchise("둔산점")
future.make_coffe()
city.make_coffe()