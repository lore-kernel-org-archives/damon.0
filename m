Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF524C86
	for <damon@lists.linux.dev>; Mon, 18 Sep 2023 05:33:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431A9C433C7;
	Mon, 18 Sep 2023 05:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695015203;
	bh=ZSre9xUXaczWj7SY0m81+m7rnmYcDRo0030/fgV5cdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TANfFm6fmw4upz/D15/HMmKIdtp3e7oAQqqcn8BfeWoarFhn/LkGWZVe+7snKEyFU
	 cOWWysL8c5SUUGGBnUIv6wmbUULwwtOE9dbAhECEdk8AgmsmnZpToArMXwUdcU8DRc
	 9gVFthnkt2IsWTRE+5XfZH07iVZwe00q3psZPuZC90fCEuabqwzaoTbk5ZxSPlnmQD
	 cyV1Sg+jseVykrqA0XgXx81JSvKC4wGScf93+qIjP1sFgYQtvQlz7+NPbpwLaZ/qrL
	 mjsCOeFWu1w4nnP5tNhQg3LKe801Xg0lJE/BSCrgLPBhx2MBDiJKx7MFSR+jUj2hhG
	 s2g4KjcNWRBVw==
From: SeongJae Park <sj@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	brendan.higgins@linux.dev,
	feng.tang@intel.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 1/2] mm/damon/core-test: Fix memory leak in damon_new_region()
Date: Mon, 18 Sep 2023 05:33:20 +0000
Message-Id: <20230918053320.61408-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230918051044.3814018-2-ruanjinjie@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jinjie,


Thank you for this patchset!

On Mon, 18 Sep 2023 13:10:43 +0800 Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> The damon_region which is allocated by kmem_cache_alloc() in
> damon_new_region() in damon_test_regions() and
> damon_test_update_monitoring_result() are not freed and it causes below
> memory leak. So use damon_free_region() to free it.
> 
> unreferenced object 0xffff2b49c3edc000 (size 56):
>   comm "kunit_try_catch", pid 338, jiffies 4294895280 (age 557.084s)
>   hex dump (first 32 bytes):
>     01 00 00 00 00 00 00 00 02 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 49 2b ff ff  ............I+..
>   backtrace:
>     [<0000000088e71769>] slab_post_alloc_hook+0xb8/0x368
>     [<00000000b528f67c>] kmem_cache_alloc+0x168/0x284
>     [<000000008603f022>] damon_new_region+0x28/0x54
>     [<00000000a3b8c64e>] damon_test_regions+0x38/0x270
>     [<00000000559c4801>] kunit_try_run_case+0x50/0xac
>     [<000000003932ed49>] kunit_generic_run_threadfn_adapter+0x20/0x2c
>     [<000000003c3e9211>] kthread+0x124/0x130
>     [<0000000028f85bdd>] ret_from_fork+0x10/0x20
> unreferenced object 0xffff2b49c5b20000 (size 56):
>   comm "kunit_try_catch", pid 354, jiffies 4294895304 (age 556.988s)
>   hex dump (first 32 bytes):
>     03 00 00 00 00 00 00 00 07 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 96 00 00 00 49 2b ff ff  ............I+..
>   backtrace:
>     [<0000000088e71769>] slab_post_alloc_hook+0xb8/0x368
>     [<00000000b528f67c>] kmem_cache_alloc+0x168/0x284
>     [<000000008603f022>] damon_new_region+0x28/0x54
>     [<00000000ca019f80>] damon_test_update_monitoring_result+0x18/0x34
>     [<00000000559c4801>] kunit_try_run_case+0x50/0xac
>     [<000000003932ed49>] kunit_generic_run_threadfn_adapter+0x20/0x2c
>     [<000000003c3e9211>] kthread+0x124/0x130
>     [<0000000028f85bdd>] ret_from_fork+0x10/0x20

Nice finding!  Could you please share just a brief more detail about above cool
output, e.g., just the name of the tool you used, so that others can learn it
from your awesome commit message?

> 
> Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
> Fixes: f4c978b6594b ("mm/damon/core-test: add a test for damon_update_monitoring_results()")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  mm/damon/core-test.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
> index 6cc8b245586d..255f8c925c00 100644
> --- a/mm/damon/core-test.h
> +++ b/mm/damon/core-test.h
> @@ -34,6 +34,7 @@ static void damon_test_regions(struct kunit *test)
>  	KUNIT_EXPECT_EQ(test, 0u, damon_nr_regions(t));
>  
>  	damon_free_target(t);
> +	damon_free_region(r);

There is damon_destroy_region() function, which simply calls damon_del_region()
and damon_free_region().  Unless there is needs to access the region before
removing from the region, doing memory return together via the function is
recommended.

And this test code calls damon_del_region() just beofre above
KUNIT_EXPECT_EQ().  Hence, I think replacing the damon_del_region() call with
damon_destroy_region() rather than calling damon_free_region() may be simpler
and shorter.  Could you please do so?

>  }
>  
>  static unsigned int nr_damon_targets(struct damon_ctx *ctx)
> @@ -316,6 +317,8 @@ static void damon_test_update_monitoring_result(struct kunit *test)
>  	damon_update_monitoring_result(r, &old_attrs, &new_attrs);
>  	KUNIT_EXPECT_EQ(test, r->nr_accesses, 150);
>  	KUNIT_EXPECT_EQ(test, r->age, 20);
> +
> +	damon_free_region(r);

This looks nice.  Thank you for fixing this!

>  }
>  
>  static void damon_test_set_attrs(struct kunit *test)
> -- 
> 2.34.1
> 

Thanks,
SJ
