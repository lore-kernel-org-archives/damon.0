Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFC11922FD;
	Thu, 10 Oct 2024 16:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728577313; cv=none; b=mdJXgyoTJJwZ90/PAtG0UOLXWR9zOW4XYN2jTu7AF6tYacF5u3yARieux4eRbrwvWFO3b+Ntn0eCdKIA/UKwyDgj2nYdB3aFwB2kuOl6dRqpst18osoYl0WRtJCucU+6VZkwRYvG7ZEpxq/rWwxhxZsePX3LrNTNR/Y3tlwClZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728577313; c=relaxed/simple;
	bh=kz1uQzRl/tKG/88HfwDveiz+2UzYrHTsBIr7zPlf6UA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KtZkKR/ruabwmfnxjA2cmNaq3F7tQFAkUwpd4vZkuXncwKB/QKCATPMVr/VJ7HCbpKfa9OUsEVHzwve4y/baQ6EljeFX4EncYJ2I/x3S/HfQZwrNWvCXI+U291E1SEefRtv2jTP8dCo+L5ZAjHIVlVqGg6Nz64zbKAkVokxUzFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0fFDMh/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0fFDMh/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F2CC4CEC5;
	Thu, 10 Oct 2024 16:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728577312;
	bh=kz1uQzRl/tKG/88HfwDveiz+2UzYrHTsBIr7zPlf6UA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f0fFDMh/87OOyJeRRxkBBT49Oi0tCUXfEsHBl1hvivDvTG1w4KdRYr7yrhD4HkRG+
	 1+XvpWFLXl9wKKY9NibU1Eb2+aQbyzEhJRiPgYiNchl7n4bYQjgATt8ty4GorY9MkC
	 CCb49B/v463PjCnEuAUfQiLWDefMIk+t68qQZBpkIoToJMe6L6AlMhvtcJ0lOBwcTO
	 SL6a0ng58P+qGV+D0ki+g3KwOq52i/+MSl1lQ4nq1kVgpcK4MkkfXGiJcLl1IwfiVn
	 XtmrGwaeHPaG1M41/+fCwIq49NhFvfUBFfZ5w9l6pUxvjoLu2u5ji6ZnHOaPCTlvMv
	 rVXqshchTPvrg==
From: SeongJae Park <sj@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: Fix memory leak in damon_sysfs_test_add_targets()
Date: Thu, 10 Oct 2024 09:21:45 -0700
Message-Id: <20241010162145.195696-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241010125323.3127187-1-ruanjinjie@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jinjie,

On Thu, 10 Oct 2024 20:53:23 +0800 Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> The sysfs_target->regions allocated in damon_sysfs_regions_alloc()
> is not freed in damon_sysfs_test_add_targets(), which cause the following
> memory leak, free it to fix it.
> 
> 	unreferenced object 0xffffff80c2a8db80 (size 96):
> 	  comm "kunit_try_catch", pid 187, jiffies 4294894363
> 	  hex dump (first 32 bytes):
> 	    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> 	    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> 	  backtrace (crc 0):
> 	    [<0000000001e3714d>] kmemleak_alloc+0x34/0x40
> 	    [<000000008e6835c1>] __kmalloc_cache_noprof+0x26c/0x2f4
> 	    [<000000001286d9f8>] damon_sysfs_test_add_targets+0x1cc/0x738
> 	    [<0000000032ef8f77>] kunit_try_run_case+0x13c/0x3ac
> 	    [<00000000f3edea23>] kunit_generic_run_threadfn_adapter+0x80/0xec
> 	    [<00000000adf936cf>] kthread+0x2e8/0x374
> 	    [<0000000041bb1628>] ret_from_fork+0x10/0x20

Thank you for catching this issue and posting this fix!

> 
> Cc: stable@vger.kernel.org
> Fixes: b8ee5575f763 ("mm/damon/sysfs-test: add a unit test for damon_sysfs_set_targets()")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  mm/damon/tests/sysfs-kunit.h | 1 +
>  1 file changed, 1 insertion(+)

Can we update the subject prefix to "mm/damon/tests/sysfs-kunit:"?  I think
that will help readers understanding the change more easily.

Other than that,

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> 
> diff --git a/mm/damon/tests/sysfs-kunit.h b/mm/damon/tests/sysfs-kunit.h
> index 1c9b596057a7..7b5c7b307da9 100644
> --- a/mm/damon/tests/sysfs-kunit.h
> +++ b/mm/damon/tests/sysfs-kunit.h
> @@ -67,6 +67,7 @@ static void damon_sysfs_test_add_targets(struct kunit *test)
>  	damon_destroy_ctx(ctx);
>  	kfree(sysfs_targets->targets_arr);
>  	kfree(sysfs_targets);
> +	kfree(sysfs_target->regions);
>  	kfree(sysfs_target);
>  }
>  
> -- 
> 2.34.1
