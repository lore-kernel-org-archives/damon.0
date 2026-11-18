Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795036344;
	b=vR64a7RJtq2D4R27rZKyirly91NvjFyamwY/Swub5B/ilcOuAdMLk/SobHg28mPM6JxQ
	 dtx2NLaUQE5AkRWOw6L2NU0HBdfhPNYSuNXhX8loYo0/rGDVsVSz0zQqfZCg9Uo077mnv
	 OjLzRpyX7hwzbZN48GUNlJUVEGaHFlPLbNT/CqwH5n7LyX2gvmC0wXK8AWKSWsVZ+pmvy
	 hCFR9Q0bPIDodGn26HggJ3JWhwS0IxrVTD+vdtAFKvkpJsDmgrZolqiIS8nuCuJ7xbMLd
	 A4NXTgGHpojbckvZe9cs0m0XK3fCaOkJlFyHPyG9rpescHNU8L5prnGL5IVAW861boQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795036344;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iNg4rBCu/Nkz8XDodNOoW7n53970StS1AvMtU8FQt7k=;
	b=LIaPzpiPGhVVAPHo1DuTfa4n5uXEMHXNk2HmCPDdMA2k2DF3dOAU0P2gT+lv0hUP6Xr3
	 bKXZn22uehHqAQLPWPJ0HZ1HUdW1v/ZFfYu1z6iKqeA++3lsOEMSZS4EepBxDojrgna0i
	 /hq7faGpXzRVYE7T9O1SVf/IxqZt1jw/HO9kmFLl37wyYNRT363Pz2TKkRfdQMipXrGag
	 /6w/RobrvGavyAB9ae+sBg1i1/QjLzGPoWxfU1TKrpRPc4CzbwJAGOkRzeNG6hvWi1aM4
	 AGKN2H3lAeP76LA67noE2zGcqqTDKXPOc974BVN2/49AAsC81VwHkKGUevDVTuEE4Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XB0U68fg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC21C606A320
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 21:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XB0U68fg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575681F000C5;
	Wed, 18 Nov 2026 21:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795036344;
	bh=iNg4rBCu/Nkz8XDodNOoW7n53970StS1AvMtU8FQt7k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XB0U68fgY4Zdoo5X3pvMEHIhDesrrqyjKl3pBf5wZFoVt0yKP83Jrzv+wncJvbC+0
	 osxZHfogyoejZ+QaR3SV6jrfs0lQvaxHPrYoxbgrCsa+rQuhegUxuTs9YFF26d+489
	 Z4eqoXyY8KFmVrk19m0QCw6DSDMA4MkzQgbcWnyHDOBU/2MTLAASp8psnChtMMDzQM
	 JxhmjV6JHwqbu2Y1Qjo8Xw0hG5A4I/UR+X0KGipLjMcZpQtVJe2hvuPMMlQnWBuRdD
	 3gfvNqoxIh60/dRlHuD7rPboDAW1IhJJ4Uv7/hUCFVKJGvFrHq0hKc+XDlrfT6dcC8
	 cxtoMe2Bf/BYg==
Message-ID: <sashiko-outbox-221978@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/17] mm/mglru: make generation page counters atomic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kairui Song" <kasong@tencent.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261119-mglru-fg-v5-3-9eee2fe97a2d@tencent.com>
References: <20261119-mglru-fg-v5-0-9eee2fe97a2d@tencent.com>
 <20261119-mglru-fg-v5-3-9eee2fe97a2d@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 21:12:23 +0000
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
> No feature change, convert them to atomic so we can update them without
> holding the LRU lock. A temporary underflow is fine: readers clamp a
> negative value to zero, and the counters only need to be eventually
> consistent.
>=20
> Tested-by: Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-mglru-fg-v=
5-0-9eee2fe97a2d@tencent.com?part=3D3

