Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC20556BA0
	for <damon@lists.linux.dev>; Thu, 15 Oct 2026 18:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792088991; cv=none; b=gSw/9IxRPCEhGQCWfeMjcTwKRei3fbRfofEVf8CAF7GGmFSl/eruUjFfvTNwJP4e1Old1VE9hJ2+T340XPYcUj1A9S+pkPWTKPTw3moL44+SfMVrY3k7liWcYE62PJ4lHCMrEmm42nsz6LQSSKlvQ8/7TjgCBtgb7AtISpgjGUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792088991; c=relaxed/simple;
	bh=2ObEALi3Vg516e5GC1lBTOLQhfGK89FcxJP1Cts9bt4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=EFGY2XIVMv/YC5WDpj/N3dUHy/9dEZuk9uoSxvdiUjy72gEz21v9XMwi3Bb7O7Oa9fgIkNSouZzGBziZXo6SJyo1h9RPgKcO8Cb0KJSjTDc759dwz9rHuqq03zPewMJcKCTMJ5MeWz1myWxNrhfTbx/TT/5ipR0XYavc6URJfFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZBiVs/f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZBiVs/f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C838A1F000C4;
	Thu, 15 Oct 2026 18:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792088988;
	bh=2ObEALi3Vg516e5GC1lBTOLQhfGK89FcxJP1Cts9bt4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PZBiVs/fRsnTYhwT4KgHYMZCzowwMQDip3ISmWfjqEaFPkSpSH1nLu4sx7VwmQIKy
	 NXgRUHjCiqzIGhamRlEng/w3OF8n2qhxpAs+xn+QpIkeoAF3auA9t8myn1+cqtykQp
	 +OVMLQKxpuxlGht00xCPVFnybciiYYx74rHgu2ws9tTHvw83lRfSXrCpFN97Rm456e
	 3zi8f6ZVlCyIQEWEWODtL6OXeQFAnMBzWlNLjwM6To0CbVljDQahg489fwRTJRaY1p
	 I5AiSNMhV9NHqxRi6LbLjCpElyCBtr6N4Wuz6kmxpP48zJeRP+rDoT3gh3k/p7+q6A
	 uXKqb/x99h3ag==
Message-ID: <sashiko-outbox-173297@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/17] mm/mglru, smaps: convert to LRU refs based
 operations for MGLRU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kairui Song" <kasong@tencent.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261016-mglru-fg-v4-8-2106750c0bfa@tencent.com>
References: <20261016-mglru-fg-v4-0-2106750c0bfa@tencent.com>
 <20261016-mglru-fg-v4-8-2106750c0bfa@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 18:29:47 +0000
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: Kairui Song <kasong@tencent.com>
>=20
> PG_referenced is only the lowest bit of the folio LRU refs count
> (LRU_REFS_FLAGS) now, and MGLRU never kept it stable: promotion used to
> clear it, and now it toggles as the count grows. But with the LRU
> referenced count as a stable API now, we can use two helpers to provide
> in-kernel users a stable and sane reading of the referenced status of
> an LRU managed folio.
>=20
> Add folio_check_lru_refs() and folio_clear_lru_refs(), which use the refs
> count when MGLRU is enabled and PG_referenced otherwise, and switch the
> smaps paths over to them. The lru_gen_enabled() test stays inside the
> helpers, so its static key is not splattered over the few call sites.
>=20
> Convert smaps as the first user of them. MGLRU now reports every folio
> with a nonzero count, so the reading no longer flickers and clearing no
> longer results in an ambiguous status.
>=20
> The classical LRU case is unchanged.
>=20
> Signed-off-by: Kairui Song <kasong@tencent.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-mglru-fg-v=
4-0-2106750c0bfa@tencent.com?part=3D8

