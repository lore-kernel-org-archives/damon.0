Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548C327FD70
	for <damon@lists.linux.dev>; Tue,  1 Jul 2025 17:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751389209; cv=none; b=IH8DW3wbB9yaoc4znZrdG3skf22prt+JsRz/QXgazK0eHit1jnjTDSBdIRe+K5CVaTebZvQtM3dEnwySCi/7uqMxxrN5tXticnZLFSc6NN4lOTHHZqvvgvge8rv3Bq4UvYGR6kUTNuRQAgF0cLk1QRx6D3Ef6nF8mmvMyk4lbsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751389209; c=relaxed/simple;
	bh=D/dzfuWq5fU7kfRdTPL5faPwKJ+ftpTxGZLbdwu0dCE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cyPqNAjmq7p7+kieFQhS+NU0QvwJ1lTWxcJyqbbwBeCBDYZMyKTWZ0GoIwxLg5SzARHT+Mbkh+EGJOcz77r8u+HC80He2QOPlRsqbHHSLHWQd7vECXLHvdf7+OF36gGBig06RFz2dej6L95HZcnQ30kGoOppk3XZ+9PtquW+dmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9BFkX9F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9BFkX9F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D6EC4CEEF;
	Tue,  1 Jul 2025 17:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751389209;
	bh=D/dzfuWq5fU7kfRdTPL5faPwKJ+ftpTxGZLbdwu0dCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G9BFkX9Fv2wk+6CY5wyKNfI6L/qK6mrvhiDkLlNFlTPQm1DpEc1ca+eGWoBkHMp2I
	 +7OmE+nsrTH3+YoFQjX8CurBROFXhrsaOSnEr45cJhMVsDkzrM93O32DCg/MxYxx3O
	 UuQZc3PTTGXWrRYwrn9q3AZPBKQWMCKSvGpZm5PaI2+epMVHW3i/aedQx+0k/YHHXU
	 /lGQTabnLlGnlK3vTtF5iYZHyE5lb7ne4CFthDFMEJ++Ub//+YHAwHZPHYT1Xz9Vzw
	 eOUKr7mAvXLN+4sSmSJFHzKUfFvaSL3s66q4QRf8X78vTvZlk4iJeP1uy69e8927N5
	 Gx7JtawPl+RFg==
From: SeongJae Park <sj@kernel.org>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	Yunjeong Mun <yunjeong.mun@sk.com>
Subject: Re: [PATCH v2 4/4] mm/damon: fix divide by zero in damon_get_intervals_score()
Date: Tue,  1 Jul 2025 10:00:06 -0700
Message-Id: <20250701170006.53864-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250701081927.1873-5-honggyu.kim@sk.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Honggyu,

On Tue,  1 Jul 2025 17:19:26 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

> The current implementation allows having zero size regions with no
> special reasons, but damon_get_intervals_score() gets crashed by divide
> by zero when the region size is zero.
> 
>   [   29.403950] Oops: divide error: 0000 [#1] SMP NOPTI
> 
> This patch fixes the bug, but does not disallow zero size regions to
> keep the backward compatibility since disallowing zero size regions
> might be a breaking change for some users.
> 
> Fixes: f04b0fedbe71 ("mm/damon/core: implement intervals auto-tuning")
> Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> Cc: Yunjeong Mun <yunjeong.mun@sk.com>
> ---
>  mm/damon/core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index b217e0120e09..e274a4d958d6 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1448,7 +1448,10 @@ static unsigned long damon_get_intervals_score(struct damon_ctx *c)
>  			access_events += sz_region * r->nr_accesses;
>  		}
>  	}
> -	target_access_events = max_access_events * goal_bp / 10000;
> +	if (likely(max_access_events) > 0)

This makes checkpatch.pl complaints as below:

WARNING: Using likely should generally have parentheses around the comparison
#39: FILE: mm/damon/core.c:1451:
+       if (likely(max_access_events) > 0)

This is not performance critical part, so I think we can simply drop likely().

> +		target_access_events = max_access_events * goal_bp / 10000;
> +	else
> +		target_access_events = 1;

But, target_access_events could still be zero if goal_bp is zero or
max_access_events * goal_bp is less thatn 10000?

I'd like to simply do the target_access_events calculation as is, and set
target_access_events as 1, if it is zero.  Since this is not a performance
critical path, I think that's ok.

Also, in the previous version, we discussed the reproduction step requires
sample modules.  But seems we can also reproduce this with the official DAMON
sysfs ABI by setting the intervals goal zero, and I just confirmed that.  Let's
Cc stable@.

>  	return access_events * 10000 / target_access_events;
>  }
>  
> -- 
> 2.34.1


Thanks,
SJ
