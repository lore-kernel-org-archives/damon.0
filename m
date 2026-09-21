Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6621A9B24
	for <damon@lists.linux.dev>; Mon, 21 Sep 2026 00:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789951129; cv=none; b=DuumG777cjUwiNf7ZKKwrDRYipp0fcm3ULUzmCgpAgeE8zh3HPHTW6GrXQZsgGfovQK97N3/EV3bCw0k9C22ulXog8mtuB5oX+Y6/AKEueBgqGemSJERSoK7bUCbL+sjStjswLcOjRfSNZ643lVOef3d8RMB1BQdSEIB0eGrejY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789951129; c=relaxed/simple;
	bh=Z8WFVqtKJGSqVLk+27KbeEsRtxEUhq3s1j7LSOt8IV0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AMT8ZQHz/P40Tjv47NtjmZw2znRS5sJnHeIg5EkGNRszn1AZC+x7W4yh3NET5sisFO+rMPKyKIH6wUz6F0Nc8GLPVwNCU+YfLiVP5KXs8c+A8fi5dhGli1TV26+4XJO/aSvIMZHMPBKoGInQx8Fh/5Q/eGQkoo3w22yRTnfWUgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSvgnOFc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSvgnOFc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3319B1F000FF;
	Mon, 21 Sep 2026 00:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789951128;
	bh=Z8WFVqtKJGSqVLk+27KbeEsRtxEUhq3s1j7LSOt8IV0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CSvgnOFch5wyuJTSS8nhca+yBkYe5q3YPfz/KwbzVRljL3hjGO/buOjH+HeNP7WQ8
	 VsNoDs7e2MzeX+/jqJJKbEhyKsFAG5UkiHw2h0MrQPWzKrKXOb107GEYVc4WcNwcPu
	 /7TYUfERu9VGs5KzmRSpJbh/ebbdCcWvZhhbqkeH3fiWuA3NlYdSvLVveM0F8i4rll
	 QYQWpPVTPc3eNhkDiolABEU0ltvjG1o+MTwsOh2KD9ba+ANr0dNUcOUC1WE/eZa0/C
	 qrXK0RGe3v3pPMjfWIEX4Es3wgdQO/wyWQNfeKOLXw4mxwqaDLd30eZbLnj+b868U2
	 Ln0ieRVDmjpyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] mm/damon/core: preserve the caller's quota in
 damon_new_scheme()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260921003047.12041-2-kmehltretter@gmail.com>
References: <20260921003047.12041-1-kmehltretter@gmail.com>
 <20260921003047.12041-2-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 00:38:47 +0000
Message-Id: <20260921003848.3319B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damon_new_scheme() calls damos_quota_init() on the caller's quota before
> copying it to the new scheme. This clears the caller's effective quota,
> feedback input and charging state as a side effect.
>=20
> damon_commit_ctx() first copies the running context into a temporary
> context for validating the proposed parameters. When
> damon_commit_schemes() creates the temporary schemes, it passes the quota
> of each running scheme to damon_new_scheme(). The quota pointer therefore
> refers to the running scheme, and damos_quota_init() clears that scheme's
> state before it is copied to the temporary scheme. Even an update
> rejected with -EINVAL loses the running quota state.
>=20
> For a size quota, this discards the bytes already charged and allows the
> scheme to use a fresh quota before the reset interval has elapsed. For a
> goal-driven quota, the consist tuner loses its accumulated input and
> [ ... ]
> Fixes: 70e0c1d1bf94 ("mm/damon/core: factor out 'damos_quota' private fil=
eds initialization")
> Cc: <stable@vger.kernel.org> # 6.19.x
> Link: https://lore.kernel.org/damon/20260702212143.0CB6D1F00A3D@smtp.kern=
el.org/ [1]
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921003047.1204=
1-1-kmehltretter@gmail.com?part=3D1

