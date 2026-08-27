Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B64547CC8D
	for <damon@lists.linux.dev>; Thu, 27 Aug 2026 16:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787849305; cv=none; b=RvsXwOXOIm8X17RwZOn5furq++N1R1PGABTip0OTXhucPEFPmtH9KciAsBDKW5yHd4oemY7P/9uLsZexRUjTddSs20h9qfcBOKVZ1sTyj0/3EtBAZeNKXkLCILYlh+YHkKSqD8zweAO/7HjAylpwOOsEif9txh6iYJ7F4Y3D6JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787849305; c=relaxed/simple;
	bh=G+SKiIHEsEQ47vClZBuSMv2h6AONXbGbc4/NH1TWOgc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IPWQTCwwKjdfcbkIY2FaX8Q86DJef5/81DrDfBhiVLqNgWnXnTgNPxwUm6I4Um5aymm8JshaKQigNedw/V5ghwWf3yEke9wIKetcNSXOtFKHe/6wy8Bly0xTpdV6zyriiz10LaOYEbDLAKQvcKK231fCngVvUwxkp8hiNOVkl6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCc6HjVf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCc6HjVf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80F21F00A3A;
	Thu, 27 Aug 2026 16:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787849303;
	bh=qzDV8YvRGIzw5cuiDpZwqb2qv/TbTlU324FZVwsCauc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KCc6HjVfGGaBzE+snj8Or4+W/1I1E0ZyIjNzhGd8tXS4mzfkNLJymFchJGRMT4xfd
	 eyqt/+IXy2CTOg+b6IRBQ8ARySGZfBb7mBkTrwSwfP3iA1VjarnVUbR9wccwqNEbmX
	 3P+2tm1pmtubGgWQtWSiIAVZhV3JIhrYsqpQQ2bXKtuNO3Z3Nw4SmPPLaPGxJRr4/M
	 pwKEDeSO0T/q5SPdNmu84dK5HVauT5LJnXa5jAqOLk4fMdZnkWhf5K/pUwYJf9qMK7
	 pq0EumZIt10VQmSxKKobdNz1QKIdbT9Dc53GoO29PwohXssh5UO5pB52d9uublmJUt
	 9+ltWGi1h6oCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon/core: remove declaration of kdamond_fn()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zenghui Yu" <zenghui.yu@linux.dev>
Cc: damon@lists.linux.dev
In-Reply-To: <20260827163953.83520-1-zenghui.yu@linux.dev>
References: <20260827163953.83520-1-zenghui.yu@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 16:48:22 +0000
Message-Id: <20260827164822.D80F21F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Removing the forward declaration of `kdamond_fn` causes a build fai=
lure because it is referenced in `__damon_start` before its definition.
--

commit 38eba93e0517bb327a80a5c61f1f8b5a41ec274d
Author: Zenghui Yu (Huawei) <zenghui.yu@linux.dev>

mm/damon/core: remove declaration of kdamond_fn()

It was added by commit 2224d8485492 ("mm: introduce Data Access MONitor
(DAMON)") but is actually not needed.  Remove it.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 644daf5a16560..67d93b57a8947 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1922,8 +1922,6 @@ static unsigned long damon_apply_min_nr_regions(str=
uct damon_ctx *ctx)
>  	return max_region_sz;
>  }
> =20
> -static int kdamond_fn(void *data);
> -

[Severity: Low]
Does removing this forward declaration cause a build failure?

It looks like kdamond_fn is referenced shortly after in __damon_start(), but
its actual definition doesn't occur until much later in the file:

mm/damon/core.c:__damon_start() {
        ...
		ctx->kdamond =3D kthread_run(kdamond_fn, ctx, "kdamond.%d",
				nr_running_ctxs);
        ...
}

Will the compiler fail when compiling mm/damon/core.c because kdamond_fn is
used before it is defined?

>  /*
>   * __damon_start() - Starts monitoring with given context.
>   * @ctx:	monitoring context

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827163953.8352=
0-1-zenghui.yu@linux.dev?part=3D1
