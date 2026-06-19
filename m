Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5D42E6CB8
	for <damon@lists.linux.dev>; Fri, 19 Jun 2026 23:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781913102; cv=none; b=uDZ84+Ln5pZjnEzepiY8SemRRmKsrJ8iiFdhvQpBQ0k6UUXdZ98JvSq2cuhr285iSfgbaihhDn4TT0d3zvH897Vs8SEb/5DUW192ANJ/y9pterrBGQsQ7oQ1k8SBLumzkTc/bGMipUGx9a0Un9HwlzUXijTPG8EoripumDJiaKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781913102; c=relaxed/simple;
	bh=yy4LNeiP04te3AQGGEa8iNFkaooyJDGpdExXYrprgfM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t0cksuCR987qxIqVbM/BEYIOkd+I1n3h0TdAGEd+QOCJIQFkdgZApg8xL1IlWxE0cer5FuNyNEzHhBTFhqB+vE2WyVdaTAdiS3lMaoQ03Su+igmLCM/URJ2EfRe6rm03I6yQWhnLyjQGka19iRvYV3kJzwkRZjDIlZkzN6jZl98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGWbv+Ja; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGWbv+Ja"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DDEC1F000E9;
	Fri, 19 Jun 2026 23:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781913100;
	bh=FErcFFiYTRHHWPh0eQ9V15N+vLgGoyNTqU+vzjiM+6M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nGWbv+JaoENIXDD7nVPcAc075pBRdf4g/rVp6zpCTyK+kDLKb9AfcjxPF8OuEQG9g
	 ziLQJQYWhTqNRq9F7kDvVtagWoyNyXRHWQ3z9M9wTM5lJ6hCQXQz5lLbWrkKlrJQeP
	 0SC3s41LBimrcnUpJFXMlPB+KPrGqNS/M3toLNAaeBvTr8ZBNV+JXf+uZPa5ZCf8aI
	 0vPpdS8e45+NcKiijTodZVHgWYUPXP/+tYvX+ypb6GYw/JOvkh7laERnpUaV68iEpj
	 PWlXWJB1B4EGWRtsWbETzxtNZk4wr21nghWmG9VAWVnsM5Cj74PxLy/d/6o8SJjJNO
	 XBTEukk1MizYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] mm/damon/reclaim: fix destruction of ctx
Reply-To: sashiko-reviews@lists.linux.dev
To: yahia <yahia.a.abdrabou@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260619234606.221163-2-yahia.a.abdrabou@gmail.com>
References: <20260619234606.221163-1-yahia.a.abdrabou@gmail.com>
 <20260619234606.221163-2-yahia.a.abdrabou@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 23:51:40 +0000
Message-Id: <20260619235140.9DDEC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch introduces a memory leak of the temporary DAMON context =
(param_ctx) and its associated structures on the success path of parameter =
application.
--

commit 57dd2b9f42514d0ee1c739cb34a24c15b5d98865
Author: yahia ahmed <yahia.a.abdrabou@gmail.com>

mm/damon/reclaim: fix destruction of ctx

This commit attempts to fix what is perceived as an early destruction of
the DAMON context by returning directly on success.

> diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> index ce4499cf4b8b0..15bc06ae75053 100644
> --- a/mm/damon/reclaim.c
> +++ b/mm/damon/reclaim.c
> @@ -268,6 +268,9 @@ static int damon_reclaim_apply_parameters(void)
>  	if (err)
>  		goto out;
>  	err =3D damon_commit_ctx(ctx, param_ctx);
> +
> +	if (!err)
> +		return 0;

[Severity: High]
Does this early return cause a memory leak of the temporary context?

In damon_reclaim_apply_parameters(), param_ctx is allocated as a temporary
context to construct new targets, schemes, quotas, and filters. The call
to damon_commit_ctx() duplicates these structures into the global context
rather than taking ownership of the pointers.

Because param_ctx is temporary and its contents are copied, it needs to be
destroyed unconditionally. Skipping damon_destroy_ctx(param_ctx) on the
success path leaves the temporary param_ctx and all its attached structures
leaked on every successful parameter application.

>  out:
>  	damon_destroy_ctx(param_ctx);
>  	return err;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619234606.2211=
63-1-yahia.a.abdrabou@gmail.com?part=3D1
