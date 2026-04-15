Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FA92CCB9
	for <damon@lists.linux.dev>; Wed, 15 Apr 2026 00:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776212175; cv=none; b=UzMD7lovoVknRTnqJnpIu5s13paJsMywMIG3yK/9WcTlOAW5Nu6l7ksh+Dz5bYPzxueqUs3s0yUIb4w/fyIlHWQrP7WGHuHU+MPoatKy2T4sWjDX+0k0CIElYupX159OHsL/9pE2YUtEpNX0yt2WA/aFS6s3BXybwOU/KN7k4og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776212175; c=relaxed/simple;
	bh=0sHc7RYWJrrmY5t/DjEw3CnTSPEvIDyH1lvhll65r0A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Tw2WHQoB7G/F2vithUowqzvv5wlUmrR4scO+nnQb6E6G/I82TvS4fICGttpb4PiQVl2t2aRJSGAwbp27+yx5q9sghnO46atgYhnK3ynhuSyq69UuhxPNYu7CS6h9TYC3hSK36hKdvuDy51ywQpQDKndvNpkI7iEM1iDhsz31D/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JlCPrGqI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JlCPrGqI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C571C19425;
	Wed, 15 Apr 2026 00:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776212174;
	bh=0sHc7RYWJrrmY5t/DjEw3CnTSPEvIDyH1lvhll65r0A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=JlCPrGqIyK1OS/pL39gFfRRmA4cfZUDgYUrCLZ7VJqtHTTGe+CpWfPYoX0oEP4IZ4
	 XkhUtWzD98UK8LkM1ypRLhMSpHgNe+5elfxvZuAEa7XwN3V3NAwj60/G7/7/yUW5V6
	 is4OvZO3oHt/H9rXJVdXqoMDifihCn0Gn+RCwzXeT08/lG7I/g/AZ+nbLVYcnZRygB
	 +JxTb2pBEHfKz8EeO0qYsA4xlfR0vOvYxL1m+3DreY8Qjvb0Tth8zTRIQYObyx08Qh
	 nBy62J3NZSWJMpz94h1L5lweqGaietwR/kXxeVzDDlrIUMGLP9K0dGBmr89vPEqOXh
	 Zpu6+B1lkjajw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 1/2] mm/damon/stat: add a parameter for reading
 kdamond pid
Reply-To: sashiko@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260414235912.98174-2-sj@kernel.org>
References: <20260414235912.98174-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Apr 2026 00:16:14 +0000
Message-Id: <20260415001614.9C571C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Sashiko AI review found 1 potential issue(s):
- [Low] Missing closing brace `}` in `damon_stat_start()` error path causes=
 compilation failure.
--

commit 04b7136ae6b7cd907673996f57f0a613de1984b9
Author: SeongJae Park <sj@kernel.org>

mm/damon/stat: add a parameter for reading kdamond pid

This commit exposes the pid of the DAMON_STAT kdamond via a new read-only
module parameter named kdamond_pid to help user-space management and
monitoring.

> diff --git a/mm/damon/stat.c b/mm/damon/stat.c
> --- a/mm/damon/stat.c
> +++ b/mm/damon/stat.c

[ ... ]

> @@ -260,6 +269,13 @@ static int damon_stat_start(void)
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

Is there a missing closing brace for the if (kdamond_pid < 0) block here?
It looks like the omission will swallow the rest of the function into the
error path and cause a compilation failure.

> =20
>  	damon_stat_last_refresh_jiffies =3D jiffies;
>  	call_control.data =3D damon_stat_context;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260414235912.9817=
4-1-sj@kernel.org?part=3D1
