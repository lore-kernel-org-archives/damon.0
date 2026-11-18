Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795037370;
	b=CLzGqyeMbk43yd9OdKOElrADmilmEFNQ2/1nAYt23ke9XOqwoLCoaiNz/PLFhrvHorbJ
	 r4sVQLDtcjgKE1GeRliubZq/THu8r6YO/J0TEqdYcRyM7qPi+BeFpERtVNuhQJ3I3/g8B
	 lXN3mVbd7KH7QYroky1AC+/BUTWdJUnC6G75IJp6QjFUfKzPGiMCtF/4vnCFj81zSUOP7
	 pffiQ9E4ZrNK+swnfzPgyVyPpiOwgoLZDRJ0Q0rlZHv/dN4V2Nccz+PbzmYCqJkZmM9+4
	 PYOIB16Nx6mhDOnO9WsVETw4RjHsa5q67dbRG1IoYdOjIAxV429cgmFNIev3bikkRcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795037370;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Hty+SAinIT+d1y6mDfViG/MIK6wVZd4WahXCr3iL1Gk=;
	b=b/IdQuV35GSMLfwnMfP3PWNOl4J1qIA4sld6NRQBNYlTf9PqD9V9DLxyBisROwPMNxdy
	 io0/g0yWIYVkHnovZUJK1/U1lLyu6NH2G99eaJ8pb+yqS17AMpxmrca8LWJz5X0PP+EK7
	 vMwJ9ugKXRB7l13y1fF+xXhGbQF6xUV5w+qEcTfArsc/j3LxNiXtwxjCc9lLrfyl71xG9
	 d+JX4lDKmZv1AUO4m+5K8TP+fwdqtZeuGH2oZE9FpCd10c5pxZfNhiQSDejLlDCR05qKv
	 XqhUiNigHdNMnCxovldJ8NBMVhuBEURA/3bJEHn6caeaa7Nw08LGLmu7W8TytBrL3og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aLEcjyvc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8405606A32C
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 21:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aLEcjyvc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75BEE1F000C5;
	Wed, 18 Nov 2026 21:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795037370;
	bh=Hty+SAinIT+d1y6mDfViG/MIK6wVZd4WahXCr3iL1Gk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aLEcjyvcWFSgXvxHecpP/UuIlV07Cs200IFv+U3ucMmxEgsECCzXTkabfYywHQWQL
	 06pirokp1sJM3X89tvPnQMVv5y/mV4K3nOublHLQOdc65AUdnpCqI5bZfNKnW09GWc
	 fJJOmxpLvZp1zWuw4KyH9f1UcAS2Ap2e2FGBGM/0zYPs1v1qedqjXyFCY8AMhzJ1Xg
	 Ial7FSINWFz3jXMhYhxdY16xyR0vkdEOqD3+52y4fNkAbYa9oF/RgBI+nTuKxyWWwV
	 Ud1k+/cvsNXnA8bKgKX47aVnQWrnqKWg0WfEJGmWqQSN8YU1kPK5Qq4gWR2k48LhPk
	 s5Gb7PGZYsk/A==
Message-ID: <sashiko-outbox-221997@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/17] mm/mglru: frequency guided workingset
 promotion (MGLRU-FG)
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kairui Song" <kasong@tencent.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261119-mglru-fg-v5-6-9eee2fe97a2d@tencent.com>
References: <20261119-mglru-fg-v5-0-9eee2fe97a2d@tencent.com>
 <20261119-mglru-fg-v5-6-9eee2fe97a2d@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 21:29:30 +0000
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
> Complement MGLRU's eviction-time tier-PID protection with access-time
> frequency-guided promotion.  Introduce a unified set of helpers based on
> the referenced (access) count of a folio.
>=20
> Like LFU, this uses access frequency to distinguish hotter folios, but it
> still reclaims by generation: the generation and the bounded refs together
> form a "logical refs" count.
>=20
> Accesses increase refs; refs crossing a threshold trigger promotion, which
> moves the folio one generation newer and caps its refs at a lower
> threshold, so a folio in a newer generation with lower refs is hotter than
> a folio in an older generation with higher refs.  Gen aging then lowers
> the logical refs without updating every folio.  Accesses from the page
> [ ... ]
> PG_workingset and PG_referenced are no longer independent flags under
> MGLRU, so existing raw folio_test_*() callers need to be adjusted, which
> is covered by the following commits.
>=20
> Signed-off-by: Kairui Song <kasong@tencent.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-mglru-fg-v=
5-0-9eee2fe97a2d@tencent.com?part=3D6

