//
//  PersonCenterController.m
//  PersonCenter
//
//  Created by zhuoyu on 2017/11/2.
//  Copyright © 2019年 ColorFish All rights reserved.
//

#import "PersonCenterController.h"
#import "ContentViewCell.h"
#import "UINavigationBar+Awesome.h"
#import "PublicHeaderView.h"
#import "UIImage+ImageWithColor.h"
#import "MenuView.h"
#import "UIView+XDWRefresh.h"
#import "EmbedScrollViewControllerProtocol.h"
#import "TestTableViewController.h"
#import "MyBarButtonItem.h"

static CGFloat HeaderHeight;
static CGFloat coverImgheight;

#define SEGMENT_CONTROL_HEIGHT 50

@interface PersonCenterTableView : UITableView
@end

@implementation PersonCenterTableView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end

@interface PersonCenterController ()<UITableViewDelegate, UITableViewDataSource,
  EmbedScrollViewControllerDelegate,PublicHeaderDelegate>
@property (nonatomic, strong) PersonCenterTableView *tableView;
@property (nonatomic, strong) MenuView *menuBar;
@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic, strong) ContentViewCell *contentCell;
@property (nonatomic, strong) PublicHeaderView *headerView;
@property (nonatomic, strong) UIImageView *bannerImgView;
@property (nonatomic, assign) UserHeaderViewType type;
@property (nonatomic, assign) NSInteger tabIndex;
@property (nonatomic, strong) NSMutableArray *controllersArray;
@property (nonatomic, strong) TestTableViewController *userBlogs;
@property (nonatomic, strong) TestTableViewController *userCollects;
@property (nonatomic, strong) TestTableViewController *personInfoMsg;
@end

@implementation PersonCenterController {
    //记录当前屏幕消失时的contentoffSet 防止push到下一个界面回来时导航栏透明
    CGFloat missOffSetY;
}

#pragma mark -lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    coverImgheight = isIpad?140.0*KiPhone6Radio:140.0;
    
    HeaderHeight = _type == UserHeaderViewTypeOther ? (kCoverHeaderHeight+70)*KiPhone6Radio : (kCoverHeaderHeight+20)*KiPhone6Radio;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configUI];
    [self addNotification];
    
    if (self.type != UserHeaderViewTypeNotLogin) {
        [self addChildController];
        [self setupRefresh];
    }
}

- (void)addChildController {
    TestTableViewController *ctrl1 = [[TestTableViewController alloc] initWithStyle:UITableViewStylePlain];
    ctrl1.delegate = self;
    self.userBlogs = ctrl1;
    
    TestTableViewController *ctrl2 = [[TestTableViewController alloc] initWithStyle:UITableViewStylePlain];
    ctrl2.delegate = self;
    self.userCollects = ctrl2;

    TestTableViewController *ctrl3 = [[TestTableViewController alloc] initWithStyle:UITableViewStylePlain];
    ctrl3.delegate = self;
    self.personInfoMsg = ctrl3;
    
    self.controllersArray = [[NSMutableArray alloc] initWithObjects:ctrl1,ctrl2,ctrl3,nil];
}


- (void)configUI {
    self.canScroll = YES;
    //self.title = @"";
    self.edgesForExtendedLayout = UIRectEdgeTop | UIRectEdgeLeft | UIRectEdgeRight;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.tableView addSubview:self.bannerImgView];
    self.tableView.tableHeaderView = self.headerView;
    [self.tableView sendSubviewToBack:self.bannerImgView];
    [self.headerView setType:self.type];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (missOffSetY) {
        [self scrollViewDidScroll:self.tableView];
    }else{
        [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    missOffSetY = self.tableView.contentOffset.y;
    [self.navigationController.navigationBar lt_reset];
    UIImage* bgImage = [UIImage imageWithColor:kNavBarBg];
    [self.navigationController.navigationBar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self.tableView sendSubviewToBack:self.bannerImgView];
}

#pragma mark - 通知处理(子控制器和主控制器的通讯,子控制器到顶部了，通知主控制器可以滑动)
-(void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(embedViewScrollToTop:) name:@"kLeaveTopNtf" object:nil];
}

