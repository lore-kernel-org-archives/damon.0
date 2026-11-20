Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795198815;
	b=pvTizjSM0qrlN6qlaqAgTZicpephi76DPtwFy5aA4GpNJwnXvGIK5+d9bPPLlaydQDc1
	 Ndxp/M7K3Q2LOpHvxYHnyFWWnE1cd4en5/OQO5fjINvGrfLF5cBeZwyYJAFm+SvqJ7EDi
	 2fj+0eJ1bpaFtHbuKr3OdzI8TZNJueyGn9GE6+TuG0X7eOFAeeR0zBary+08B2rNGtcUF
	 PpdxTZoARDxy8iDslAjcRCTF0EAu0NrvglVEnuxFsMAsU1iYCOe1YWE+tVYtQzp/jzCFV
	 rtfSdmXupVYSqIdL5FOBrBru+84OFOANlkVhToIf5Q5FQXQBwWuTXsQQD9XjQOnICfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198815;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=penhgHBaJHx6I/qtyZJZlFjWAhXuhYMgUd+ZSSx1ya0=;
	b=TqZqp5qLEAXtgxPWAHn1D6ubvwya5y5ySm4P+iBmDdFBUcyprivnbBcrCP5+2G+fwFAJ
	 sF2nc2VF5ZP2X8f1VwZP+SBzIDTDBK63RiBF2cxHkUrhDgbk5Bv/X4SAmdodcc/Ryl9gc
	 Q2SjUVEC+Xebip1nQfFLV2TPqvESdrH70hUlo8dJE4KryRg7le6B4K0KCPmIJcVmu3SZw
	 h57lPzzagStaKs4xHyW57bcagk1rydSz7qmSBUAn5mwtqOOFTlPsC6hMBHAX7zTyhPziV
	 fFAIRcZd737deoe5YHjh0ii44myja+eTXdcN77O3wlo1LVoqFj7huFPRCUXj0y93Zow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CbGIYylk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E14606A880
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 18:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CbGIYylk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C2BD1F000D8;
	Fri, 20 Nov 2026 18:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795198814;
	bh=penhgHBaJHx6I/qtyZJZlFjWAhXuhYMgUd+ZSSx1ya0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CbGIYylk7uPnBkuw8y32HEs30QkegB2Q8wepew29tRb0TR9Na8AIG/+VORrzM3z3b
	 ThMTQtCm7QtFEiuMS5enPV9iiiD3hwNkTBrY/GTJ/xmp6H4hR66JZQ0BCKoqPhBeGF
	 pEFx91Bqv+QgX3mmsl3LZMmWkOk41CK972XrVcrsL10gycbDMt1R/oNA/X1i+FpodG
	 EdtLPtjD11z/iG8/g/xrYQU9gneuTkEUoIg5knjJpnwfQwcMi5YqGqIpFA8rPjfNpV
	 5EedtU4iirNPQ2C2KUudTPV936ZaRc8nNjh4lvts7JTG4najDK9SaYviP3KrGcXWtA
	 1Wx2lniElhlYQ==
Message-ID: <sashiko-outbox-225802@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 15/60] mm/page_alloc: count common memory nodes for
 kswapd recovery
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20261120-private_nodes_v6-v1-15-74f5f9a115c2@gourry.net>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-15-74f5f9a115c2@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:20:14 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> From: "Gregory Price (Meta)" <gourry@gourry.net>
>=20
> When a zone recovers above its high watermark, free_frozen_page_commit()
> clears a hopeless kswapd state if more than one memory node exists,
> since allocations could then have fallen back to another node without
> triggering direct reclaim here.
>=20
> Only common memory provide fallbacks, so count N_MEMORY_COMMON nodes.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-private_no=
des_v6-v1-0-74f5f9a115c2@gourry.net?part=3D15

