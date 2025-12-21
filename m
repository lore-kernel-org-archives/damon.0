Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C262FF664;
	Sun, 21 Dec 2025 20:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766348038; cv=none; b=ihHo6Wv80e677H0viEdTDZ8wOqyTl1lBVQJlyi1rOrqtJ6PspifGCA/gHL5XbspERU7Wah9rjhzqhb5ZqovJvsn6m2N0oRhehX9zHkFYgQZ57ofOx0VWSUHu4Cukmppr/mAoFMMB12UCXXPMsiyWOb0R6ClCNSa3M4IVUHbZDaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766348038; c=relaxed/simple;
	bh=L+HwWcueprOkDL5bY7kcoLnxKlOmqZ8wBaIYvEpHcuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=suGZMjzn5N5zQg9LMxdSou4ZQR9DDzURgpOo/SNCPey4XCyOaVAgOIdewfQXAxpwE3YHdU+HbnkIk+Hys1XutIMsWLdcYrtnk81KiBoFJdnt/QZ+8f/03b77r2t5hkvpJF3SeWlLusmmYfDk/2dOxeQoW/2cILORhPqJY+KJHeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kuX/TvQL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kuX/TvQL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4ACC4CEFB;
	Sun, 21 Dec 2025 20:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766348037;
	bh=L+HwWcueprOkDL5bY7kcoLnxKlOmqZ8wBaIYvEpHcuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kuX/TvQLnJs6M4/+yEHXi0Kh1zn/tvDGxyP+FaKLIRHkm/dXlUV6+HMfUlkr5ZBgh
	 AhYF/edfKH7iXkes8p6TZmi2R+GH/7wLWpyPeDhUKuM/a/f+oI2ferqyox3fz6pTGj
	 PBiRaO1ROoOYySERM3/+8nFn3wjdhRlPPQkLgLolOcWqWBywEKYZ+qU8jSaQ/0oiqH
	 VCkvuLgk+BDlRdrDHEIS33hx1m46lCqYi96VWgGK5yh/QACqozxMouZ8hYZLRLbaJR
	 uuqeYmlgKQV0W72lDPX5DqnEwBwS9ikpbpN9Is1XMb80/FI6c0xIpIcXHo0ss7Sd6+
	 Y7fKPAcLx3T5A==
From: SeongJae Park <sj@kernel.org>
To: Shu Anzai <shu17az@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	yanquanmin1@huawei.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/tests/core-kunit: extend test scenarios and remove redundancy
Date: Sun, 21 Dec 2025 12:13:55 -0800
Message-ID: <20251221201356.43083-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251221130114.1483856-1-shu17az@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Shu,


Thank you for sending this patch :)

On Sun, 21 Dec 2025 13:01:14 +0000 Shu Anzai <shu17az@gmail.com> wrote:

> Add some missing test scenarios to cover a wider range of cases. Also,
> remove a redundant case in damos_test_commit_quota_goal().

Seems this patch is making more than one change to multiple test cases at once.
It makes following which change is for what purpose bit difficult for me.  I'd
suggest splitting this into smaller ones that making changes for each test
function, and adding more explanation of the changes.  E.g., a patch for
damon_test_split_at(), another one for damon_test_merge_two(), and so on.  Not
a strong request, though.

I have two questions below, though.

> 
> Signed-off-by: Shu Anzai <shu17az@gmail.com>
> ---
>  mm/damon/tests/core-kunit.h | 51 ++++++++++++++++++++++++-------------
>  1 file changed, 33 insertions(+), 18 deletions(-)
> 
> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index f59ae7ee19a0..e9ccc3fb34f9 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -158,6 +158,7 @@ static void damon_test_split_at(struct kunit *test)
>  	r->nr_accesses_bp = 420000;
>  	r->nr_accesses = 42;
>  	r->last_nr_accesses = 15;
> +	r->age = 10;
>  	damon_add_region(r, t);
>  	damon_split_region_at(t, r, 25);
>  	KUNIT_EXPECT_EQ(test, r->ar.start, 0ul);
> @@ -170,6 +171,7 @@ static void damon_test_split_at(struct kunit *test)
>  	KUNIT_EXPECT_EQ(test, r->nr_accesses_bp, r_new->nr_accesses_bp);
>  	KUNIT_EXPECT_EQ(test, r->nr_accesses, r_new->nr_accesses);
>  	KUNIT_EXPECT_EQ(test, r->last_nr_accesses, r_new->last_nr_accesses);
> +	KUNIT_EXPECT_EQ(test, r->age, r_new->age);
>  
>  	damon_free_target(t);
>  }

I understand that the above change is increasing the coverage of this test to
also verify the age of splitted region.  Nice.

Correct me if I'm misunderstanding the intention of the above diff.

