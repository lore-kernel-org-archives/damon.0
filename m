Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9EF1DFF7;
	Mon, 20 Oct 2025 15:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760973199; cv=none; b=XrlwJQCf84K7czXtqc53iG08U9x7H8h6tQoqYxGYmkxtkqhoSk8lIFvp3J6kJN0DjWYWpXCFNiA/eEc2LE92bC8UE3NxJ692dSZ8sH88nxLWVCeYKKvqiNGgQY8ya1XAZPXG3JUV440Uc2c3DXi4z4fOfT65G2PVss+vQYCpS4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760973199; c=relaxed/simple;
	bh=YqHSvPd7oXvJfa97f+UihKrYm4qSWMBIKneomnSlbWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CixbwNyzppKqAz6AQF0928ONoYNX4s3KWBz56uG7f5CNz2qhJ4ptfMx2/r1ig5q9yBeI3l2xCFDL9SOtqDhD9pP9WqUAHKvIyqBDC35nG9YJ2pWdNx5EMll3aPtPl5o2JK5WNaR2CKRdCfimCJ8n5Et6iltlNlNnUgK6w3jBuNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIIIdDA9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIIIdDA9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC74EC4CEF9;
	Mon, 20 Oct 2025 15:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760973198;
	bh=YqHSvPd7oXvJfa97f+UihKrYm4qSWMBIKneomnSlbWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VIIIdDA9KQzEaz89j2hXJTZ67sI6wWiDy25wwwN0tp292Bec6F1OmUqRdYJBICquf
	 GG1TmYy+LJdEP622X97TR3SCiL7iwhZYL9Oj40dzQgc+ZJS+c2VWv/RcAyVYThvRx1
	 mVhSRu2avHN+FrR5uDg+XP6VsyrQym7sk7YKl2U8Jo3WnUlFGNfHeDNyeM4Ld6ZDxN
	 Yc86V8EjMKY8agrMd2hJoJ9lUBE+HbDaStx59927+wNEWcyouoK3DcCa9rQknxGcul
	 2vh5gbckgtelfWEPj+bFaYQR8ku0LTZsCg+jOowA9Wvrz6DsNS863lq0NeK2KFbEqN
	 oVQ+8q/9v/tow==
From: SeongJae Park <sj@kernel.org>
To: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev (open list:DAMON),
	linux-mm@kvack.org (open list:DAMON),
	linux-kernel@vger.kernel.org (open list),
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com
Subject: Re: [PATCH] mm/damon/sysfs-schemes: Validate nid usage in nid_show()
Date: Mon, 20 Oct 2025 08:13:15 -0700
Message-ID: <20251020151315.66260-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251020112824.144391-1-swarajgaikwad1925@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Swaraj,

On Mon, 20 Oct 2025 11:28:24 +0000 Swaraj Gaikwad <swarajgaikwad1925@gmail.com> wrote:

> The nid_show() function previously returned the node ID (nid) without
> verifying if the goal object of damos_sysfs_quota_goal was using a
> node-based metric. This could lead to incorrect reporting when the
> goal metric was unrelated to node memory.
> 
> This patch introduces a validation step to ensure that nid_show() only
> returns the node ID for valid node-based metrics:
> - DAMOS_QUOTA_NODE_MEM_USED_BP
> - DAMOS_QUOTA_NODE_MEM_FREE_BP
> 
> For other metrics, it returns -EINVAL to prevent misleading information.
> 
> Tested with KUnit:
> - Built kernel with KUnit and DAMON sysfs tests enabled.
> - Executed KUnit tests:
>   ./kunit.py run --kunitconfig ./mm/mm/damon/tests/.kunitconfig
> - All 25 tests passed, including damon_sysfs_test_add_targets.

So nice patch, thank you!  I have a comment below, though.

> 
> Based on commit 3a8660878839 ("Linux 6.18-rc1").

Maybe this is better to be put under the below comment section [1].

> 
> Signed-off-by: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
> ---
>  mm/damon/sysfs-schemes.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 6536f16006c9..23a73b94fe53 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
> @@ -1112,7 +1112,16 @@ static ssize_t nid_show(struct kobject *kobj,
>  	struct damos_sysfs_quota_goal *goal = container_of(kobj, struct
>  			damos_sysfs_quota_goal, kobj);
>  
> -	/* todo: return error if the goal is not using nid */
> +	switch (goal->metric) {
> +		case DAMOS_QUOTA_USER_INPUT:
> +		case DAMOS_QUOTA_SOME_MEM_PSI_US:
> +			return -EINVAL;
> +		case DAMOS_QUOTA_NODE_MEM_USED_BP:
> +		case DAMOS_QUOTA_NODE_MEM_FREE_BP:
> +			break;
> +		default:
> +			return -EINVAL;
> +	}
>  
>  	return sysfs_emit(buf, "%d\n", goal->nid);
>  }

According to 'git bisect', I in the past actually added the todo comment.  But,
I of now cannot remember why I in the past did think that's something to do.  I
now think this function is better to be simply show the value the user has set
last time, since users could set the metrics after setting nid.  Other similar
parameters also work in the way, to be wiring-order independent, so that simple
behavior would be better for consistency, too.

I'm sorry if the wrong todo comment was confusing you, Swaraj.  Would you mind
sending a patch removing only the todo comment, without introducing any
behavior change?

[1] https://docs.kernel.org/process/submitting-patches.html#commentary


Thanks,
SJ
