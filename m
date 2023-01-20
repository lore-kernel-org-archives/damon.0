Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A8933E9
	for <damon@lists.linux.dev>; Fri, 20 Jan 2023 17:32:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80CBEC433EF;
	Fri, 20 Jan 2023 17:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674235926;
	bh=66lCwGr0kp2dV1EmIDVsi3nb8gKPsiT1pssRkZM63gw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kzGNUytQ/EN25BaE3o4Jm9mc/FX9YNMeRuRbcyWs1Jw5BvNv2RtE+xsUd5EhH4Diu
	 GIVavSCtdeqkvMya55jk7xkTGvZrfwSJQ8Jbz20rEq3IOhz185yqUSv8+LCzVo7rzZ
	 Efoxx1SXEcEgqqqubUmXGTtBWVvnevdTvlH89qxTUhK32Tii1oNvZx1Nk9J/mksB4p
	 Y9mB6jY1UcioeghSLXHW6iHTCv5VxkSYpQFQTxSAZQTudCkdu9h4kOwEL+9oFwWqgP
	 zvxzakFDHuQgK0BNgqQtjaOCWD3C6T18Is34IdLOCRsn+r5mt1HvSyDvVwZ92A+16B
	 k59IQez5f3GcA==
From: SeongJae Park <sj@kernel.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	maple-tree@lists.infradead.org,
	SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v4 30/49] mm/damon/vaddr-test.h: Stop using vma_mas_store() for maple tree store
Date: Fri, 20 Jan 2023 17:32:03 +0000
Message-Id: <20230120173203.150532-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230120162650.984577-31-Liam.Howlett@oracle.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Liam,

On Fri, 20 Jan 2023 11:26:31 -0500 "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:

> Prepare for the removal of the vma_mas_store() function by open coding
> the maple tree store in this test code.  Set the range of the maple
> state and call the store function directly.
> 
> Cc: SeongJae Park <sj@kernel.org>
> Cc: damon@lists.linux.dev
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
>  mm/damon/vaddr-test.h | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/damon/vaddr-test.h b/mm/damon/vaddr-test.h
> index bce37c487540..c4b455b5ee30 100644
> --- a/mm/damon/vaddr-test.h
> +++ b/mm/damon/vaddr-test.h
> @@ -14,19 +14,26 @@
>  
>  #include <kunit/test.h>
>  
> -static void __link_vmas(struct maple_tree *mt, struct vm_area_struct *vmas,
> +static int __link_vmas(struct maple_tree *mt, struct vm_area_struct *vmas,
>  			ssize_t nr_vmas)
>  {
> -	int i;
> +	int i, ret = -ENOMEM;
>  	MA_STATE(mas, mt, 0, 0);
>  
>  	if (!nr_vmas)
> -		return;
> +		return 0;
>  
>  	mas_lock(&mas);
> -	for (i = 0; i < nr_vmas; i++)
> -		vma_mas_store(&vmas[i], &mas);
> +	for (i = 0; i < nr_vmas; i++) {
> +		mas_set_range(&mas, vmas[i].vm_start, vmas[i].vm_end - 1);
> +		if (mas_store_gfp(&mas, &vmas[i], GFP_KERNEL))
> +			goto failed;
> +	}
> +
> +	ret = 0;
> +failed:
>  	mas_unlock(&mas);
> +	return ret;
>  }
>  
>  /*
> @@ -71,7 +78,8 @@ static void damon_test_three_regions_in_vmas(struct kunit *test)
>  	};
>  
>  	mt_init_flags(&mm.mm_mt, MM_MT_FLAGS);
> -	__link_vmas(&mm.mm_mt, vmas, ARRAY_SIZE(vmas));
> +	if (__link_vmas(&mm.mm_mt, vmas, ARRAY_SIZE(vmas)))
> +		kunit_skip(test, "Failed to create VMA tree");
>  
>  	__damon_va_three_regions(&mm, regions);
>  
> -- 
> 2.35.1
> 
> 
