import { TestBed } from '@angular/core/testing';

import { MealTypeService } from './meal-type.service';

describe('MealTypeService', () => {
  let service: MealTypeService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(MealTypeService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
