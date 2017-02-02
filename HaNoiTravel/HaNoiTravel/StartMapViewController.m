//
//  StartMapViewController.m
//  HaNoiTravel
//
//  Created by Dreamup on 1/23/17.
//  Copyright © 2017 DREAMUP. All rights reserved.
//

#import "StartMapViewController.h"
#import "User.h"
#import "Utils.h"


@interface StartMapViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic)  NSMutableDictionary *districtDic;
@property (strong,nonatomic)  NSString *districtSelectStr;
@property (strong,nonatomic)  NSString *wardSelectStr;

@end

@implementation StartMapViewController{
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_mapView startLoadMapCompletion:^(BOOL done){
        
        if(done){
            [self performSegueWithIdentifier:@"nextSegue" sender:self];
        }
        
    }];
    
    _districtTbView.hidden = YES;
    _wardTbView.hidden = YES;
    
    UITapGestureRecognizer *districtTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectDistrictAction)];
    _districtLb.userInteractionEnabled = YES;
    [_districtLb addGestureRecognizer:districtTap];
    
    UITapGestureRecognizer *wardTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectWardAction)];
    _wardLb.userInteractionEnabled = YES;
    [_wardLb addGestureRecognizer:wardTap];
    
    _nextBt.layer.cornerRadius = 5.0f;
    _nextBt.clipsToBounds = YES;
    
    _nextBt.layer.masksToBounds = NO;
    _nextBt.layer.shadowOpacity = 1.f;
    _nextBt.layer.shadowOffset = CGSizeMake(0, 6);
    _nextBt.layer.shadowColor = [UIColor colorWithRed:254.0/255.0 green:181/255.0 blue:173/255.0 alpha:1.0].CGColor;
    
    _districtLb.layer.masksToBounds = NO;
    _districtLb.layer.shadowOpacity = 1.f;
    _districtLb.layer.shadowOffset = CGSizeMake(0, 6);
    _districtLb.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    
    _wardLb.layer.masksToBounds = NO;
    _wardLb.layer.shadowOpacity = 1.f;
    _wardLb.layer.shadowOffset = CGSizeMake(0, 6);
    _wardLb.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    
}

- (void) selectDistrictAction{
    _districtTbView.hidden = NO;
}

- (void) selectWardAction{
    _wardTbView.hidden = NO;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(tableView == _districtTbView){
        return  [[self.districtDic allKeys] count];
    }
    
    if(_districtSelectStr != nil){
        NSMutableArray *wards = [self.districtDic objectForKey:_districtSelectStr];
        return wards.count;
    }
    
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView == _districtTbView){
        NSArray *keys = [[_districtDic allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            NSString *key1 = obj1;
            NSString *key2 = obj2;
            return [key1 compare:key2];
        }];
        _districtSelectStr = [keys objectAtIndex:indexPath.row];
        _districtLb.text = _districtSelectStr;
        _districtTbView.hidden = YES;
        
        NSArray *wards = [[_districtDic objectForKey:_districtSelectStr] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            NSString *key1 = obj1;
            NSString *key2 = obj2;
            return [key1 compare:key2];
        }];
        _wardSelectStr = [wards objectAtIndex:0];
        _wardLb.text = _wardSelectStr;
        _wardTbView.hidden = YES;
        
        [_wardTbView reloadData];
    }else{
        NSArray *wards = [[_districtDic objectForKey:_districtSelectStr] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            NSString *key1 = obj1;
            NSString *key2 = obj2;
            return [key1 compare:key2];
        }];
        _wardSelectStr = [wards objectAtIndex:indexPath.row];
        _wardLb.text = _wardSelectStr;
        _wardTbView.hidden = YES;
        
        NSString *keyword = [NSString stringWithFormat:@"%@,%@, Ha Noi",_wardSelectStr,_districtSelectStr];
        [_mapView resetMapAtAddress:keyword];
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    UILabel *content = [cell viewWithTag:111];
    
    if(tableView == _districtTbView){
        
        NSArray *keys = [[_districtDic allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            NSString *key1 = obj1;
            NSString *key2 = obj2;
            return [key1 compare:key2];
        }];
        
        content.text = [keys objectAtIndex:indexPath.row];
    }else{
        

        NSArray *wards = [[_districtDic objectForKey:_districtSelectStr] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            NSString *key1 = obj1;
            NSString *key2 = obj2;
            return [key1 compare:key2];
        }];
        content.text = [wards objectAtIndex:indexPath.row];
    }
    
    return cell;
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    
    if([[User shareInstance] latitude] == 0 ){
        [Utils showAlert:@"" message:@"Please choose your location !"];
        return NO;
    }
    
    return YES;
    
}

