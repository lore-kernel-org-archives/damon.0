Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C8653D9D2
	for <damon@lists.linux.dev>; Thu, 15 Oct 2026 18:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792088902; cv=none; b=fO+Ea8TDaRvA1S9wjIqh/Q3JyRHJMr/l97jxb9u/isYwQqsI/ghOHhUBaIQrCqkIyfdVZM9jiPESfwXGWEfSayH18FsyLzKFvmoxeajGVr9EG4doaXJt4h8g1dNv7csBTh5b+oCPqTLd0qx/AopitDW7hUXAEbTqX0zT3ThfmF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792088902; c=relaxed/simple;
	bh=S8lAI+CIkQFMdoKVC54NvI55JILQ74oUXiJJg7pP2Mk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Kg+TleNe/b5lAM26F2C21Y5xmA7y3cORNaj/1gh2eVjLICG+kjK2u7O9mkLNmBflzsim/B0BSKBK3OBC00DnqTdsMGrb9FgzzUyQNCHsVOU0CYMlpshpxlmDOF2OP4kh2aCK3NuPGE6Szn8jBQLqtANCgSSVqcNnrmFAALA1y7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWB6rKE2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWB6rKE2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F121F000C5;
	Thu, 15 Oct 2026 18:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792088897;
	bh=a5iuzX/HKLBnnrZdMlVczfCQjXmvFKLngpCvhUN2Lx0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bWB6rKE2bgtrU+VpTaO30IwReRHvqR6gggeuiB0jAvdUCnK4HI7i2q0doy8QunqSk
	 voPPtsbOEh9cLohra1x4XYbS3kb4DPsdZsMCE1dD2mZ2LoNyeIDLmpyAYpIYGfKU0Y
	 bBTDYqsStqmREpS8gGtdZpYsCvOgR+tpXkukUeh0/b1U74JANQclA2S1Q6hiKL8fNO
	 TaVKFpI9dZj+PKUxHw6SC4bEz4mADNLnP2vzHStCFKDLL5wOgAHTHAicW/LM+n7W7/
	 kuSAfnv+dZDimUgImG+bTb//j2rWKnpMYAgvpSFHx4jPfel3HNAoJxEhckzcZi62zh
	 fIN9fkZJ8Qq/Q==
Message-ID: <sashiko-outbox-173293@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/17] mm/mglru: move add/del LRU size accounting out
 of lru_gen_update_size()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kairui Song" <kasong@tencent.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261016-mglru-fg-v4-6-2106750c0bfa@tencent.com>
References: <20261016-mglru-fg-v4-0-2106750c0bfa@tencent.com>
 <20261016-mglru-fg-v4-6-2106750c0bfa@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 18:28:17 +0000
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: Kairui Song <kasong@tencent.com>
>=20
> Pure code shuffle, no behavior change.  lru_gen_update_size() now only
> updates the per-generation counters plus the promotion move; the
> addition and deletion active/inactive accounting move to
> lru_gen_add_folio() and lru_gen_del_folio(), which know the generation
> and can apply the active-window test directly.
>=20
> The unevictable case is untouched: unevictable folios never enter
> lru_gen_add_folio() and keep being accounted by lruvec_add_folio() as
> before.
>=20
> Tested-by: zhaozhengzhuo <zhaozhengzhuo@uniontech.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-mglru-fg-v=
4-0-2106750c0bfa@tencent.com?part=3D6