> @@ -190,6 +192,7 @@ static void damon_test_merge_two(struct kunit *test)
>  	}
>  	r->nr_accesses = 10;
>  	r->nr_accesses_bp = 100000;
> +	r->age = 9;
>  	damon_add_region(r, t);
>  	r2 = damon_new_region(100, 300);
>  	if (!r2) {
> @@ -198,12 +201,15 @@ static void damon_test_merge_two(struct kunit *test)
>  	}
>  	r2->nr_accesses = 20;
>  	r2->nr_accesses_bp = 200000;
> +	r2->age = 21;
>  	damon_add_region(r2, t);
>  
>  	damon_merge_two_regions(t, r, r2);
>  	KUNIT_EXPECT_EQ(test, r->ar.start, 0ul);
>  	KUNIT_EXPECT_EQ(test, r->ar.end, 300ul);
>  	KUNIT_EXPECT_EQ(test, r->nr_accesses, 16u);
> +	KUNIT_EXPECT_EQ(test, r->nr_accesses_bp, 160000u);
> +	KUNIT_EXPECT_EQ(test, r->age, 17u);
>  
>  	i = 0;
>  	damon_for_each_region(r3, t) {

I understand that the above change is increasing the coverage of this test to
also verify the age handling of the merge logic.  Looks good!

> @@ -232,12 +238,12 @@ static void damon_test_merge_regions_of(struct kunit *test)
>  {
>  	struct damon_target *t;
>  	struct damon_region *r;
> -	unsigned long sa[] = {0, 100, 114, 122, 130, 156, 170, 184};
> -	unsigned long ea[] = {100, 112, 122, 130, 156, 170, 184, 230};
> -	unsigned int nrs[] = {0, 0, 10, 10, 20, 30, 1, 2};
> +	unsigned long sa[] = {0, 100, 114, 122, 130, 156, 170, 184, 235, 240};
> +	unsigned long ea[] = {100, 112, 122, 130, 156, 170, 184, 230, 240, 10235};
> +	unsigned int nrs[] = {0, 0, 10, 10, 20, 30, 1, 2, 5, 5};
>  
> -	unsigned long saddrs[] = {0, 114, 130, 156, 170};
> -	unsigned long eaddrs[] = {112, 130, 156, 170, 230};
> +	unsigned long saddrs[] = {0, 114, 130, 156, 170, 235, 240};
> +	unsigned long eaddrs[] = {112, 130, 156, 170, 230, 240, 10235};
>  	int i;
>  
>  	t = damon_new_target();
> @@ -255,9 +261,9 @@ static void damon_test_merge_regions_of(struct kunit *test)
>  	}
>  
>  	damon_merge_regions_of(t, 9, 9999);
> -	/* 0-112, 114-130, 130-156, 156-170 */
> -	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 5u);
> -	for (i = 0; i < 5; i++) {
> +	/* 0-112, 114-130, 130-156, 156-170, 170-230, 235-240, 240-10235 */
> +	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 7u);
> +	for (i = 0; i < 7; i++) {
>  		r = __nth_region_of(t, i);
>  		KUNIT_EXPECT_EQ(test, r->ar.start, saddrs[i]);
>  		KUNIT_EXPECT_EQ(test, r->ar.end, eaddrs[i]);

I understand the above change adds two regions on the test input, but I'm not
following what logic it intends to additionally test.  Could you please
clarify?

> @@ -269,6 +275,9 @@ static void damon_test_split_regions_of(struct kunit *test)
>  {
>  	struct damon_target *t;
>  	struct damon_region *r;
> +	unsigned long sa[] = {0, 300, 500};
> +	unsigned long ea[] = {220, 400, 700};
> +	int i;
>  
>  	t = damon_new_target();
>  	if (!t)
> @@ -286,14 +295,19 @@ static void damon_test_split_regions_of(struct kunit *test)
>  	t = damon_new_target();
>  	if (!t)
>  		kunit_skip(test, "second target alloc fail");
> -	r = damon_new_region(0, 220);
> -	if (!r) {
> -		damon_free_target(t);
> -		kunit_skip(test, "second region alloc fail");
> +	for (i = 0; i < ARRAY_SIZE(sa); i++) {
> +		r = damon_new_region(sa[i], ea[i]);
> +		if (!r) {
> +			damon_free_target(t);
> +			kunit_skip(test, "region alloc fail");
> +		}
> +		damon_add_region(r, t);
> +	}
> +	damon_split_regions_of(t, 4, 5);
> +	KUNIT_EXPECT_LE(test, damon_nr_regions(t), 12u);
> +	damon_for_each_region(r, t) {
> +		KUNIT_EXPECT_GE(test, damon_sz_region(r) % 5ul, 0ul);
>  	}
> -	damon_add_region(r, t);
> -	damon_split_regions_of(t, 4, 1);
> -	KUNIT_EXPECT_LE(test, damon_nr_regions(t), 4u);
>  	damon_free_target(t);
>  }

I understand that the above change make the existing test scenario bit more
complex, and cover the alignment.  Looks good.  But
damon_test_split_regions_of() aims to cover multiple scenarios.  Your change is
updating one existing test scenario, so I'm bit concerned at the fact that it
is removing one test case.  I understand the updated test scenario is including
the old one, but I think keeping the current test is also ok, as long as the
maintenace burden is not that high.  So, instead of modifying an existing test
scenario, how about adding the new test case?

>  
> @@ -574,9 +588,10 @@ static void damos_test_commit_quota_goal(struct kunit *test)
>  			});
>  	damos_test_commit_quota_goal_for(test, &dst,
>  			&(struct damos_quota_goal) {
> -			.metric = DAMOS_QUOTA_USER_INPUT,
> -			.target_value = 789,
> -			.current_value = 12,
> +			.metric = DAMOS_QUOTA_SOME_MEM_PSI_US,
> +			.target_value = 234,
> +			.current_value = 345,
> +			.last_psi_total = 567,
>  			});
>  }

Thank you for correcting this!


Thanks,
SJ

[...]
