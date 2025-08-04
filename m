Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210D71BEF7E
	for <damon@lists.linux.dev>; Mon,  4 Aug 2025 16:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754326209; cv=none; b=DGi62zqwnTEbXF2bqgQdwXU08kF5ojjMO2/RmUewPbvyvN8fZnWEUOw5Tbu3jujLVa8JSZ2Uv1+cAZ0nJKv1V/WayFsER0R5wMNh7ywuYytYMIfEhPNEhA4Gpi+3bAsID+j73CkTrbF6nbfNaLn8NEJ7T1tR6dLsUlDLpBanqH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754326209; c=relaxed/simple;
	bh=sg0wfArUiS/J2z/NCTuR83ouoFn/ZziZYXoh92TMywU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z1vB3+MWwKJnEXsHN1pxCMOTyJfpT154Lxkgjrht8jU9xGYhV3prcN3mAoBWdbppqeXrNmXP2iGJ+iC3hrZlWe9IHOreCa2zRO1I2rchbeJc+msEIx2jU75z+wI4gltmadGQL8jO40B8PwqMuutYGeSrhJm0o4T/EOAfjAPu3MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+ghLUCQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+ghLUCQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC2EC4CEF0;
	Mon,  4 Aug 2025 16:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754326208;
	bh=sg0wfArUiS/J2z/NCTuR83ouoFn/ZziZYXoh92TMywU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M+ghLUCQ+qJwZ4D5IndILpYS01N4bUrHZzAjpzxyZE2JN2iF50lUI2vCvgbzu0M5y
	 tA6dQ/3h34P0BzgjGG4v+bM0zUnBXI/XRFyN4qpD9Ul3ofu9NwiIGIeInbJVOt6ay9
	 W7cmqWOqiIn0aos99FWXRCkrmeJUUq1ZxsW+xgJtTmT0vINFOD04QJc+UD7QWB3Czx
	 eBg9a/gWT7PoI0wC0/ayoNkTU1PvKfo/4QjCte5Pcz1GFGHaHjoBdYcZ6EaneruqEH
	 FnRcql5Gl8VQ0BdNr5lACOkvZwg0RDHdRmP8Eo9hj2m/sEvRSVSS1I5tF7K/uYJtcU
	 KKm7VE3nlUC4g==
From: SeongJae Park <sj@kernel.org>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	honggyu.kim@sk.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH v2] mm/damon: update expired description of damos_action
Date: Mon,  4 Aug 2025 09:50:05 -0700
Message-Id: <20250804165005.55515-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250804143816.29654-1-ekffu200098@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Sang-Heon,

On Mon,  4 Aug 2025 23:38:16 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:

> Nowadays, damos operation actions support more various operation set.
> But comments(also, generated documentation) doesn't updated.
> So, fix the comments with current support status.
> 
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---
> Changes from v1 [1]:
> 1. change baseline from damon/next to mm/mm-new
> 2. Add note about DAMOS_PAGEOUT and demotion.

Thank you for making this revision!

> 
> [1] https://lore.kernel.org/all/20250731132230.80046-1-ekffu200098@gmail.com/
> 
> ---
> I also watch your comment from [1]. Thank you for not forgetting :)
> 
> [1] https://lore.kernel.org/damon/20250801233942.1614-1-sj@kernel.org/
> 
> ---
>  include/linux/damon.h | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index f13664c62ddd..d4b3ffd6144d 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -110,7 +110,7 @@ struct damon_target {
>   *
>   * @DAMOS_WILLNEED:	Call ``madvise()`` for the region with MADV_WILLNEED.
>   * @DAMOS_COLD:		Call ``madvise()`` for the region with MADV_COLD.
> - * @DAMOS_PAGEOUT:	Call ``madvise()`` for the region with MADV_PAGEOUT.
> + * @DAMOS_PAGEOUT:	Reclaim the region.
>   * @DAMOS_HUGEPAGE:	Call ``madvise()`` for the region with MADV_HUGEPAGE.
>   * @DAMOS_NOHUGEPAGE:	Call ``madvise()`` for the region with MADV_NOHUGEPAGE.
>   * @DAMOS_LRU_PRIO:	Prioritize the region on its LRU lists.
> @@ -123,8 +123,10 @@ struct damon_target {
>   * The support of each action is up to running &struct damon_operations.
>   * &enum DAMON_OPS_VADDR and &enum DAMON_OPS_FVADDR supports all actions except
>   * &enum DAMOS_LRU_PRIO and &enum DAMOS_LRU_DEPRIO.  &enum DAMON_OPS_PADDR
> - * supports only &enum DAMOS_PAGEOUT, &enum DAMOS_LRU_PRIO, &enum
> - * DAMOS_LRU_DEPRIO, and &DAMOS_STAT.
> + * supports all actions except &enum DAMOS_WILLNEED, &enum DAMOS_COLD,
> + * &enum DAMOS_HUGEPAGE, &enum DAMOS_NOHUGEPAGE.

I think we agreed[1] to add a reference to the design doc, instead of keeping
this duplicated.  Am I missing something?

> + *
> + * Note that DAMOS_PAGEOUT doesn't trigger demotions.
>   */
>  enum damos_action {
>  	DAMOS_WILLNEED,
> -- 
> 2.43.0

[1] https://lore.kernel.org/CABFDxMGh7-vDgNzepJKtrhdOF40_U7=NT6Jvm85qtdwGpBZawg@mail.gmail.com


Thanks,
SJ
