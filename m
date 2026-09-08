Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BD554B1C4
	for <damon@lists.linux.dev>; Tue,  8 Sep 2026 17:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788890149; cv=none; b=aj7ieXpxF6uaQLZvOxy0jzZhlCLmYgRc74X0hJveoeaKiD+1bBtsNRpyzvGHRWbZjGkRb2e8043QYnSH7BKIdfmzivX5xAVMIEyBVMiFRFHpSlwxpd51v0pJNvZ4EexYxy0aIYchFM1yBHKyEoPtXqQ5PSyscPHIOXG+OYSJKoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788890149; c=relaxed/simple;
	bh=d6+4F1w+SdRUevM8ZBJLppT2kjMs0NRm2QFAuGN/NWw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aUrmt9YAZ7mGIVHLRHUKoWru4gvd3fbgFMDcg9eKCOtBJD/ft8dcTL0ESzxg/7QasflafPmIcqE/t8+lkD4pTY/+WlUvYm9SZcEEKV1Ykb5s7cwuzFTRdC7WeGjZ+AkLDgy7BKeoJ/xnYKm+4tK1Kt3tTei3qAkIP2vY+LJK5uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyD3DDQn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyD3DDQn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D95F1F00ACA;
	Tue,  8 Sep 2026 17:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788890148;
	bh=z2BpIW//siD87aEffAvUdzHPHahLsy8/gb3g9AIjbhs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hyD3DDQnhvW4CfAjEuSB5WDhYPL5wTqxrYfMq4kwy5/xYQWV/UqksCLD1cgainudI
	 7GGazoad/W6hmUJQNxAHMSjUWgBwzAfXUmOaIg3MmOlVbroTvvkAm+0jzx5tigv2Lc
	 JoFGeKHWucVhUrQx9W01eB2fQnmV1DxxSfPh4lKcmKzy285JJa4J6cGh3nG+MVaL2a
	 asOlIPEpzLZvvWLMJ6fmvtiy+Z48NH/Us7AW0he37bQr/1yp0UEljAY8zKYh2xLlb6
	 JtDBBhVcscWfc1ou6MymIBmzsbE1DEpZ7yd/vyv/NIhdGxp0Dpk7kKrAgUG01TtfGC
	 /8nVqbk0WRR4Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] Docs/mm/damon/design: clarify when qt_exceeds
 increases
Reply-To: sashiko-reviews@lists.linux.dev
To: "Liew Rui Yan" <aethernet65535@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260908175105.42558-2-aethernet65535@gmail.com>
References: <20260908175105.42558-2-aethernet65535@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 17:55:47 +0000
Message-Id: <20260908175548.2D95F1F00ACA@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Grammar and punctuation errors in the newly added documentation par=
agraph.
--

commit 25ab17e2d03e88ea28912107d200a293e1a57614
Author: Liew Rui Yan <aethernet65535@gmail.com>

Docs/mm/damon/design: clarify when qt_exceeds increases

This commit updates the DAMON design documentation to clarify how
qt_exceeds behaves when quotas are unset versus when they have a zero
effective size quota due to the temporal auto-tuning algorithm.

> diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/d=
esign.rst
> index d036340dae8af..e083b74d618b5 100644
> --- a/Documentation/mm/damon/design.rst
> +++ b/Documentation/mm/damon/design.rst
> @@ -863,6 +863,16 @@ scheme's execution.
>    completely tried to be applied.
>  - ``max_nr_snapshots``: Upper limit of ``nr_snapshots``.
> =20
> +``qt_exceeds`` is increased for schemes with set quotas when the quota i=
s found
> +full at a quota reset interval boundary.  While the quotas are unset,
> +``qt_exceeds`` never increased.  However, a zero effective size quota do=
es not
> +always mean the quotas are unset, if the ``temporal`` :ref:`auto-tuning

[Severity: Low]
This isn't a bug, but would it be clearer to use the present tense=20
("never increases" or "is never increased") instead of "never increased"=20
to match the surrounding text?

Additionally, would it be better to separate the comma splice before=20
"if the ``temporal``" into two sentences?

> +algorithm <damon_design_damos_quotas_auto_tuning>` is used, the effectiv=
e size
> +quota is set to zero once the goal is [over-]achieved.  Since a set quot=
a of
> +zero effective size is always considered full, ``qt_exceeds`` keeps being
> +increased once per quota reset interval in that case, until the goal is
> +under-achieved again.
> +
>  "A scheme is tried to be applied to a region" means DAMOS core logic det=
ermined

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908175105.4255=
8-2-aethernet65535@gmail.com?part=3D1
