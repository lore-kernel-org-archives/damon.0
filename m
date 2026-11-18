Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795036370;
	b=jjhdynmB7suuskqi3YzguY0slFl9o+ZVuAYPOBs7X2ZTQQfK6qtGSlKxaa+zQkhUr21Q
	 6kJHGwZvyWL1paVv5HMPCjvefg8WPF9on/YAyVqdY9QoyYF8fU5IG0DfAQ1so1qwcJbRW
	 DOi0O6O9rJaaVVTfYpl8Q9XPHtcV3dt1A14g2IdCyJRu1D34/FsODnqCPd95GYD7YVyuj
	 XK9bO0hMCpS9k7JpFuytC0CPe34Cu7IwJqvK2whKpXrA78ZMf5ItC4iePhBpXNzGTV0S5
	 Iz97ZRsUHvzGGc91a601dRTfY6pfB7K8SGXLWXrJyn/otN2BjgCxUEqsbWw90Npg0jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795036370;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WukCwBrAvqzoXdXp00mxHPTXLpCSeLyHarPg6Law1RI=;
	b=ZQ3JAqFXZhmqHHBI58K6EnTI4goIH3kj451Z7n9Ovv+9P0CAFAhcc9RWCNSg+y1bvWDQ
	 Wk0DYQxA4BS1J5ZlAYnoORURtDaQcoS26PpeCQgUp0gCaZ81QwYvo7edyRHlGMAx+NERX
	 XN4bqcXKNOVCJ7ygjPfEUmzyxLO0D5kfGspkcIHok/yF87vKY+PSI+O0xvuxJsN8vQTii
	 JgWXBrA0FfX6+7XFh0QMkcX8CVukW8O1qI0x9ZQg2pVBSR5mJqfEShd4gwNP5S7NPdeLp
	 SWcaetC1R2Cz7sQL/jKZn1Ab/sCtrA7aSXl4AMZ/VFQ6JSU4FIpCvtZk+O9btMjE4hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lFn68wbA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60339606A33A
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 21:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lFn68wbA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 111A41F000C5;
	Wed, 18 Nov 2026 21:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795036370;
	bh=WukCwBrAvqzoXdXp00mxHPTXLpCSeLyHarPg6Law1RI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lFn68wbApKiJ/QiUDQdTkGdBtBdFriI/cTeEe48Jl7Ig7hbo0yAIFFYWHrM3HVb8h
	 vjIOy8upFSGWR0ZBGb3GqWI01SeN2WojkS3Xd1yIshLbSJRVyof0y5szwH6pNhEWhY
	 B8l4Ce+71PS8aO16vL7OCHn6V+W+eWUCCBgjlLx8ucMKuohdfYDF54R7uF39EtIQeD
	 WbkB5SIclYfuxuXAnVdwchTDrd5iv5rt/JTzEFT9oC6WXSz2CYiy4+a7hgXJcMDQG6
	 7JZAfbvkJtUhi0xN+DwOFgkSOJxuA7fdUZNIfbVhvmVrRrMieJfjDCFX1ZowvYiPSW
	 nuffUbk8jzeKg==
Message-ID: <sashiko-outbox-221979@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 04/17] mm/memcg: add folio-based lruvec live helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kairui Song" <kasong@tencent.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261119-mglru-fg-v5-4-9eee2fe97a2d@tencent.com>
References: <20261119-mglru-fg-v5-0-9eee2fe97a2d@tencent.com>
 <20261119-mglru-fg-v5-4-9eee2fe97a2d@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 21:12:49 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> From: Kairui Song <kasong@tencent.com>
>=20
> Add a helper that resolves a live lruvec for a folio under RCU
> without taking the lruvec lock.  It takes a folio directly so the
> lruvec lookup happens inside the RCU read-side critical section,
> which a lruvec-based interface cannot guarantee.  The first user is
> the lockless folio_inc_lru_refs() path later in the series.
>=20
> Factor the ancestor walk out of lruvec_live_lock_irq() into
> __lruvec_get_live(), so that both entry points share it, and spell
> out why the walk is enough while only the RCU read lock is held:
> reparenting of a memcg that starts dying waits for a grace period,
> so it cannot race with the caller until the lock is released.
>=20
> Move memcg_is_dying() up in memcontrol.h, next to the other memcg state
> predicates, and use it for the walk rather than repeating the open coded
> css_is_dying() test a few definitions away from where it is explained.
>=20
> No functional change for existing callers.
>=20
> Tested-by: Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-mglru-fg-v=
5-0-9eee2fe97a2d@tencent.com?part=3D4

