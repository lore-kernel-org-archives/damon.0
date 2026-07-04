Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1887298CA3
	for <damon@lists.linux.dev>; Sat,  4 Jul 2026 18:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783189251; cv=none; b=ImGJeEsTDg7Ohfyq5TZ8JJJy6LS5FE7KN78JvTu95h0WLgCltfhkLz8Y4lYHtBVudy06yBPgymgwHnoBd+SFrEvcZkZUI1fq0rxRmK9vNvYIOoQQFUn5ZUV4D7zG3sT0IwTiaQGkQJaW7wWnfuwgIv45v+RPWHu/ru41h+fD/6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783189251; c=relaxed/simple;
	bh=okHtYezab5qI7urtsv+KLYYi2yjWq3n8Ltqg/dwbw0w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QKrgs2ORnCCyq3OoSRqcYXX5wEkVfsVILAAV1SZBQcuGsTJT30A79y2MqZi45PK+xLGoQ3T/uook224VQHlihQWpMed0soKLJJkkvJ5LA8jwnUEfM7fGz3vepEUcIhvC2qS60nAeRI4o3537luJbt255QOkyWOKMNLAdqHcyjCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojxdxiOX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojxdxiOX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C01A1F000E9;
	Sat,  4 Jul 2026 18:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783189250;
	bh=1JuJyL0zpK78Bw38+R/TL8OPqWziW0nlEN4mXVfBSbw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ojxdxiOXNKsGges2DJL8y3V8k5/otYUZ2V9/pyDvBYybFrLTmET93s2T2TxkWWYDL
	 5qAjvnYUHRgfmMOz1V8p9FLqQSXuvwtIQGkAsc31s476EwWlAYtxw9g+EIT5BhUZsq
	 PkgdlJHOh6croxw1W4D2fPCtY8zaDcH8ezx0ZiamTswE+tSOKBBwGmJ4Chh+qPl46M
	 lNciYVd3vPlZxDSDuV+0dwAkKro1G6PKdrWPl6+hGEGQel8HNq9brrJFeWdRwMnXhy
	 EQI8eP3VjEnc4k6HkEVNgPneenCVxaf6dC8T58sNKFd2Et6qdqJ01+adcx5KEw+g+I
	 aH9Qsw2DPt36A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 01/11] mm/damon/core: stop ctxs in damon_start()
 before returning an error
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260704181135.132956-2-sj@kernel.org>
References: <20260704181135.132956-1-sj@kernel.org>
 <20260704181135.132956-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Jul 2026 18:20:49 +0000
Message-Id: <20260704182050.5C01A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Calling damon_stop() from within damon_start() while holding damon=
_lock causes an AB-BA deadlock with kdamond_fn().
--

commit 1cec89c3cfde2c1ab34bcccb4767280aac126514
Author: SJ Park <sj@kernel.org>

mm/damon/core: stop ctxs in damon_start() before returning an error

When multiple contexts are passed to damon_start(), it starts them one
by one and returns an error immediately on failure. This commit adds logic
to stop any already-started contexts directly within damon_start() if a
subsequent context fails to start.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index c6fc35be633b3..45aa9acef4e30 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1836,8 +1836,10 @@ int damon_start(struct damon_ctx **ctxs, int nr_ct=
xs, bool exclusive)
> =20
>  	for (i =3D 0; i < nr_ctxs; i++) {
>  		err =3D __damon_start(ctxs[i]);
> -		if (err)
> +		if (err) {
> +			damon_stop(ctxs, i);

[Severity: High]
Will this cause a deadlock if a context fails to start?

damon_start() holds damon_lock while iterating through the contexts. When it
encounters an error, it calls damon_stop() which synchronously waits for the
previously started kthreads to stop.

However, the kdamond_fn thread attempts to acquire the same damon_lock
during its cleanup phase before it can exit:

kdamond_fn() {
        ...
        mutex_lock(&damon_lock);
        nr_running_ctxs--;
        ...
        mutex_unlock(&damon_lock);
}

Since damon_start() is blocking on the thread exit while holding damon_lock,
and the thread is blocking on damon_lock to exit, doesn't this result in a
circular wait?

>  			break;
> +		}
>  		nr_running_ctxs++;
>  	}
>  	if (exclusive && nr_running_ctxs)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260704181135.1329=
56-1-sj@kernel.org?part=3D1