- (void)embedViewScrollToTop:(NSNotification *)notification {
    self.canScroll = YES;
    self.contentCell.canScroll = NO;
}

#pragma mark -----ACTION------
- (void)onBack:(id)send {
    @try {
        [self.tableView removeObserver:self.view forKeyPath:@"contentOffset" context:nil];
    }
    @catch(NSException *exception) {
        NSLog(@"[PersonCenterController onBack:] %@", exception);
    }
    
    [self.view XD_freeReFresh];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //要减去导航栏 状态栏 以及 sectionheader的高度
    switch (self.type) {
        case UserHeaderViewTypeNotLogin:
            return 150;
            break;
        case UserHeaderViewTypeMy:
            return (kScreenHeight - NavHeight - SEGMENT_CONTROL_HEIGHT - TabbarHeight);
        default:
            break;
    }
    return kScreenHeight - NavHeight - SEGMENT_CONTROL_HEIGHT - TabbarHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return (self.type == UserHeaderViewTypeNotLogin) ? 0 : SEGMENT_CONTROL_HEIGHT;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return (self.type == UserHeaderViewTypeNotLogin) ? nil : self.menuBar;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 0.00001;
//}
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    return nil;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellid = @"person_cell";
    self.contentCell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!self.contentCell) {
        self.contentCell = [[ContentViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid controllers:self.controllersArray];;
        self.contentCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    uWeakSelf
    self.contentCell.scrolleSelected = ^(NSInteger index) {
        weakSelf.tabIndex = index;
        weakSelf.menuBar.selectedIndex = index;
    };
    return self.contentCell;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.y<-coverImgheight) {
        CGRect frame = self.bannerImgView.frame;
        frame.origin.y = scrollView.contentOffset.y;
        frame.size.height = - scrollView.contentOffset.y;
        self.bannerImgView.frame = frame;
    }
    
    //计算导航栏的透明度
    CGFloat minAlphaOffset = -140;
    CGFloat maxAlphaOffset = kScreenWidth  / 1.7-140;
    CGFloat offset = scrollView.contentOffset.y>-140?scrollView.contentOffset.y:-140;
    CGFloat alpha = (offset - minAlphaOffset) / (maxAlphaOffset - minAlphaOffset);
    if (alpha>0.95) {
        NSString *userName = @"我的昵称";
        if (userName && [userName length]>0) {
            self.navigationItem.titleView = [MyBarButtonItem titleView:userName];
        }
    }else{
        self.navigationItem.titleView = [MyBarButtonItem titleView:@""];
    }
    [self.navigationController.navigationBar lt_setBackgroundColor:HexRGBAlpha(0x222222,alpha)];
    
    //子控制器和主控制器之间的滑动状态切换
    if (self.type == UserHeaderViewTypeNotLogin) return;
    
    CGFloat tabOffsetY = [self.tableView rectForSection:0].origin.y-NavHeight;
    if (scrollView.contentOffset.y >= tabOffsetY) {
        scrollView.contentOffset = CGPointMake(0, tabOffsetY);
        if (_canScroll) {
            _canScroll = NO;
            self.contentCell.canScroll = YES;
        }
    } else {
        if (!_canScroll) {
            scrollView.contentOffset = CGPointMake(0, tabOffsetY);
        }
    }
}

#pragma mark - EmbedScrollViewControllerDelegate
-(void)embedViewControllerDidFinishRefreshing:(UIViewController *)viewController {
    [self.view XD_endRefresh];
}

