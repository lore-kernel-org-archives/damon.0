Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDCD19C566
	for <damon@lists.linux.dev>; Wed, 10 Jun 2026 01:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781054954; cv=none; b=HU9FsQ1qk+DFzVhDFq/76N1e41ozqr7ALDJqF11X57ctj9oJapdws7/kw9z/NR7JsE2B6yQZxftM5bJxsspUvwplPKXdNzXg8hOzm1dEAkv4rjTVaBdfc61KeCRSw5HbueU/vbHO4cva8PoqDZEjhTJdqgrfloFhJHEGUJ6OA+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781054954; c=relaxed/simple;
	bh=jZ0iQIRv/1b1oPTnLtK4kQBoD8YGv/snc5RUSiY7JJw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TzobFkGuRDGWz5kIbrjO/JWxJKo6mHKzka2eU1QKgYCP1fBnY+04pWqlNpDghfLokVjTzPAG5Js18h4wsWfg8/T4QClLz61Bpu1ai643t8bRCf9eZHDn3CmMLJU8YTYXon8zN5XdhWINWXTmpWZ46PuQFchyVg4jDqHHvSkstYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZnJbNeD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZnJbNeD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E801F00893;
	Wed, 10 Jun 2026 01:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781054952;
	bh=AHeNRpuYDWxB5iqTgjB68qOhJX6o4s8UPnEX7urjj/8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dZnJbNeDAKc8dqkrz9I7RBR0NBg405VWzwY7hpMgxB2g3DPiqVfnFncD8YFLxXPh7
	 HuwnAxcwpQxSi7oMbqt62Tecibm5qaiuOEyzKWzxs0kjmLwZ1AxUvKdw4OlzBU7MlS
	 N7/YpS8PhWQZOO6o+DWpwo0ZvFHHQ9+hnZnoXYQhIGw3LImNvKFOIICOAtZckGLf7i
	 Lp73+DBpNh1pqZVM2wPjVb8827UvzBQs+BBQYoARUeqT9eq+3zd+ifXwLdj9nxKaFK
	 XTjvj1p9xqeceZqoSLCZyeo5qJQhosdLLkB40T23RMtCeNZVZepnWJwmCr6prTfpAf
	 1qPrJIcYPPc/A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 1/4] samples/damon/wsse: handle damon_start()
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260610011420.3018-2-sj@kernel.org>
References: <20260610011420.3018-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 01:29:12 +0000
Message-Id: <20260610012912.C3E801F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unhandled failure of `damon_call()` leads to a permanent memory le=
ak of the DAMON context.
- [High] Concurrent execution of `module_init` and sysfs store causes Use-A=
fter-Free and Double Free on the global `ctx`.
--

commit 6215f97f729272927aafd065cdad15da2af100a8
Author: SeongJae Park <sj@kernel.org>

samples/damon/wsse: handle damon_start() failure

This commit fixes a memory leak in damon_sample_wsse_start() by explicitly
freeing the DAMON context if damon_start() fails.

Link: https://lore.kernel.org/20260609145814.70163-1-sj@kernel.org

> diff --git a/samples/damon/wsse.c b/samples/damon/wsse.c
> index 799ad44439434..bbd9392ab5b36 100644
> --- a/samples/damon/wsse.c
> +++ b/samples/damon/wsse.c
> @@ -87,8 +87,10 @@ static int damon_sample_wsse_start(void)
>  	target->pid =3D target_pidp;
> =20
>  	err =3D damon_start(&ctx, 1, true);
> -	if (err)
> +	if (err) {
> +		damon_destroy_ctx(ctx);
>  		return err;
> +	}

[Severity: High]
This is a pre-existing issue, but does this new error path leave the global
ctx pointer dangling?

If the module is loaded with enabled=3D1, damon_sample_wsse_init() calls
damon_sample_wsse_start(). Concurrently, user space can write 0 to the
enabled sysfs parameter, which triggers damon_sample_wsse_stop().

If damon_start() encounters an error, this new path calls
damon_destroy_ctx(ctx) but ctx is not set to NULL. A concurrent
damon_sample_wsse_stop() would see ctx !=3D NULL and call
damon_destroy_ctx(ctx) again, leading to a double free.

Similarly, if damon_sample_wsse_stop() executes while
damon_sample_wsse_start() is running, stop() could call
damon_destroy_ctx(ctx) while start() is actively using it, causing a
use-after-free.

>  	repeat_call_control.data =3D ctx;
>  	return damon_call(ctx, &repeat_call_control);
>  }

[Severity: High]
This is a pre-existing issue, but does this return path leak the newly
created ctx if damon_call() fails?

If damon_call() returns an error (for example, -ECANCELED if the kdamond
thread exits immediately and sets ctx->call_controls_obsolete to true), the
error is returned directly to the caller.

Because the kdamond thread does not free the context itself when exiting,
is damon_destroy_ctx(ctx) also needed here to prevent leaking the DAMON
context and its associated objects?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610011420.3018=
-1-sj@kernel.org?part=3D1
