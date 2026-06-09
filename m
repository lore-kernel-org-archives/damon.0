Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D8D2FE05C
	for <damon@lists.linux.dev>; Tue,  9 Jun 2026 01:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780967177; cv=none; b=fi0wc7Qzm86IHTqOKiJKzTXWgtCkGZfBLFiLvl0hhqMSPoOKz9L28Icd5eqLYP2EGfEYTiP2KhqghgzQir6jhNm5Al7q5gqs+G3UWpQ6696jb4zTe3UCwpDrQsxAXTVjra79qRxl9sufSQomtie6taydnpk1KbllUTzYDlDSRQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780967177; c=relaxed/simple;
	bh=aIKY84JY4vNyzuhM32X7oVegkwhavaRr1LnZZPFo9ec=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aPhJVc+C41fFT0VbQm0FwN0JTwbCiqgznoJ7ip7wFNFAGBYtN7AZk9NA/9L+ZK36xyU7I7yXvETd2f3Z/klTvoIGyPxLWUaEPlyBNjfI3urgAGa4V+hv02R4Wi/VLeppUoQvwEl+9zkKiGIeJ9RmpBiAs1KzSzzPdKWgSryycJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovyaDoM1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovyaDoM1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328991F00898;
	Tue,  9 Jun 2026 01:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780967176;
	bh=J39+rGpkVn1gRmsg5vmYGt8/KQEyTsn0dkGJHStH7Q4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ovyaDoM1nbOcCHPsR9RYhSscULImk32EzkG8rYkR448AEFHDqFV6F4MObqKaLZNSO
	 8lk25QxIbkMGkmCie0QQmlZZsBUIC9yI9Btat1tGKQYdeO9eVdsUxgajYepdX/ngfl
	 uKoeCsiZtt4H7BDipefE+n0eDu8+kmyZknSuCsxmxCA1pPT/zlbxiT96QEjLKSequ9
	 gEQeftHdMjd/Tw4Z+dUWeHj8cBSxLk2zvq3HSrfGqThYfvMLip1w65P92lQVMPkiwO
	 8yKnZkkiRK9FUDGmE9b7J4uci1L/pwp47XJinKk3wIttFrGAqNL/KDOHNWz7tlvOrI
	 w1l3mBN4oJfqw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] samples/damon/mtier: handle damon_start() failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260609005443.2122-1-sj@kernel.org>
References: <20260609005443.2122-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 01:06:15 +0000
Message-Id: <20260609010616.328991F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `damon_stop()` aborts its loop on the first error, leaving subsequ=
ent contexts running and triggering a Use-After-Free when their memory is d=
estroyed.
--

commit 6da87efa9d6982132beff965026bf155183e5c93
Author: SeongJae Park <sj@kernel.org>

samples/damon/mtier: handle damon_start() failure

This commit adds cleanup for damon_start() failures in the memory tiering
DAMON module. When damon_start() fails, it stops any running contexts
and frees them to prevent memory leaks and exclusive mode locks.

Link: https://lore.kernel.org/20260608112455.274231F00893@smtp.kernel.org

> diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
> index eb1143de8df17..66b591f2180fa 100644
> --- a/samples/damon/mtier.c
> +++ b/samples/damon/mtier.c
[ ... ]
> @@ -185,7 +186,15 @@ static int damon_sample_mtier_start(void)
>  		return -ENOMEM;
>  	}
>  	ctxs[1] =3D ctx;
> -	return damon_start(ctxs, 2, true);
> +	err =3D damon_start(ctxs, 2, true);
> +	if (!err)
> +		return 0;
> +
> +	if (damon_is_running(ctxs[0]))
> +		damon_stop(ctxs, 1);
> +	damon_destroy_ctx(ctxs[0]);
> +	damon_destroy_ctx(ctxs[1]);
> +	return err;
>  }
> =20
>  static void damon_sample_mtier_stop(void)

[Severity: High]
This is a pre-existing issue, but does damon_stop() leave contexts running
and cause a use-after-free here?

Looking at damon_stop() in mm/damon/core.c:

int damon_stop(struct damon_ctx **ctxs, int nr_ctxs)
{
	int i, err =3D 0;

	for (i =3D 0; i < nr_ctxs; i++) {
		err =3D __damon_stop(ctxs[i]);
		if (err)
			break;
	}
	return err;
}

If __damon_stop() returns an error for the first context (for instance, if
the kthread exited prematurely due to an allocation failure), the loop
breaks immediately.

When damon_sample_mtier_stop() calls damon_stop(ctxs, 2), this would mean
ctxs[1] is never stopped if stopping ctxs[0] returns an error.

The subsequent unconditional calls to damon_destroy_ctx(ctxs[1]) in
damon_sample_mtier_stop() would then free the context, its targets, and its
schemes while kdamond is still executing and dereferencing them.

Can this lead to a use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609005443.2122=
-1-sj@kernel.org?part=3D1
