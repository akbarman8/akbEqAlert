platform :ios, '6.0'

inhibit_all_warnings!

pod 'ABCustomControl', :path => "/Users/amit/Projects/Personal/ABCustomControl"


target 'EarthQuakeAlertTests', :exclusive => true do
#  pod 'OCMock', '2.2.4'
end

#link_with 'EarthQuake', 'EarthQuakeTests'
post_install do |installer|
    installer.project.targets.each do |target|
        puts target.name
    end
end