#pragma mark ----GETTER----
- (PersonCenterTableView *)tableView {
    if (!_tableView) {
        _tableView = [[PersonCenterTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _tableView.contentInset = UIEdgeInsetsMake(coverImgheight, 0, 0, 0);
        
    }
    return _tableView;
}

- (PublicHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[PublicHeaderView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, HeaderHeight)];
        _headerView.MyDelegate = self;
    }
    return _headerView;
}

- (UIImageView *)bannerImgView {
    if (!_bannerImgView) {
        UIImage *image = [UIImage imageNamed:@"user_cover.jpg"];
        _bannerImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -coverImgheight, kScreenWidth,coverImgheight)];
        _bannerImgView.contentMode = UIViewContentModeScaleAspectFill;
        _bannerImgView.image = image;
    }
    return _bannerImgView;
}

- (MenuView *)menuBar {
    if (!_menuBar) {
        uWeakSelf
        _menuBar = [[MenuView alloc] initWithFrame:CGRectMake(0, 0, 180, SEGMENT_CONTROL_HEIGHT) TitleArray:@[@"文章",@"收藏",@"资料"]];
        _menuBar.menuSeletedIndex = ^(NSInteger index) {
            [weakSelf.view XD_endRefresh];
            weakSelf.tabIndex = index;
            [weakSelf.contentCell selectedBar:index];
        };
    }
    return _menuBar;
}
/*
- (UserModel *)userInfo {
    if (!_userInfo) {
        _userInfo = [[UserModel alloc] init];
    }
    return _userInfo;
}

*/

#pragma mark - 刷新和翻页
- (void)setupRefresh {
    //获取个人信息不需要刷新去拿
    [self headerRefreshing];
    /**
     添加下拉刷新
     */
    self.view.scrollerOriginY = 0;
    self.view.refreshStartY = 0;
    [self.view XD_refreshWithObject:self.tableView atPoint:CGPointMake(kScreenWidth/2.0-15, -30) downRefresh:^{
        //开始刷新
        [self refreshList];
    }];
}

- (void)refreshList {
    [self.contentCell refreshIndex:self.tabIndex];
}

- (void)headerRefreshing {
    
//    uWeakSelf
//    self.userViewModel.success = ^(id responseObject, BOOL fromCache) {
//        weakSelf.userInfo = [(NSDictionary *)responseObject objectForKey:@"user"];
//        [weakSelf setBackgroundImageUrlString:weakSelf.userInfo.coverImg];
//        if (weakSelf.headerView) {
//            [weakSelf.headerView setInfo:weakSelf.userInfo];
//        };
//    };
//    self.userViewModel.failure = ^(NSError *error) {
//    };
//
//    [self.userViewModel requestUserInfoWithMemberId:self.member_id userId:[LoginUtils loginUid]];
}

#pragma mark ------加载封面图--------
- (void)setBackgroundImageUrlString:(NSString *)imageUrl {
    /*
    NSString *str = [[NSString alloc] init];
    if (imageUrl.length>0) {
        str = POCO_IMG_URL_SIZE(imageUrl, @"W640");
        [self.bannerImgView sd_setImageWithURL:[NSURL URLWithString:str]
                              placeholderImage:[UIImage imageNamed:@"user_cover.jpg"]
                                       options:SDWebImageLowPriority
                                     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                         self.bannerImgView.image = [ImageHandle thumbnailWithImageClips:image size:CGSizeMake(kScreenWidth, coverImgheight)];
                                     }
         ];
    }else{
        self.bannerImgView.image = [ImageHandle thumbnailWithImageClips:[UIImage imageNamed:@"user_cover.jpg"] size:CGSizeMake(kScreenWidth, coverImgheight)];
    }*/
}

#pragma mark ----PublicHeaderDelegate-----
- (void)onClickFocusCnt:(id)sender {
}

- (void)onClickFansCnt:(id)sender {
}

- (void)onClickActCnt:(id)sender {
}

- (void)onClickFocus:(id)sender {
}

#pragma mark ----dealloc----
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
