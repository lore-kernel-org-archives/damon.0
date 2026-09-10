Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F1E78F2B
	for <damon@lists.linux.dev>; Thu, 10 Sep 2026 04:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789013640; cv=none; b=P+YtGIvNgiNnMoOZ6E2dYRYFxChzP2rdwsI1sc15HBe17qF2ux3DeTBDnC3qPvgx1o3XwQhUY4VlFkQwy0JlGywhanWt48gtipmA9NYvKWI2vakD9tqkO+p49Jy2GqxPRYJLbE8RjRm4XO+ujIgMVyJgn5h2SuknM3jN+VYjdjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789013640; c=relaxed/simple;
	bh=P1FXNuwoW8aTtUGP1G9uPA/VloIPMFKVxhiKN5m/Ias=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fA/mJrUZ3EjJJdyZMuRN2mDSaPFjT2OM4rbmzIyKKC4Z6EvLqE7BH+p8WJjZCxN3q77RdvpsbUxdYrcIuUyefEpnTM6ydoZUNowTH4EsZ/CCuXCl+cC0tzODGgSHVoTCnUpwqCeRgI+9Cm0WOkOM+2bXKbl9RnWQEG2T9MBa/nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3MlIUC4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3MlIUC4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB181F000FF;
	Thu, 10 Sep 2026 04:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789013638;
	bh=eORkeVLxm02TKjMdgP3+9JnnCjqODTeUZeEBI66fgNI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h3MlIUC4HhznnXj92aK5l0S7ZMJOSUKoR8dF0YP0285iqTC2Q+3piKUHexc5PnuTA
	 Pl2TGAf8go63W8hTgjY5M3BtRzY4suHNwE5aflmVw4+DD6gq7dHWsMQaFUysNhw4Yp
	 Pji5dK4RTxsc95jD927lZjqnX5XlCIl6Lz6ACvngKYbvhpmKBHubJveFLY8hhz3l56
	 U2KbORLBc0NtTT+8pMBFqF0Ss5032YrjxKQH5cSl9j5fciDQO3BDJgXxs833f60QH6
	 6MOktX7oW3aPymxo9xcRA9B1CzMXxk0hARyIOHJzm3AeB2g3IT0Jcesc54wKfGbdWA
	 HzI1chUjVjM4A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2.1 1/7] mm/damon/api: introduce
 DAMOS_FILTER_TYPE_PROBE_HITS_WSUM
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260910040319.147037-2-sj@kernel.org>
References: <20260910040319.147037-1-sj@kernel.org>
 <20260910040319.147037-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 04:13:58 +0000
Message-Id: <20260910041358.8DB181F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The kernel-doc comment for `enum damos_filter_type` inaccurately de=
scribes `DAMOS_FILTER_TYPE_PROBE_HITS_WSUM` as an operations-handled filter=
 instead of a core-handled filter.
--

commit 03957fb4685434f4e403efc7bb804cb84f796dbd
Author: SJ Park <sj@kernel.org>

mm/damon/api: introduce DAMOS_FILTER_TYPE_PROBE_HITS_WSUM

This commit updates the DAMON kernel API by introducing the new DAMOS core
filter type, PROBE_HITS_WSUM. It allows API callers to filter target regions
based on their probe hits weighted sum by adding range fields to the
damos_filter structure.

> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 871d26adf6ae5..1deda16bb70b5 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -399,6 +399,7 @@ struct damos_stat {
>   * @DAMOS_FILTER_TYPE_UNMAPPED:	Unmapped pages.
>   * @DAMOS_FILTER_TYPE_ADDR:	Address range.
>   * @DAMOS_FILTER_TYPE_TARGET:	Data Access Monitoring target.
> + * @DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:	probe_hits weighted sum range.
>   * @NR_DAMOS_FILTER_TYPES:	Number of filter types.
>   *
>   * All types except &DAMOS_FILTER_TYPE_ADDR and &DAMOS_FILTER_TYPE_TARGET
>   * are handled by the underlying &struct damon_operations as a part of s=
cheme
>   * action trying

[Severity: Low]
Should &DAMOS_FILTER_TYPE_PROBE_HITS_WSUM be added to this exception list?

Since PROBE_HITS_WSUM is implemented as a core-handled filter rather than an
operations-handled filter, this kernel-doc comment for enum damos_filter_ty=
pe
might need an update. Otherwise, the documentation inaccurately describes it
as handled by operations, creating a mismatch with the actual core logic
implementation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910040319.1470=
37-1-sj@kernel.org?part=3D1
