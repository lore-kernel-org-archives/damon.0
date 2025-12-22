Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E646221546;
	Mon, 22 Dec 2025 15:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766417075; cv=none; b=DI+KPmjm7DBtYPT4IZ2LTKsD/s9+Zn0aglFEyi10pLm/wqNrfFHWL77t4o8LbVr+1CZkoHrsaFwNvxZ5w5TORDhmtrqClUbagEaRaKjoQV5Zpxkz3rZMc2ojfGlcK0Di+A6mXd6UZSfT7QOafeUSltuhXY97r/qXWCWY5t/yDHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766417075; c=relaxed/simple;
	bh=3/Yn5ySh52i/4QJb8bgsJpI/+2imGHs99ervgv9OcJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WxE/Bmrp7xaNrLzgDmjQcIZf32v25OfkHMoIpuMO3rrHV94EkTG9lzhjTSlY/pnNaMGCkGj4BrpZKPOKqq8oBp4itRXiW8CO6/sK5Ls61+moWVDCKSSTtheuV+Z6Ww6dQ76w5ndQLflxPboF4hXZTudskz5gWDb/hEN8e4k0QU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1Q/QdOF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1Q/QdOF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92D1BC4CEF1;
	Mon, 22 Dec 2025 15:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766417074;
	bh=3/Yn5ySh52i/4QJb8bgsJpI/+2imGHs99ervgv9OcJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f1Q/QdOFS/TkKJ/WE/Xchi4hsGXQb53TMNdXsQYdVeH8kxidKc5XZEjB1ryY6tOqA
	 qF9xZcAAUnLYWQkgYVEIbd51DTH63KYTjOJXJgv5gF1+0NLPIn+jjbpsRmn7d2ibcQ
	 UklKIuKF3uO+MvV82Pj4PGzqEPKhItn1DTO7nk6GGcT7raMY7EsERWWiO9F+dkWrEp
	 /4m9fN3/hxgKICZhk6eMwjDwjv8qAY8bw4lQhITGISrq5q1v8cuWO1db2Ekq8XqMBU
	 WsTZVAL5wNsM0/DYzTO8g5y2jdPNaJZJOLSU7HJFoDd3y9SQGw8ElGGtVR+kq+V9hQ
	 GhtIzMpZNq7GA==
From: SeongJae Park <sj@kernel.org>
To: Shu Anzai <shu17az@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	yanquanmin1@huawei.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/tests/core-kunit: extend test scenarios and remove redundancy
Date: Mon, 22 Dec 2025 07:24:27 -0800
Message-ID: <20251222152427.87516-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <a98e23a1-5be3-4c2a-a65a-c33853683674@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 22 Dec 2025 03:33:52 -0800 Shu Anzai <shu17az@gmail.com> wrote:

> Hello SJ,
> 
> Thank you for reviewing my patch! My responses are below.
> 
> On 2025/12/21 12:13, SeongJae Park wrote:
> > Hello Shu,
> >
> >
> > Thank you for sending this patch :)
> >
> > On Sun, 21 Dec 2025 13:01:14 +0000 Shu Anzai <shu17az@gmail.com> wrote:
> >
> >> Add some missing test scenarios to cover a wider range of cases. Also,
> >> remove a redundant case in damos_test_commit_quota_goal().
> > Seems this patch is making more than one change to multiple test cases at once.
> > It makes following which change is for what purpose bit difficult for me.  I'd
> > suggest splitting this into smaller ones that making changes for each test
> > function, and adding more explanation of the changes.  E.g., a patch for
> > damon_test_split_at(), another one for damon_test_merge_two(), and so on.  Not
> > a strong request, though.
> >
> > I have two questions below, though.
> 
> I see. I will split this and send v2 later. Let me first explain the 
> changes in detail.

Looking forward to the v2! :)

[...]
> >> @@ -232,12 +238,12 @@ static void damon_test_merge_regions_of(struct kunit *test)
> >>   {
> >>   	struct damon_target *t;
> >>   	struct damon_region *r;
> >> -	unsigned long sa[] = {0, 100, 114, 122, 130, 156, 170, 184};
> >> -	unsigned long ea[] = {100, 112, 122, 130, 156, 170, 184, 230};
> >> -	unsigned int nrs[] = {0, 0, 10, 10, 20, 30, 1, 2};
> >> +	unsigned long sa[] = {0, 100, 114, 122, 130, 156, 170, 184, 235, 240};
> >> +	unsigned long ea[] = {100, 112, 122, 130, 156, 170, 184, 230, 240, 10235};
> >> +	unsigned int nrs[] = {0, 0, 10, 10, 20, 30, 1, 2, 5, 5};
> >>   
> >> -	unsigned long saddrs[] = {0, 114, 130, 156, 170};
> >> -	unsigned long eaddrs[] = {112, 130, 156, 170, 230};
> >> +	unsigned long saddrs[] = {0, 114, 130, 156, 170, 235, 240};
> >> +	unsigned long eaddrs[] = {112, 130, 156, 170, 230, 240, 10235};
> >>   	int i;
> >>   
> >>   	t = damon_new_target();
> >> @@ -255,9 +261,9 @@ static void damon_test_merge_regions_of(struct kunit *test)
> >>   	}
> >>   
> >>   	damon_merge_regions_of(t, 9, 9999);
> >> -	/* 0-112, 114-130, 130-156, 156-170 */
> >> -	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 5u);
> >> -	for (i = 0; i < 5; i++) {
> >> +	/* 0-112, 114-130, 130-156, 156-170, 170-230, 235-240, 240-10235 */
> >> +	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 7u);
> >> +	for (i = 0; i < 7; i++) {
> >>   		r = __nth_region_of(t, i);
> >>   		KUNIT_EXPECT_EQ(test, r->ar.start, saddrs[i]);
> >>   		KUNIT_EXPECT_EQ(test, r->ar.end, eaddrs[i]);
> > I understand the above change adds two regions on the test input, but I'm not
> > following what logic it intends to additionally test.  Could you please
> > clarify?
> 
> Both cases were intended to verify that damon_merge_two_regions() is 
> called properly in damon_merge_regions_of().
> The first one was intended to ensure that non-adjacent regions (170-230, 
> 235-240) are not merged even if their nr_accesses difference is within 
> the threshold. However, on second thought, I realized this is redundant 
> since it is natural for non-adjacent regions not to be merged.
> The second one is to verify that two adjacent regions (235-240, 
> 240-10235) are not merged if the resulting region would exceed the size 
> limit.

Makes sense, please add the details to the second version.


Thanks,
SJ

[...]
