Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6245A330315
	for <damon@lists.linux.dev>; Thu, 14 May 2026 02:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778724307; cv=none; b=SeNAB8ydYOGfKquRfpaMix7vZUktdL0xBKjEj+kFfxCJnE7FIZLPJQTdk2j1u8Xn2d3+815jSm21dPRCQLLagSTwpt2b/c8aHc+urmEMGlrPy+ALK+3yjyfb6rZM/BqhE+Rrx9zzkBwiXEx9mde39d9d4NzGcqqhsGKvAyZCpwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778724307; c=relaxed/simple;
	bh=w6in456NVx5qnJAoyyiOUGCYL1XpETR+tPEg75Igjy4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DeFFMEG/jjXBJQQjRAusG/WRmXmKZvusaiVOjyYpkzVPgWQitqIEaR8zpuYB2WepLquFVrQMpmEidqpSdS7vcKKx8QQR4i1cTVd1fnUYllP1bWYcHbnMSsFGc4coqQzgHtRNGEV4saRzxgz63zozl+PsGpRq8p9EnJhfFPf/Thc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTUsgZWH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTUsgZWH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1DB7C19425;
	Thu, 14 May 2026 02:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778724306;
	bh=w6in456NVx5qnJAoyyiOUGCYL1XpETR+tPEg75Igjy4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=DTUsgZWH2Pd9heRcX0QK62CFo1MT67B8WgtHmI1uGHFNWj6zKWyeTFvBJYFef4s6f
	 7mZXVnX5Qo1pZt2fcpCVt4ho3LniSTEDnsWNQvbgH1jFEVZbMAcBSbwD+S1K4FIMlg
	 +ymR2HTeIUEsKk56Gx2ox07HSfDtiDbfjZ5Dn9cyhVCQDq9O51OsC0URif68VkVp+h
	 EWQGg1akdemz2sv/nlfprl1HYEKc/0YrkCocvQcUsgB+hQs/54IO8WLGYDrvfynQkC
	 SIi7k+ugu/xGcmav09806/1xcJqnjQXJoWBhPhk44pq08QM0nY85hoZfje0nq0PEZh
	 cl1/9QDA8UpRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.6.y] mm/damon/reclaim: detect and use fresh enabled
 and kdamond_pid values
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260513045858.204442-1-sj@kernel.org>
References: <20260513045858.204442-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 02:05:06 +0000
Message-Id: <20260514020506.D1DB7C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Calls to undeclared and undefined functions `damon_is_running()` an=
d `damon_kdamond_pid()` will cause a build failure.
--

commit f496e53eab697919d0061167b54870a26d15920a
Author: SeongJae Park <sj@kernel.org>

mm/damon/reclaim: detect and use fresh enabled and kdamond_pid values

This commit modifies DAMON_RECLAIM to query the running status and kdamond =
PID
dynamically to avoid stale parameters.

Link: https://lore.kernel.org/20260419161003.79176-1-sj@kernel.org
Link: https://lore.kernel.org/20260419161003.79176-2-sj@kernel.org

> diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> index 586daa2cefe4f..e264f202714eb 100644
> --- a/mm/damon/reclaim.c
> +++ b/mm/damon/reclaim.c
[ ... ]
> @@ -203,60 +194,93 @@ static int damon_reclaim_turn(bool on)
[ ... ]
> +static bool damon_reclaim_enabled(void)
> +{
> +	if (!ctx)
> +		return false;
> +	return damon_is_running(ctx);

Will this cause a build failure? It appears damon_is_running() isn't declar=
ed
in include/linux/damon.h or defined anywhere in the tree.

> +}
[ ... ]
> +static int damon_reclaim_kdamond_pid_load(char *buffer,
> +		const struct kernel_param *kp)
> +{
> +	int kdamond_pid =3D -1;
> +
> +	if (ctx) {
> +		kdamond_pid =3D damon_kdamond_pid(ctx);

Will this also fail to compile? Similar to above, damon_kdamond_pid() doesn=
't
seem to be defined. Is this missing a dependency or an incomplete backport?

> +		if (kdamond_pid < 0)
> +			kdamond_pid =3D -1;
> +	}
> +	return sprintf(buffer, "%d\n", kdamond_pid);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513045858.2044=
42-1-sj@kernel.org?part=3D1
