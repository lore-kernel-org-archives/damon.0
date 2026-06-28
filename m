Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE18340414
	for <damon@lists.linux.dev>; Sun, 28 Jun 2026 22:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782686135; cv=none; b=cKQPmt2LyFpxtbUtRY4dDsov6+NgOWILvqmsPbg9SZm+HESlhKadEVsaQEnEfJ5Bx6mYv5NKjAf123Eq4fhuCRq+7N+e4Gn/wP8eiFos3+9RJ1xvgMQ9BpZD8Omlc0zuHfcJwWNU9T7b51Xw0wewnrduvKVW0VWCJgZIJGd9brs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782686135; c=relaxed/simple;
	bh=11XdTWRu8jDunLLcslYb3gxaZ31M2YvvznAn9Nij/QU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R/gSvyc6dCQllhUwkv5YGC0C2eB0qYtHVUJJ5LYNnSNblPzUOM5lNrYoaEd7Kut6mrFA2S40CdI9HzW2sRYyM1x7r0EbX4Cn5G/IK4S+K84i9SNRNOQaX9JRh37BorKXmnxP/JH4D8q19Ui7HjOpBavx9O9ydNPdgNDzf2ayP7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUlkkp9f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUlkkp9f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB07C1F000E9;
	Sun, 28 Jun 2026 22:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782686133;
	bh=QxuOvWUJqq1CiMByLPj+OOMpL8UG+LjW8NVuMLdtIkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iUlkkp9fgUFu5jzeQ4ilnwGvLISMOi7QAv4njYwoiO52YxBVYVu9ZI3Nm5wQBILKo
	 famNiRDB9aVVEf3nKX/cg8TCaumjIymtcIQtKkDewgH0o6H1fcovtKgWVG5CG9yfYR
	 bcELXnT8GVRnkFiEyyHL8dtOuwAV3V8Q1Hyr5hm3iuucSwPN0tJbS5MgQ8hhQoDp4m
	 LPUDtX1cqLDLj1OUk/Co9PGgyu4bygj5fnJRqFb26NDnQVatrc5rMnEy7DroaZbjRQ
	 zNKmTc+GzroKaivRko/aBZuJwSvdMGEkQRRLZLVb2mBDTp/2xF7Z9Smwq8pGBeJTY4
	 vfEuGdNlYEbNA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 4/6] samples/damon/mtier: handle damon_stop() failure
Date: Sun, 28 Jun 2026 15:35:21 -0700
Message-ID: <20260628223522.100030-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260628220957.5C1971F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 28 Jun 2026 22:09:56 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Concurrent execution of module initialization and sysfs parameter write leads to Use-After-Free and NULL pointer dereferences.
> --
> 
> commit f7efff971c5dc6b095a484211734bb0e2a54f858
> Author: SJ Park <sj@kernel.org>
> 
> samples/damon/mtier: handle damon_stop() failure
>     
> damon_sample_mtier_stop() assumes its damon_stop() call will always
> successfully stops the two DAMON contexts. Hence it deallocates the two
> DAMON contexts after the damon_stop() call.
> 
> Link: https://lore.kernel.org/20260609014219.3013-1-sj@kernel.org
> 
> > diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
> > --- a/samples/damon/mtier.c
> > +++ b/samples/damon/mtier.c
> > @@ -199,7 +199,8 @@ static int damon_sample_mtier_start(void)
> >  
> >  static void damon_sample_mtier_stop(void)
> >  {
> > -	damon_stop(ctxs, 2);
> > +	damon_stop(ctxs, 1);
> > +	damon_stop(&ctxs[1], 1);
> >  	damon_destroy_ctx(ctxs[0]);
> 
> [Severity: High]
> This is a pre-existing issue, but does this function have a concurrency race
> with sysfs parameter writes during module initialization?
> 
> Sysfs parameter nodes are exposed before module_init executes. If a user
> concurrently writes to the enabled sysfs parameter,
> damon_sample_mtier_enable_store() can call damon_sample_mtier_stop() while
> the module is still initializing:
> 
> samples/damon/mtier.c:damon_sample_mtier_init() {
>         ...
>         err = damon_sample_mtier_start();
>         ...
> }
> 
> If damon_sample_mtier_stop() runs before ctxs is initialized, couldn't this
> lead to a NULL pointer dereference when we reach damon_destroy_ctx(ctxs[0])?
> 
> Alternatively, if it runs concurrently with damon_sample_mtier_start(),
> could this cause a use-after-free since the module init function doesn't
> seem to hold a lock to serialize with the sysfs store callback?

Wrong.  mtier is static module.  Cannot be loaded on runtime.  So I'm ignoring
this.


Thanks,
SJ

[...]
