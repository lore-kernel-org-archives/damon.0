Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794969049;
	b=KKNF8GZLv3m8l1rkvPH+IyKx86TuAYLlDpdzJntqS7RZU8TlOoDD6EnnE8c6AHV2DZiJ
	 v6vy0MTZILZezF2+ibnNN2BCEde+xuPkiT8HFG1DNpRv95ZefGlqBr2RA3qYz0E4u/Piq
	 h94nHXY6+Zh/wdirJI+m2uVPa0N5LQRR41H1TKBhz8iBQFlkeCpYKsBbruoHjjllzCo4e
	 eghXgUGqrUr2qGIbTsKDdoPVM076wYHadDY/nhaa8Wp1KLVAZj9/Zget3EmQSMeTUbSPR
	 NT/jp+mAVmd06xrZ8OOeAq5r1UOzotizVtgMVGuuusQdqA4mhQdOwWE8HAlGl4jKSdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794969049;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Nal6g8P2977nvZ/EXcbzscy4qmx1PP1tbxj80g43+x4=;
	b=JtvNgswEy8LHoEGAVh4GTMRXcq/q8S5PW6PO+lMj2ndCQ4RmrVJNByioAtEaGynHIMLy
	 14RsfV+wHAZwKzi5ZL/bmCEIS9znifRukc4xjjefpC2jTVpyRrOEvChGyi2ysvpctl/yB
	 IEH8tu0D+XTnshgo7BASngmCh9OAxXth4WdzaHzEabhuQMRIpIG8AITAI1xMFQ/KuUsaX
	 4tbsS9vpJgDtYD/fqUJXLe7XBPuljI1XIySyZVPfSCe/DxF3v/XW/5Epg3xHMfyhNJRq0
	 35B3oEbBpcI8wzEn1+idk20kVid3UoySC2qIiF/2GZInjIqCLSC9HDebvLhXTVQTIJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XqeGmVK5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F45606A32A
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 02:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XqeGmVK5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E46B1F000C6;
	Wed, 18 Nov 2026 02:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794969049;
	bh=Nal6g8P2977nvZ/EXcbzscy4qmx1PP1tbxj80g43+x4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XqeGmVK5RvRzEbvp08ZpKL2cT9pDV4o6r79QngBzFjEgR/gXfqSaHeZ90ofSTa52t
	 u6kC68qw2dW2nbO3ldSEohbtReZlQS32AtEGr5KItaLbJHp/CKetKmiBw93n2XcAgH
	 mclwNa05o4nh7Ba1QjBp0P8E5iF+XjUtvIJjeahFtqNbp2bRS3tiGIhto5exYtgJe9
	 GXZ1XtcHvexWIsyT+Bmxme0md0pDN/MUzeLGk76twEB/0TXpcTC+eqqDAtaj7EI7rV
	 OG5d8qprP9oip7jiu0yvXWf0fQjKD1LLliI24UaeRvdw2r186smuU4S8rup5VkBrJc
	 mRh+1PU8Hg3Og==
Message-ID: <sashiko-outbox-219965@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 12/27] mm/damon/core: introduce
 DAMON_FILTER_TYPE_REPORT_MADE
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261118022225.100659-13-sj@kernel.org>
References: <20261118022225.100659-1-sj@kernel.org>
 <20261118022225.100659-13-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 02:30:48 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Extend DAMON probe filter for the existence of data attribute reports
> for the probing memory.  Define a new filter type, REPORT_MADE, for the
> purpose.  Add a union argument for specifying the type of the reports
> for the filter.  Update the new argument for the new type when new
> filter parameters of the type are committed.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118022225.1006=
59-1-sj@kernel.org?part=3D12

