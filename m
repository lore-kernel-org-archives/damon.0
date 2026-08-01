Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B07374190
	for <damon@lists.linux.dev>; Sat,  1 Aug 2026 20:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785616189; cv=none; b=jDQn3XJjpmfcuY9PQYiJqaOLlOCHfIeOuhnjJaZgMEIsYymJZWcgBRJI/Y8lgFAA41sZ/HE7Yk7aENSxCUooOp8mLnNvWQtLmCCBt/djiQA+mmwwRlQ3sUaWaktiv+HX7pqeqdBh1yZJVG37j1VHHRMjQ937XejMJW74i9QIKe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785616189; c=relaxed/simple;
	bh=Q/zMQMcWQKUoHpt6OXd2X6z7qBv2xKTc4zYYk7zutpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VJNoyNh9t6P05skjyfiVpe+43Ox1TbQqs5+c1nyXuyR+K39/n0sdkgq9lhI7t4Qq2YB3cwPyfFhC6qPyI1mPXpmCkAyaauZHdTxzuAA3xdD+OnWNai6mMjVr6/q6Z0jp1tM+vebk2opvKJyZ68XR0UcRekpwjlMb5/YNqBraXK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ag/SfI4E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ag/SfI4E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C077A1F00AC4;
	Sat,  1 Aug 2026 20:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785616187;
	bh=ckQQ/h66WNG55Hlkzic6Zg92ZxCfOQRzBDPzRxRXpAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ag/SfI4EnlpFSJQvASlpYqc0cVWoB0ggGCwjAnsiZJoNP6HY/+ADuek1QjRpIXkoi
	 PQ70xa05jxqgPOHjPPjSVmz2btiJQ6SWvzDY+j9YcrzCTTEhvjYoDJWrj+gE5Bq8x5
	 qG6jNue39AwaV5vet/14VIuMa7r1B12q5BL+QTzLPr3EEvKXSHgwhNjH+d7ucD6sM4
	 IPGiDjJk1iMa4DzKIx2wq1LBFq0SYcuU+VQfuCH8dkG5jzCSkxlDjPHg0bPiAn7MN0
	 cvhBZsPVcux9ZKRLjM9zd4vgYcaogU829kYIoz43e8/FMAB+otpG4iVkGvLbw1HDxM
	 A3voLlfe85GPg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 9/9] mm/damon/core: handle extreme memory state in get_in_active_mem_bp()
Date: Sat,  1 Aug 2026 13:29:38 -0700
Message-ID: <20260801202939.117292-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260801193949.4270A1F00AC4@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 01 Aug 2026 19:39:48 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [Medium] The commit message incorrectly identifies the function being modified, failing to align its claims with the code changes.
> 
> Pre-existing issues:
> - [High] Multiplication overflow in `mult_frac()` and other basis point scaling calculations on 32-bit architectures leads to incorrect memory ratio calculations and scaling.
> --
> 
> --- Patch [9]: [RFC PATCH 9/9] mm/damon/core: handle extreme memory state in get_in_active_mem_bp() ---
> commit fee9e9f299e48399ca370c1f9725936302eaeb8c
> Author: SJ Park <sj@kernel.org>
> Subject: mm/damon/core: handle extreme memory state in get_in_active_mem_bp()
> 
> This patch prevents a divide-by-zero risk in DAMON's active memory ratio
> calculations. In extreme environments where active and inactive memory
> both amount to zero, the patch clamps the total memory denominator to a
> minimum of 1 to avoid a crash.
> 
> Link: https://lore.kernel.org/20260721034756.147011-1-sj@kernel.org
> 
> > damon_get_intervals_adaptation_bp() uses the sum of the active and
> > inactive memory amount as a denominator.  In an extreme and unlikely
> > environment, active and inactive memory might be zero.
> 
> [Severity: Medium]
> Is the function name referenced in the commit message correct?
> 
> The commit message explicitly states that damon_get_intervals_adaptation_bp()
> is being modified to fix a divide-by-zero bug, but the patch actually
> modifies damos_get_in_active_mem_bp().

Good catch, I will fix.

> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 76764a2056f7c..4944cf2c5afae 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -3010,7 +3010,7 @@ static unsigned int damos_get_in_active_mem_bp(bool active_ratio)
> >  		global_node_page_state(NR_LRU_BASE + LRU_ACTIVE_FILE);
> >  	inactive = global_node_page_state(NR_LRU_BASE + LRU_INACTIVE_ANON) +
> >  		global_node_page_state(NR_LRU_BASE + LRU_INACTIVE_FILE);
> > -	total = active + inactive;
> > +	total = max(active + inactive, 1);
> >  	if (active_ratio)
> >  		return mult_frac(active, 10000, total);
> 
> [Severity: High]
> This is a pre-existing issue, but does this calculation overflow on 32-bit
> architectures?
> 
> In damos_get_in_active_mem_bp(), if active memory exceeds approximately
> 429,496 pages (~1.75 GB), multiplying the active page count by 10000 inside
> mult_frac() will overflow an unsigned long on 32-bit systems before the
> division by total. This could result in artificially low active/inactive
> memory ratios and break DAMON's adaptive tuning.
> 
> Does this same overflow affect damon_feed_loop_next_input()?
> 
> That function returns last_input * score_cg / goal. When last_input is
> passed as 100,000,000 and score_cg can be up to 10,000, that multiplication
> would similarly wrap around 32-bit boundaries.

Known low priority issue.

> 
> >  	return mult_frac(inactive, 10000, total);
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260801173554.94710-1-sj@kernel.org?part=9


Thanks,
SJ
