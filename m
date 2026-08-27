Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B912FC037
	for <damon@lists.linux.dev>; Thu, 27 Aug 2026 13:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787838812; cv=none; b=mdghlseXuBIxHV791KpsxbnjaMRH9D0/1+LsdAkPwpPA3vDFicYbiZqAKYsC6KK7EX/oL+rtwdbgl9GffyO7Zd039dNAyYVQGwYQ1FaVbd4tOOWdxO1fKFFC5wQU2F2eb7VRQATbakLH2Q7xb45tB925QAj2g4xi1u6Zs9H6CuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787838812; c=relaxed/simple;
	bh=GyvTHTgGcLLoaqpIsnwX/z8aj6G1hbGXSTIvg35dGvM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b2J9DKYl10QQN27VfFyJD5KokqFcSlYZlXg3LbypaKBtpLxkzFL9o1JV3cGpmJL0mSSd8ucuzBK2+xksPZmluSOtM6PPXHGvskADtsG2tAuwxhoKlntUnxjWycOUMIYiPVubS0kVT2Y5tH+GICJ2IE8MpCO19t0AP2hAlRQZ1pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9t+ou/b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9t+ou/b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783351F000E9;
	Thu, 27 Aug 2026 13:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787838810;
	bh=tuFF90O/GEkXUBjIBGt8l6ACtmMePpzyKCmr8ZtiDWg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L9t+ou/be10UQsvun+w2SBzsptZWkiV+79kkRGegEEQZyTLQz79KPkEKmHPbwHoJd
	 z1j31iEClgn+kNDAQAbWukKrtkoXWasohj0EGNtTcFad3RgpBeBNKZNatMgIjf8tDW
	 Am0OEHPVm3Nu92/2Eh+315EbJ1yjM+ZlkvcaszgeHvWSyS/sT5+r64L/Mu66O78JZx
	 pil8+W0FQtu9gs6cj22LFTnKVtoUqsVo2PPzAH8Dv7Qrbffq2nX0ZgHCsOX1uAFoOx
	 OPmnwvMlI9lNx0vElZXg2960URNg6LJrwdF3bcn092Bc0ai5fcR0HnBlNDWylbMNe4
	 D4cfIIXn6VK9Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 2/3] mm/damon/core: copy nid for
 eligible_mem_bp damos quota goal commit
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260827134429.123023-3-sj@kernel.org>
References: <20260827134429.123023-1-sj@kernel.org>
 <20260827134429.123023-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 13:53:30 +0000
Message-Id: <20260827135330.783351F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827134429.1230=
23-1-sj@kernel.org?part=3D2

