Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640764;
	b=3H20sCuWHOpoMuETlJYAuqbtu3JqJ4qJ/ygYpfSFjoKElx/SxnSsYWf1smy1N2oO4CAt
	 PMzdkVu6njJQrcqI75se2RYriXCzGqpmhhFzFDTCBa1W22vXLktv/Uau5h0mHCr+IWjp6
	 2pt6ofmRAAdKRihU+5OIlVW1XBAk3gxxTR3bCcMNu0OGHFK21PJSmVymHnTxpUpHL5Lhj
	 JFVCfRLT17vKRhKhTmYHDMv64aFhgftZXIweu7gwp5ncsf1ZObFtvkAGNU7PmTvw+lkZ9
	 8ye4qHbj7J39/wpyGo4A2Zi5cZfN8diMWulFQYXUVcLqkyIUiSyD1fyTB+29N76SAZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640764;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7bB8ySSt8K1qg35gYM/dPNYF/jNWDLgBz0/koSQrHPE=;
	b=CZ57mLnTiY3iX4JRTvLNOOPEocPHJJYWLtS6DYnQLFmk+y38np+/30aTN4TMfv817rF1
	 tblV3VwRQWFq1ToxnFb2SwEp/yUo9fFL/mihqmgGXm+hxis8+DTxL3RgIfxpKHPepOGRc
	 FlCYUwXbvKVh/a00JDo5e4uSSzaCAO43QV9yRylrHjvaLoOIENEWjoyiTDXxW/DcVlgEy
	 W3MTtSrlUKSYU5XnEAMYc+oEFOufi85lN/Y1lbj8Z0RreTCpnz72JANNuXOeaVQGBQonE
	 vFL5//Nd+RNUqezYdAI1dLIjk5alFpUiD4BIlKF2xWwcUT1SHRpQwWsELc4lb4YK2Jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FubkOjgt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38B9606A329;
	Sat, 14 Nov 2026 07:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FubkOjgt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E2FF1F000C4;
	Sat, 14 Nov 2026 07:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794640764;
	bh=7bB8ySSt8K1qg35gYM/dPNYF/jNWDLgBz0/koSQrHPE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FubkOjgtkEFtsYgd+JwWIq88EKiM7IOWGniyf2w5j8PJhTHLpVzcnN2OVvkkNK8gU
	 NkoMyOg7A1KQtQ+pI8d/1JP0V+KdgN9LtYM5E/C3UyOWrj3URNgk/TJ9yEkdTKfJxw
	 i03IJIv2dmekcuccif+wFGI2kLnVuYI1e+M+YlHjMJNRQY7XvBlvJva7LQSCIXxoYJ
	 PJ8OMQBVANgoSVA7A+la5ldw4uBE6U0j9H7U0WGzs+eE/WF/Pa4uLaGrKpTDMBitBM
	 7IRYePwz1Q2S09UNGTSQeLHI89L5sJehCGBmuedfZ2AEUD7b3z04Fu2POgdfMrzN2Z
	 WUjMg3db2lTwg==
Message-ID: <sashiko-outbox-214253@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 22/22] nodemask: remove the now-unused
 first_memory_node/next_memory_node
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: linux-serial@vger.kernel.org, damon@lists.linux.dev
In-Reply-To: <20261114070959.3490008-23-gourry@gourry.net>
References: <20261114070959.3490008-1-gourry@gourry.net>
 <20261114070959.3490008-23-gourry@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 07:19:24 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Both helpers hard-code N_MEMORY, which says only that memory exists.
>=20
> Every caller now names the state it means, leaving no users of either
> helper. Remove them so new code has to pick a node state explicitly
> rather than silently getting N_MEMORY.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114070959.3490=
008-1-gourry@gourry.net?part=3D22

