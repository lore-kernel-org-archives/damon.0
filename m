Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB883191B0
	for <damon@lists.linux.dev>; Tue,  3 Feb 2026 16:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770135766; cv=none; b=oGcSIe/63f8F9JlUTrZrjuhjb3/eWSBB8f4XIiDouOkQ0mPoVzVPO6qzdhwftWGfM6VGt0eWGEXro+EQOB0T3B/45Ad62OcojeR3mWj7xXzzGFQ3iOxOsyCTajeyH9pu+FDiK436XO+8i9GE6oK90pekOH1cfmm0snJh1UTR0F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770135766; c=relaxed/simple;
	bh=1oyZKFwjfIKHh6YeT0LaiF3S2saMqK9ByktcAWWIavs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gA3ypIEeHLWYNWQyQim0HJiJQjOQ6fKBqDNMKSAUId/lnJWW/Mp8mqVWoy5m3IJ8iLPNU0G8yNNINUNn0o1D8DUjQTZop3Pwhryca64fCXxhq8tTKq0kL+AUNS8e8DYPPOKTl7GOqtzCmRKK7grQ9cqNIUndiW5J5yU85ua/rwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8tx6q1m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8tx6q1m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D756AC116D0;
	Tue,  3 Feb 2026 16:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770135766;
	bh=1oyZKFwjfIKHh6YeT0LaiF3S2saMqK9ByktcAWWIavs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g8tx6q1mPUSf1sJXgzbw92G3rlDMhAkfEXATLVPku582tk/LtlNIenhVOB2H5bFEL
	 TAfh/begikCvK3c8XBf5qXD6iYsx84tWXMpfsNNFo32z2Q0ccGzKzUVgryVAsjPxUX
	 FmA93KD1+YcSmT6S1wWrVGMX1kHCN+tEmdFRzPGIU/Vjt10UNyBMSsdYk/3vgpSY40
	 nAnMGtBI0Zdj12UpMkEW93pf1gLHRLiKNLeTZZHnlDtlaJl5PW7eI7D1hDeujyoQrO
	 28zvS2EdH+ytwUZTrC9Nsj8f/WM3ZcFyQP2SCSfY6Hly4/YnLp3qsxqLnhpML3AG1a
	 wxTh30Z8+rOkw==
From: SeongJae Park <sj@kernel.org>
To: qinyu <qin.yuA@h3c.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm/damon: remove redudnant mmu notifier call in pmdp mkold
Date: Tue,  3 Feb 2026 08:22:41 -0800
Message-ID: <20260203162242.46851-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260203095400.2465255-1-qin.yuA@h3c.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello qinyu,


I'd recommend to use "mm/damon/ops-common:" as the prefix of the commit
message.  Hopefully Andrew will make the modification when he adds this to the
mm tree.  For a case that Andrew might not since he must be busy for next merge
window, I will keep this patch in my tree with the subject change for a while
and repost if it is not picked up by Andrew for a while.  So you don't need to
repost this patch for the trivial change :)

On Tue, 3 Feb 2026 17:54:00 +0800 qinyu <qin.yuA@h3c.com> wrote:

> Currently, mmu_notifier_clear_young() is called immediately after
> pmdp_clear_young_notify(), which already calls mmu_notifier_clear_young()
> internally. This results in a redundant notifier call.
> 
> Replace pmdp_clear_young_notify() with the non-notify variant to avoid the
> duplicate call and make the pmdp path consistent with the corresponding
> ptep_mkold() code.

Nice catch, thank you!

> 
> Signed-off-by: qinyu <qin.yuA@h3c.com>

FWIW, Linux disallows anonymous contribution, and this tag should use a known
identity [1].  I was thinking about recommending to use real name, but I found
there are a few patches that using this identity (though email is different),
so looks fine to me.

    $ git log --author qinyu --oneline --pretty="%an <%ae>" linus/master
    Qinyun Tan <qinyuntan@linux.alibaba.com>
    qinyu <qinyu32@huawei.com>
    qinyu <qinyu32@huawei.com>
    qinyu <qinyu32@huawei.com>

[1] https://docs.kernel.org/process/submitting-patches.html#developer-s-certificate-of-origin-1-1

Reviewed-by: SeongJae Park <sj@kernel.org>

> ---
>  mm/damon/ops-common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> index a218d9922..8c6d61342 100644
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c
> @@ -90,7 +90,7 @@ void damon_pmdp_mkold(pmd_t *pmd, struct vm_area_struct *vma, unsigned long addr
>  		return;
>  
>  	if (likely(pmd_present(pmdval)))
> -		young |= pmdp_clear_young_notify(vma, addr, pmd);
> +		young |= pmdp_test_and_clear_young(vma, addr, pmd);
>  	young |= mmu_notifier_clear_young(vma->vm_mm, addr, addr + HPAGE_PMD_SIZE);
>  	if (young)
>  		folio_set_young(folio);
> -- 
> 2.33.0


Thanks,
SJ

[...]
