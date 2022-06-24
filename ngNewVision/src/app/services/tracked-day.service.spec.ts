import { TestBed } from '@angular/core/testing';

import { TrackedDayService } from './tracked-day.service';

describe('TrackedDayService', () => {
  let service: TrackedDayService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(TrackedDayService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
