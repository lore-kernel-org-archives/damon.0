Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8077B101EE
	for <damon@lists.linux.dev>; Thu, 31 Jul 2025 17:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753984711; cv=none; b=Np6g8b28y5ITPKWOcj1BAqAv5Xpn6yxwd/uPSUUJfJm+YZzwYjOdJDcnL4r463B+5dqTg1win4PJnhPcKCNh0LQjvOvl/gVq5b8KL4CzNlQGEyeLtGFDLrtJngCfCB3ZvcJ0JBiYkcXCZBqVNa2BUybBYkkONE9LpUIGoLb1NxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753984711; c=relaxed/simple;
	bh=3Md3e/uSIQs0aF7CCYWxANDDnjRBzUvnUohCGN3vc4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i4gmxvlADGF4ykhEjq30QvyDC34FPDIbAbMtj6NRrKYu7D5WlgqTV1/5cMgbA860kjJDWrtkOHpUG/xy2f8WEyZVM5qX3L0pKh/pq5s1/EtdHPU26aMg+MCvJof5UpDAeqKG3rz7yccEYr/2yfVa+MYoxZU7/Du3GiSm/22zjdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t1xK/czb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1xK/czb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB8C0C4CEEF;
	Thu, 31 Jul 2025 17:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753984711;
	bh=3Md3e/uSIQs0aF7CCYWxANDDnjRBzUvnUohCGN3vc4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t1xK/czb/C4PFt3IF1V0vOT65+aZYuahcyp+0/buONZPYGyIZ5ROEQzIWjRtHfzko
	 HJ27jmAEDquL78HdnaGa7HtlRrDzuxywd4EAxm+4J3UvnSoTrDgUUHr/G9Y53sCPxR
	 UIdR7Uknw61s1xFywlHr0weNZIeDMakB6PYS+PhZ5Ac0pJKY6wIX14POYgyYZEUTBs
	 YkiWlL8/PGM9HnRu0QdSg1Fp7d9Gej++fvVgMVrMGfzxVMakvCzNJJagocHCqIl/sc
	 Lz8P91FvrnqjAX/jC6gpQUQZ2R7OnTeomvpnVt6tl2n85hyrCxKe1nbICyjAgMy9mY
	 ne9nPoj7x/Fcw==
From: SeongJae Park <sj@kernel.org>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	honggyu.kim@sk.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon: update expired description of damos_action
Date: Thu, 31 Jul 2025 10:58:27 -0700
Message-Id: <20250731175827.16060-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250731132230.80046-1-ekffu200098@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Sang-Heon,

On Thu, 31 Jul 2025 22:22:30 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:

> Nowadays, damos operation actions support more various operation set.
> But comments(also, generated documentation) doesn't updated.
> So, fix the comments with current support status.

Thank you for catching this and fixing!

> 
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---
> I also found below patch(https://lore.kernel.org/damon/20250730200239.60984-1-sj@kernel.org/T/#t)
> So, Is it means that DAMOS_STAT is only supported by paddr now?

No.  'vaddr' supports DAMOS_STAT.  The patch is not adding DAMOS_STAT support
on vaddr, but extending the support for DAMOS filters.

Thank you for checking the thread and asking this question, though.  I see this
as an important signal of another rooms to improve on the documentation.

> If my understanding is correct, then we need to fix Design documentation
> and comments both.
> 
> However, since it will be fixed soon. Keeping current status is also
> affordable. So could you check this point as well? 
> 
> ---
> 
>  include/linux/damon.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index cddf82eaac4e..0870e9f48b0f 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -128,7 +128,7 @@ struct damon_access_report {

Seems you are using damon/next as your baseline.  If there is no real
dependencies to damon/next, please use mm-new as your baseline.  For more
contexts about that, please refer to the DAMON maintainer-profile[1].

>   *
>   * @DAMOS_WILLNEED:	Call ``madvise()`` for the region with MADV_WILLNEED.
>   * @DAMOS_COLD:		Call ``madvise()`` for the region with MADV_COLD.
> - * @DAMOS_PAGEOUT:	Call ``madvise()`` for the region with MADV_PAGEOUT.
> + * @DAMOS_PAGEOUT:	Reclaim the region.

Nice!

>   * @DAMOS_HUGEPAGE:	Call ``madvise()`` for the region with MADV_HUGEPAGE.
>   * @DAMOS_NOHUGEPAGE:	Call ``madvise()`` for the region with MADV_NOHUGEPAGE.
>   * @DAMOS_LRU_PRIO:	Prioritize the region on its LRU lists.
> @@ -146,8 +146,8 @@ struct damon_access_report {
>   * The support of each action is up to running &struct damon_operations.
>   * &enum DAMON_OPS_VADDR and &enum DAMON_OPS_FVADDR supports all actions except
>   * &enum DAMOS_LRU_PRIO and &enum DAMOS_LRU_DEPRIO.  &enum DAMON_OPS_PADDR
> - * supports only &enum DAMOS_PAGEOUT, &enum DAMOS_LRU_PRIO, &enum
> - * DAMOS_LRU_DEPRIO, and &DAMOS_STAT.
> + * supports all actions except &enum DAMOS_WILLNEED, &enum DAMOS_COLD,
> + * &enum DAMOS_HUGEPAGE, &enum DAMOS_NOHUGEPAGE.

Thank you for updating this!

But, now I find this place is having outdated information that partially
duplicated with the DAMON design document[2].  I think the design document is
better to maintain this kind of details.  What about keeping the high level
information but giving a reference to the documentation for details, for
example, like below?

    @@ -143,11 +143,9 @@ struct damon_access_report {
      * @DAMOS_STAT:                Do nothing but count the stat.
      * @NR_DAMOS_ACTIONS:  Total number of DAMOS actions
      *
    - * The support of each action is up to running &struct damon_operations.
    - * &enum DAMON_OPS_VADDR and &enum DAMON_OPS_FVADDR supports all actions except
    - * &enum DAMOS_LRU_PRIO and &enum DAMOS_LRU_DEPRIO.  &enum DAMON_OPS_PADDR
    - * supports only &enum DAMOS_PAGEOUT, &enum DAMOS_LRU_PRIO, &enum
    - * DAMOS_LRU_DEPRIO, and &DAMOS_STAT.
    + * The support of each action is up to running &struct damon_operations.  Refer
    + * to 'Operation Action' section of Documentation/mm/damon/design.rst for
    + * status of the supports.
      */

Thanks,
SJ


[1] https://origin.kernel.org/doc/html/next/mm/damon/maintainer-profile.html#scm-trees
[2] https://origin.kernel.org/doc/html/next/mm/damon/design.html#operation-action
