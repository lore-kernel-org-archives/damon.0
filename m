Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B398C34CDD
	for <damon@lists.linux.dev>; Thu, 16 Apr 2026 00:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776301176; cv=none; b=dCFv9/n/Q3vsJRjvIiTbY9hvEZAc7fM/YRIlL8drzoVMRrduCH3U+38fgnfUFQRfj6OhklkfhthfwWMiJhi079oO1t1e610ItM6OeP9iGGZG+OGdWwp/gOmPzkj99cMz4lh2W3Orv2om/WOfnPR0/mZxpK3xKsPboBkR0D2XNrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776301176; c=relaxed/simple;
	bh=Q2mAdtee5+FS07PQ4HOMBoN0dHplqqioBk3H+OcdCMw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mHeLCcsbAbmfKuXM2L204XTish3OpHShXi5B14SeCk1NB2tkrlfCYcajWKW75hY/dFutkWCK4I3KwZUxBL9hzGQ/oTv72rSavCdZUmM5OhD2I1cIBLCUhz76y7Q/njrA2yv3NYgKyrY8zo/xjQDoKZZ1b3Hixg5pURa/ejcUEYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzqK/FHN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzqK/FHN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F477C19424;
	Thu, 16 Apr 2026 00:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776301176;
	bh=Q2mAdtee5+FS07PQ4HOMBoN0dHplqqioBk3H+OcdCMw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=MzqK/FHNLjGp4cqxSdx/gtHfwRyLBWjqsiqFe661/IjPaR0F64mtoVNLGP38FFYo6
	 EaXfS0rfLrK9XT9+mx3olCYdqlopg8lZZfqHNW+U1XY1/M8qWI1bu/1AsLRQqk/s3k
	 28ntVRhOQjWMABIGRPLFNQQh8TPySbcxk5EmdFLpa0Hxu15GQuPBzmllIeHJLN954i
	 QancglC+MrkNM3QwydwcIYAjjXD4YaofOYJIt2E5jtBpy5ZsVD6U/PB+rYLEcwe5wy
	 lsJ/IaRhQdPtsEwgiUQeAz5t02mZ58PoXV+n74NZMFrJ9ojE6tlXsaaIo6bALUxr6q
	 Y72qbCJJHB5VA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.2 1/2] mm/damon/stat: add a parameter for reading
 kdamond pid
Reply-To: sashiko@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260416002149.87090-2-sj@kernel.org>
References: <20260416002149.87090-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Apr 2026 00:59:35 +0000
Message-Id: <20260416005936.7F477C19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Sashiko AI review found 1 potential issue(s):
- [Medium] Stale `kdamond_pid` exposed to userspace if `damon_call()` fails=
 during startup.
--

commit 46eb0a4278ccd2dec190db28b78b0766b8865901
Author: SeongJae Park <sj@kernel.org>

mm/damon/stat: add a parameter for reading kdamond pid

This commit exposes the pid of the DAMON_STAT kdamond via a new read-only
module parameter named kdamond_pid, standardizing usage with other DAMON
modules.

> diff --git a/mm/damon/stat.c b/mm/damon/stat.c
> index 99ba346f9e325..4901e9a7c3398 100644
> --- a/mm/damon/stat.c
> +++ b/mm/damon/stat.c

[ ... ]

> @@ -260,6 +269,14 @@ static int damon_stat_start(void)
>  		damon_stat_context =3D NULL;
>  		return err;
>  	}
> +	kdamond_pid =3D damon_kdamond_pid(damon_stat_context);
> +	if (kdamond_pid < 0) {
> +		err =3D kdamond_pid;
> +		kdamond_pid =3D -1;
> +		damon_destroy_ctx(damon_stat_context);
> +		damon_stat_context =3D NULL;
> +		return err;
> +	}
> =20
>  	damon_stat_last_refresh_jiffies =3D jiffies;
>  	call_control.data =3D damon_stat_context;

If damon_call() fails right after this and returns an error,
damon_stat_start() will pass that error back to its caller and the module
will revert to a disabled state.

Does this leave a stale kdamond_pid exposed to userspace? The newly added
documentation states: "If DAMON_STAT is enabled, this becomes the PID of
the worker thread. Else, -1." Since the initialization fails, the module
remains disabled, but kdamond_pid isn't reset to -1 on this error path.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260416002149.8709=
0-1-sj@kernel.org?part=3D1
