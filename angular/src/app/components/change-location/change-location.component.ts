import { Component, OnInit } from '@angular/core';
import {LocationGraphqlService} from "../../services/graphql/location-graphql.service";
import {LocationType} from "../../types/graphql/location-type";
import {ConfigurationService} from "../../services/configuration.service";
import {NavigationService} from "../../services/navigation.service";

@Component({
  selector: 'app-change-location',
  templateUrl: './change-location.component.html',
  styleUrls: ['./change-location.component.scss']
})
export class ChangeLocationComponent implements OnInit {

  locations: LocationType[] = [];
  currentKeyLocation: string = 'san-luis';
  constructor(private locationGraphqlService: LocationGraphqlService,
              private configurationService: ConfigurationService,
              private navigationService: NavigationService) { }

  ngOnInit(): void {
    this.locationGraphqlService.all().subscribe(locations => {
      this.locations = locations.filter(value => value.key === 'san-luis' || value.key === 'jalisco');
    });
    this.configurationService.subdomainKey.subscribe(key => {
      this.currentKeyLocation = key;
    });
  }

  changeLocation(locationKey: string): void {
    this.navigationService.changeLocationHost(locationKey);
  }
}