- (NSMutableDictionary *)districtDic{
    if(_districtDic == nil){
        _districtDic = [NSMutableDictionary dictionary];
        
        NSMutableArray *quan1 = [NSMutableArray arrayWithObjects:@"Cống Vị", @"Điện Biên",@"Đội Cấn",@"Giảng Võ",@"Kim Mã",
                                 @"Liễu Giai",@"Ngọc Hà", @"Ngọc Khánh", @"Nguyễn Trung Trực", @"Phúc Xá", @"Quán Thánh",
                                 @"Thành Công", @"Trúc Bạch",@"Vĩnh Phúc", nil];
        [_districtDic setObject:quan1 forKey:@"Ba Đình"];
        
        NSMutableArray *quan2 = [NSMutableArray arrayWithObjects:@"Cổ Nhuế 1",@"Cổ Nhuế 2",@"Đông Ngạc", @"Đức Thắng", @"Liên Mạc",
                                 @"Minh Khai", @"Phú Diễn", @"Phúc Diễn", @"Tây Tựu", @"Thượng Cát", @"Thụy Phương", @"Xuân Đỉnh", @"Xuân Tảo", nil];
        [_districtDic setObject:quan2 forKey:@"Bắc Từ Liêm"];
        
        NSMutableArray *quan3 = [NSMutableArray arrayWithObjects:@"Nghĩa Đô", @"Quan Hoa", @"Dịch Vọng", @"Dịch Vọng Hậu", @"Trung Hòa",
                                 @"Nghĩa Tân", @"Mai Dịch", @"Yên Hòa", nil];
        [_districtDic setObject:quan3 forKey:@"Cầu Giấy"];
        
        NSMutableArray *quan4 = [NSMutableArray arrayWithObjects:@"Văn Miếu", @"Quốc Tử Giám", @"Hàng Bột", @"Nam Đồng", @"Trung Liệt", @"Khâm Thiên",
                                 @"Phương Liên", @"Phương Mai", @"Khương Thượng", @"Ngã Tư Sở", @"Láng Thượng", @"Cát Linh", @"Văn Chương", @"Ô Chợ Dừa",
                                 @"Quang Trung", @"Thổ Quan", @"Trung Phụng", @"Kim Liên", @"Trung Tự", @"Thịnh Quang", @"Láng Hạ", nil];
        [_districtDic setObject:quan4 forKey:@"Đống Đa"];
        
        NSMutableArray *quan5 = [NSMutableArray arrayWithObjects:@"Quang Trung", @"Nguyễn Trãi", @"Hà Cầu", @"Vạn Phúc", @"Phúc La", @"Yết Kiêu", @"Mộ Lao", @"Văn Quán",
                                 @"La Khê", @"Phú La", @"Kiến Hưng", @"Yên Nghĩa", @"Phú Lương", @"Phú Lãm", @"Dương Nội", @"Biên Giang", @"Đồng Mai", nil];
        [_districtDic setObject:quan5 forKey:@"Hà Đông"];
        
        NSMutableArray *quan30 = [NSMutableArray arrayWithObjects:@"Nguyễn Du", @"Bùi Thị Xuân", @"Ngô Thì Nhậm", @"Đồng Nhân", @"Bạch Đằng", @"Thanh Nhàn", @"Bách Khoa", @"Vĩnh Tuy",
                                  @"Trương Định", @"Lê Đại Hành", @"Phố Huế", @"Phạm Đình Hổ", @"Đống Mác", @"Thanh Lương", @"Cầu Dền", @"Bạch Mai", @"Quỳnh Mai", @"Minh Khai",
                                  @"Đồng Tâm", @"Quỳnh Lôi", nil];
        [_districtDic setObject:quan30 forKey:@"Hai Bà Trưng"];
        
        NSMutableArray *quan6 = [NSMutableArray arrayWithObjects:@"Chương Dương Độ", @"Cửa Đông", @"Cửa Nam", @"Đồng Xuân", @"Hàng Bạc", @"Hàng Bài", @"Hàng Bồ", @"Hàng Bông", @"Hàng Buồm",
                                 @"Hàng Đào", @"Hàng Gai", @"Hàng Mã", @"Hàng Trống", @"Lý Thái Tổ", @"Phan Chu Trinh", @"Phúc Tân", @"Trần Hưng Đạo", @"Tràng Tiền", nil];
        [_districtDic setObject:quan6 forKey:@"Hoàn Kiếm"];
        
        
        NSMutableArray *quan7 = [NSMutableArray arrayWithObjects:@"Định Công", @"Đại Kim", @"Giáp Bát", @"Hoàng Liệt", @"Hoàng Văn Thụ", @"Lĩnh Nam", @"Mai Động", @"Tân Mai", @"Thanh Trì",
                                 @"Thịnh Liệt", @"Trần Phú", @"Tương Mai", @"Vĩnh Hưng", @"Yên Sở", nil];
        [_districtDic setObject:quan7 forKey:@"Hoàng Mai"];
        
        NSMutableArray *quan8 = [NSMutableArray arrayWithObjects:@"Bồ Đề", @"Gia Thụy", @"Cự Khối", @"Đức Giang", @"Giang Biên", @"Long Biên", @"Ngọc Lâm", @"Ngọc Thụy", @"Phúc Đồng", @"Phúc Lợi",
                                 @"Sài Đồng", @"Thạch Bàn", @"Thượng Thanh",@"Việt Hưng", nil];
        [_districtDic setObject:quan8 forKey:@"Long Biên"];
        
        NSMutableArray *quan9 = [NSMutableArray arrayWithObjects:@"Cầu Diễn", @"Đại Mỗ", @"Mễ Trì", @"Mỹ Đình 1", @"Mỹ Đình 2", @"Phú Đô", @"Phương Canh", @"Tây Mỗ", @"Trung Văn", @"Xuân Phương", nil];
        [_districtDic setObject:quan9 forKey:@"Nam Từ Liêm"];
        
        NSMutableArray *quan10 = [NSMutableArray arrayWithObjects:@"Bưởi", @"Thụy Khuê", @"Yên Phụ", @"Tứ Liên", @"Nhật Tân", @"Quảng An", @"Xuân La", @"Phú Thượng", nil];
        [_districtDic setObject:quan10 forKey:@"Tây Hồ"];
        
        NSMutableArray *quan11 = [NSMutableArray arrayWithObjects:@"Hạ Đình", @"Kim Giang", @"Khương Đình", @"Khương Mai", @"Khương Trung", @"Nhân Chính", @"Phương Liệt", @"Thanh Xuân Bắc",
                                  @"Thanh Xuân Nam", @"Thanh Xuân Trung", @"Thượng Đình", nil];
        [_districtDic setObject:quan11 forKey:@"Thanh Xuân"];
        
        NSMutableArray *quan12 = [NSMutableArray arrayWithObjects:@"Lê Lợi", @"Quang Trung", @"Phú Thịnh", @"Ngô Quyền", @"Sơn Lộc", @"Xuân Khanh", @"Trung Hưng", @"Viên Sơn", @"Trung Sơn Trầm", nil];
        [_districtDic setObject:quan12 forKey:@"Sơn Tây"];
        
        NSMutableArray *quan13 = [NSMutableArray arrayWithObjects:@"Tây Đằng", nil];
        [_districtDic setObject:quan13 forKey:@"Ba Vì"];
        
        
        NSMutableArray *quan14 = [NSMutableArray arrayWithObjects:@"Chúc Sơn", @"Xuân Mai", nil];
        [_districtDic setObject:quan14 forKey:@"Chương Mỹ"];
        
        NSMutableArray *quan15 = [NSMutableArray arrayWithObjects:@"Phùng", nil];
        [_districtDic setObject:quan15 forKey:@"Đan Phượng"];
        
        NSMutableArray *quan16 = [NSMutableArray arrayWithObjects:@"Đông Anh", nil];
        [_districtDic setObject:quan16 forKey:@"Đông Anh"];
        
        NSMutableArray *quan17 = [NSMutableArray arrayWithObjects:@"Trâu Quỳ",@"Yên Viên", nil];
        [_districtDic setObject:quan17 forKey:@"Gia Lâm"];
        
        NSMutableArray *quan18 = [NSMutableArray arrayWithObjects:@"Trạm Trôi", nil];
        [_districtDic setObject:quan18 forKey:@"Hoài Đức"];
        
        NSMutableArray *quan19 = [NSMutableArray arrayWithObjects:@"Chi Đông", @"Quang Minh", nil];
        [_districtDic setObject:quan19 forKey:@"Mê Linh"];
        
        NSMutableArray *quan20 = [NSMutableArray arrayWithObjects:@"Đại Nghĩa", nil];
        [_districtDic setObject:quan20 forKey:@"Mỹ Đức"];
        
        NSMutableArray *quan21 = [NSMutableArray arrayWithObjects:@"Phú Xuyên", @"Phú Minh", nil];
        [_districtDic setObject:quan21 forKey:@"Phú Xuyên"];
        
        NSMutableArray *quan22 = [NSMutableArray arrayWithObjects:@"Phúc Thọ", nil];
        [_districtDic setObject:quan22 forKey:@"Phúc Thọ"];
        
        NSMutableArray *quan23 = [NSMutableArray arrayWithObjects:@"Quốc Oai", nil];
        [_districtDic setObject:quan23 forKey:@"Quốc Oai"];
        
        NSMutableArray *quan24 = [NSMutableArray arrayWithObjects:@"Sóc Sơn", nil];
        [_districtDic setObject:quan24 forKey:@"Sóc Sơn"];
        
        NSMutableArray *quan25 = [NSMutableArray arrayWithObjects:@"Liên Quan", nil];
        [_districtDic setObject:quan25 forKey:@"Thạch Thất"];
        
        NSMutableArray *quan26 = [NSMutableArray arrayWithObjects:@"Kim Bài", nil];
        [_districtDic setObject:quan26 forKey:@"Thanh Oai"];
        
        NSMutableArray *quan27 = [NSMutableArray arrayWithObjects:@"Văn Điển ", nil];
        [_districtDic setObject:quan27 forKey:@"Thanh Trì"];
        
        NSMutableArray *quan28 = [NSMutableArray arrayWithObjects:@"Thường Tín", nil];
        [_districtDic setObject:quan28 forKey:@"Thường Tín"];
        
        NSMutableArray *quan29 = [NSMutableArray arrayWithObjects:@"Vân Đình", nil];
        [_districtDic setObject:quan29 forKey:@"Ứng Hoà"]; 
    }
    
    return _districtDic;
}

@end
