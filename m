Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC10371076
	for <damon@lists.linux.dev>; Fri, 28 Aug 2026 18:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787942702; cv=none; b=fLHigEK1izfSic/TZGWbM5z8QXpJPuJQK3XCywjgOk1JNFmNNxfXE320DtB0uL0yO1zTrvsJrXleH4o5nNtukh0zHUM9iHilcKwGgq4FZHYYHYoFwmOz8Vqs2AIhez4g74+yb6XDgVZ7tYAaEnXY11WL2IOJVJKS2TWuXdp2EuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787942702; c=relaxed/simple;
	bh=iTC4SlQS0B5hkGZNcMIcanDAATC6OLcVj0m96Hvglgw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PRcSUwAqcmxqdw56RnPVGQzcg+FBoU6KzAqhNKt/I64qwjU9UDEDyKA/xzVQhedLKhM6Qsr3zkhEJaaDOY8uYDTKUDX05+8dJudF1xIIg/FqtPJqx1qMqUkv5eL6CEoLCYhRhdgM/AaMKApqRT2uwVh7mwsAfCdAy43zMF7lVhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJbuDu18; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJbuDu18"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 763E61F000E9;
	Fri, 28 Aug 2026 18:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787942700;
	bh=xctjv6J91u4pyvSgYW5A7Jva6kvtCwB89NXdd4u1EA0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MJbuDu18mUmdNrBw5fY/bQM7lgBpgMHSUCtK+NwaR10arB+huGHmWMxYLIPa7g9av
	 Fozr81MiSeqZvprtTukUArgXwMsB9SLD1xjJDyX+KxcwTIjX1RGAGp/C2k30nQPrm5
	 7iTJB2YnB4EyzpEZ5UcjX/gqlaUUTvO33iv3BtwMPtxrIJ6eAS8D69Z2zroPhWDTLu
	 lPuNAk3sbET7Rdn7ATlEF70iUnhxuz5KMJ6UHkJVlXObEz2BsTYZaXuL3ReJZchucb
	 OHjeahnFai24e0QOvH8bW1pkX0gZh/VEsgLwyqQMVXdSLXdGNcUVCQ1GDCpdI+yV32
	 XFWsS8Qcu75RA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.3 3/4] mm/damon/core: copy nid for
 eligible_mem_bp damos quota goal commit
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260828183649.71192-4-sj@kernel.org>
References: <20260828183649.71192-1-sj@kernel.org>
 <20260828183649.71192-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 18:44:59 +0000
Message-Id: <20260828184500.763E61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damos_commit_quota_goal_union() is not updating the ->nid union field
> when the goal metric is DAMOS_QUITA_NODE_ELIGIBLE_MEM_BP.  Hence, if a
> DAMOS quota goal of the type is online committed in a way that it will
> reuse other quota goal's memory space, the new goal will work with a
> garbage nid value.  As a result, the DAMOS scheme can show unexpected
> aggressiveness.  Do the update.
>=20
> The user impact is not catastrophic.  No leak or crash happens.  Doing
> the quota goal online commit that can reproduce the issue is expected to
> be not common.  This issue was not found by real users but the AI
> review.  That said, the issue can reliably be reproduced.
>=20
> This issue was discovered [1] by Sashiko.
>=20
> [1] https://lore.kkernel.org/20260827045035.94611-1-sj@kernel.org
>=20
> Fixes: 9138e27a3bc3 ("mm/damon: add node_eligible_mem_bp goal metric")
> Cc: <stable@vger.kernel.org> # 7.2.x
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828183649.7119=
2-1-sj@kernel.org?part=3D3

