Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DFF3438AD
	for <damon@lists.linux.dev>; Tue,  9 Jun 2026 14:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015741; cv=none; b=phl7wjALHCMnWSM2wyDH0VJmJp+sbi0celvKQ6szlId23+x+lue35dnmUscWAemU7zZzV9s6BwW1U1ynb83Bhzb02tNxaacp4I2/dBNafdio6zCObpzkuBaVgNqyL+0D8qzHLwhV6kiczjoksqMLhXmt3LM1kIVxIg/uNMrzy2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015741; c=relaxed/simple;
	bh=Er3g0apZZiyM7/uWVzg8oljgiO+wKs2N5y+/VDILtjc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZUYDYcsiCFfUHJJxBPedyfU9Z6hPAQQ2rRsUOCkzzK/sJzKDwLlYMLK4J3Eo4igEA4uDtpAHrCzZe4gj/UXhe83OHdsWmyzbvzaJXCIPdSMa64fn+02NbKXjQVSqkb/xshnj4HZUBE+1qH3DhkBYTW8IMb01NRqHfrb+KQLRYJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3euNtSn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3euNtSn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E6BF1F00893;
	Tue,  9 Jun 2026 14:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781015739;
	bh=vYW6Dq2fEKpiSJgoO7INNt8rC9UFGpdwdNCvGzA3Ju0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P3euNtSnnus6EFD04G80ltEHxvYv0PW6WiK3VDUTmuiJ0ohtNMkJbdv0yLBNE9TV+
	 TqlruRd/GOtVwZ8hwXt7V6eRGSEw/Oqt49XqPB0sM/9oMifuLNh2f4/M9jW38LX0R9
	 bP2K/8Bt4zi7vduq+z0RXEp+oI3Vjfnpfv97b4lCudzBWOOAxJRqJdCCkLepj0weSq
	 jYBNjenUNo7XHc8pSv/i3ztHOYPKqtVcBId5H6QKfo0LLlJ84xP4oPI8Bz8g1yppz3
	 Figq0aR5gv+fk1/KOTtbnbwWS2wY72NA2vanKPd/6tpziHNPGOMuwc8NkAD92wcmu6
	 gJMsi/pk2lamg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 1/2] samples/damon/mtier: handle damon_start()
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260609142119.68120-2-sj@kernel.org>
References: <20260609142119.68120-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 14:35:38 +0000
Message-Id: <20260609143539.9E6BF1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Resource leak (struct damon_ctx, struct damos, struct damon_target=
, and struct pid) on damon_start() failure.
--

commit e95eb25cfbc21e60927df5e7e4eadcf5468c1c41
Author: SeongJae Park <sj@kernel.org>
samples/damon/mtier: handle damon_start() failure

This commit fixes a resource leak in the memory tiering DAMON sample module
where failing to start the DAMON contexts leads to memory leaks and
indefinitely running contexts.

Link: https://lore.kernel.org/20260608112455.274231F00893@smtp.kernel.org

> diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
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

[Severity: High]
This is a pre-existing issue, but it looks like the exact same resource leak
pattern exists in other DAMON sample modules when damon_start() fails.

Looking at damon_sample_prcl_start() in samples/damon/prcl.c:

	err =3D damon_start(&ctx, 1, true);
	if (err)
		return err;

And similarly in damon_sample_wsse_start() in samples/damon/wsse.c:

	err =3D damon_start(&ctx, 1, true);
	if (err)
		return err;

Since they return directly without calling damon_destroy_ctx() or putting
the target_pidp reference, do these modules also leak their newly allocated
contexts and PID references when damon_start() fails?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609142119.6812=
0-1-sj@kernel.org?part=3D1
