Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BD6186284;
	Thu, 19 Mar 2026 04:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773894798; cv=none; b=eue9W7f0rZgQZcS9QHxQp/9UCmtcw/7LClV6lQEe16VLYIr5PDbG56Mn2MZe30k1R8XtRVn56WoIVD4DKnglU7DMdHAHEMRjDarZha7RMo0Nc2SdRLZZ+vSPFqe2ixKLMCdc7MQd0/E+QW7EJZdEKuNel1YSGGvOc+ptkATO+kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773894798; c=relaxed/simple;
	bh=mSNgVn5RpvDCA5+rZqK/Pe5nbtq8ZzrNpNEVCWcL2b8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mnh7bTUvSrwMYjd+EngUjSQWATJmAbE4pjFEh28jE91UFn6kId8MwzCi+mqlWeAE5PianSkj7zt+wgAcibelNnRzF/Y9UEQOOMnSCsIyKG4cM96OYJrbrh02xupKpz04we5OPa1VBprF8JARdQQ7a8HpPgw9BwmrDf/L6lIasUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g2eTnLoX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2eTnLoX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5363DC19425;
	Thu, 19 Mar 2026 04:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773894797;
	bh=mSNgVn5RpvDCA5+rZqK/Pe5nbtq8ZzrNpNEVCWcL2b8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g2eTnLoXM7MeuOic6YYUAIoBIl+CCfhXUeLKJqY8v7eAG4dnZ0VpNaOcq/dNipV/3
	 j6BjO+YeNVCtp7UdgUDzdLxIazTE92++kiFSZQIQjEj6yjCEX0wx8CSnDT3FTx3000
	 qqruIXUHh525AIEfz8fGR72QsW+bMkgJhn4TYPMhk8watPcWFL/I+gLiYix7H1RN5B
	 cvUWBTuhSTLX8YEpeGsaUsqKJk67Qr6DFh+dvx75i+5UsMN9n0Qpg9D2AJSrISpxEh
	 sU5yCcjvrR3LpyvU0eR+5/BsWaA5I6Ewd2R3y3Cp2InlzpE+BQe+ful6NDGJD12d33
	 wDTgLCa2gPkRg==
From: SeongJae Park <sj@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/core: reset nr_dests on allocation failure in damos_commit_dests()
Date: Wed, 18 Mar 2026 21:33:09 -0700
Message-ID: <20260319043309.97966-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260318214939.36100-1-objecting@objecting.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Josh,

On Wed, 18 Mar 2026 21:49:39 +0000 Josh Law <objecting@objecting.org> wrote:

> damos_commit_dests() frees the old node_id_arr and weight_arr before
> reallocating.  If kmalloc_array() fails, the function returns -ENOMEM but
> leaves dst->nr_dests at its previous value.  A subsequent call with the
> same nr_dests will skip the reallocation (the sizes match), and the loop
> at the end will dereference the now-NULL array pointers.

Nice catch.  But, this is a sort of intended behavior.

The idea behind the code is that, if the function fails, the caller will
not resue 'dst' but discard it.  Hence the function is only ensuring the 'dst'
after the failure can be deallocated using the deallocation helper function
like 'damon_destroy_scheme()'.  For this, the function is setting weight_arr as
NULL in the allocation failure.

> 
> Fix this by resetting dst->nr_dests to 0 immediately after freeing the
> old arrays, so any later call always enters the reallocation path.
> 
> Fixes: cbc4eea4ffb5 ("mm/damon/core: commit damos->migrate_dests")
> Signed-off-by: Josh Law <objecting@objecting.org>
> ---
>  mm/damon/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 7f74982535ac..e233eb84a2d5 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1060,6 +1060,7 @@ static int damos_commit_dests(struct damos_migrate_dests *dst,
>  	if (dst->nr_dests != src->nr_dests) {
>  		kfree(dst->node_id_arr);
>  		kfree(dst->weight_arr);
> +		dst->nr_dests = 0;
>  
>  		dst->node_id_arr = kmalloc_array(src->nr_dests,
>  			sizeof(*dst->node_id_arr), GFP_KERNEL);

Someone (including a part of myself) could argue anyway initializing the field
is better to do, for code readability and completeness of the data structure.
But I'd argue that might only encourage calllers to reuse 'dst' after the
failure.  Also, the 0 nr_dests could still meaning something incorrect, if the
first kmalloc_array() for node_id_arr success but the following kmalloc_array()
for weight_arr failed.  In the case, nr_dests is zero, but the size of
node_id_arr is not zero.

I think the intention behind the code is not well documented and that might
confused you.  Sorry if that was the case.  I think this could better be
documented by adding comments for the function.  The single line comment in the
function body was for the purpose, but having more detailed comments at the top
of the function may be better.  If you'd like to send such documentation,
please do so.  If not, I will do that.  Whatever is your preference, thank you
for finding and sharing this room to improve!

... And, this patch helped me finding something actually broken.  As I
mentioned above, callers of damos_commit_dests() are assumed to discard the
'dst' when the function failed.  And the only caller, sysfs.c, does so, except
for the final commit to the running context (kdmond->damon_ctx).  It can result
in DAMON running with the incorrect data structure, doing NULL dereference.
Similar issue might exist for DAMON_RECLAIM and DAMON_LRU_SORT.  Because those
modules use only limited parameters, there might be not.  I will double check
and make a fix soon.  Again, thank you for helping me finding this issue, Josh!


Thanks,
SJ
