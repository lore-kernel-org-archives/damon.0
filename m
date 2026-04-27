Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBC432A3EC;
	Mon, 27 Apr 2026 15:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777302601; cv=none; b=L+KU8m3WbGgEWUl9ZRtdbm5pF9lsLFdySiDHajTyj/Y2zzIZ/h9E1CT702GkgsEXCrNb47pY19Jx7P40kuyxRyec31WpVBRmQdvXDrYZXDNx37dfin4eFeCwJc596gDjkywTcndW5qbaBiululbqQ12tMOOol7r2vOCOfl3U7eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777302601; c=relaxed/simple;
	bh=D3bN09nuD0jE5rvlzrltFtSzKt2ZOU/RkqRJSMh1fBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UDeG5YS7KjHNdJZN+KsL+IOzXN9MipjmmPSLqn4+rTMjsN+r+mAYMGfwuX3EqmQeaDPegEI9AtBGmaot3KlckOrroa8HhclgMqeXOY4RICDFt6Y4ulEFM2Np32N+rdPc8MeGH3KPLfyGJ46v00yJZEgdWFZWkHut3lmWkIjgVAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyy0b6B9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyy0b6B9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78193C19425;
	Mon, 27 Apr 2026 15:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777302600;
	bh=D3bN09nuD0jE5rvlzrltFtSzKt2ZOU/RkqRJSMh1fBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nyy0b6B9VE/dfGuew3dmPZtuzjUfaVeza2re4ZfVt33Oo2kBsgR7UQ+bpAfGTKxs8
	 K8qOtDgeJVmUBEy+xvqt8im4BrW8YcERDFCgCyFnrFZ9w0RjP+ykTnY4g3r1R8PDJf
	 pQ3pEvlP/hD3el2phaSsXfoyTf1rkBzMmC7iZ4xBx3Yoxbwzf9fbsW4UuOv/k97WHF
	 4f1TBnd1crDamBOoN0vaLN8iNOaY7PrvVfOmDuLW1+I/pP+4jM/ST/ZGhZgTfUL52X
	 RvXvV911e58lxaNCRfBFJdHgWEvND1y7SMbJ76Un/LYD3aUlGqXynnQ8BHlXEX7bYt
	 V4ixAnzZ9AqGA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Liew Rui Yan <aethernet65535@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2 1/4] mm/damon/ops-common: optimize damon_hot_score() using ilog2()
Date: Mon, 27 Apr 2026 08:09:57 -0700
Message-ID: <20260427150958.113205-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260426231619.107231-2-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 26 Apr 2026 16:16:14 -0700 SeongJae Park <sj@kernel.org> wrote:

> From: Liew Rui Yan <aethernet65535@gmail.com>
[...]
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c
> @@ -117,9 +117,12 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
>  		damon_max_nr_accesses(&c->attrs);
>  
>  	age_in_sec = (unsigned long)r->age * c->attrs.aggr_interval / 1000000;
> -	for (age_in_log = 0; age_in_log < DAMON_MAX_AGE_IN_LOG && age_in_sec;
> -			age_in_log++, age_in_sec >>= 1)
> -		;
> +	if (age_in_sec)
> +		age_in_log = min_t(int, ilog2(age_in_sec) + 1,
> +				DAMON_MAX_AGE_IN_LOG);
> +	else
> +		age_in_log = 0;
> +
>  
>  	/* If frequency is 0, higher age means it's colder */
>  	if (freq_subscore == 0)

Sashiko found this patch is introducing two blank lines.  Andrew, I saw you
already added this to mm-new.  Could you please add below attaching fixup?  If
you prefer reposting this patch, please let me know.


Thanks,
SJ

[...]
=== >8 ===
From 1d97945a7c35463d3757df985cf3545bf9d5ed9c Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Mon, 27 Apr 2026 08:05:09 -0700
Subject: [PATCH] mm/damon/ops-common: (fixup) remove unnecessary blank line

Two blank lines are unnecessary.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260426232811.618BFC2BCAF@smtp.kernel.org

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/ops-common.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 3a0ddc3ac7196..b2ce817f33c53 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -123,7 +123,6 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
 	else
 		age_in_log = 0;
 
-
 	/* If frequency is 0, higher age means it's colder */
 	if (freq_subscore == 0)
 		age_in_log *= -1;
-- 
2.47.3


