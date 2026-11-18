Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794968746;
	b=5go2DxT45/77QMQpYuOlbXOY8pNaCUx/nKqKbgRgOiA7eU4Op5qVmlkyKSShDTOXw8bF
	 Nb9jnQAFCjPQF9gw91t3mAvLI9nPt9ZAeNPU75cNh7pjUEZ1AyDlLolbo/QuxOLjNxVmT
	 NA79krrZmohsl1xH1idUkqqks/0wBSn4KjbGZn6eygqfIIJ87xMicULOiH71o/yqJB6gr
	 xDtXFlENl5xj+9ihy8qUhl8nD4pINmRIhZsXP9nxVyFb4R88zhIxenogL9UohoJDMAAGn
	 WlLd9t/T0L96e/oB/JadXpV2BZra+/XUX7JOgo8OlCQbKXVTIox8D46x11SduIVmQvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794968746;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8/zT0jyDrlBsR0KTkGmSxB49CkaFm6d7J+SE0ZH7yLI=;
	b=YVh/2sTpDz0MYl7zuioWrFFrB7v9o7ynU5ULH7iDgC2F5v93fVLgxC0FLd2QUh/Bsrjm
	 MQET1sli1ENBEhrOfSpPdFnU0Lz+QO6heRfvAovWH8+q8q1fm2XdRZ5t7zrMk9clzED14
	 vcu4lcLwtBs8/hKeBu5WBfJym91j0mfK6RwRgIkoNZRnoy0VGrhIUdZVhp7s4fq+tFrqL
	 oi2qf99Ha9LBqcLx1VxPdyj8HC8SdOWkM7v060/sHsB6752Wqj82P5SBuhAzR0T3vLv4U
	 UK96V3ek+LQQULazWXA12ATo99smmWvj/XFZHHUtmdwufcxr6gRLD5OfqfA03T/8e5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bj5L1URr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C533606A31C
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 02:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bj5L1URr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371161F000C4;
	Wed, 18 Nov 2026 02:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794968746;
	bh=8/zT0jyDrlBsR0KTkGmSxB49CkaFm6d7J+SE0ZH7yLI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bj5L1URrb6vXq05l7Rlou2MNmLLC1wWontbCFOkI/pWKABPlLkqYwfWvyo3coTfVo
	 tGWoxr+fzbhXr99aaGJcNFDteIUvDr/gHyi1IJeA4QbZ775knAGJW5A8uHCRhHR5hm
	 RYPruTPTQnX7YFgbikNzPj5tt8vSXGHTyOR8lStsQex2knIOddsidY9Mme9yFt6J3f
	 FQSTsMmKD+tqijjFnpqMZkRlIjNhGNbvxjrc708UcguKGUx54v9fXUvIkk1UQXXpjb
	 Pl39fOttNLv7vYsXcVbMkNZF1MmNS3phGo3btZA2AfIFT05WtdcPZDaSAO6s+d6uad
	 GESAR+3UddiHA==
Message-ID: <sashiko-outbox-219940@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 11/27] Docs/ABI/damon: update for report producer
 sysfs files
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261118022225.100659-12-sj@kernel.org>
References: <20261118022225.100659-1-sj@kernel.org>
 <20261118022225.100659-12-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 02:25:45 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Update DAMON ABI document for the newly added data attribute report
> producer control sysfs files.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118022225.1006=
59-1-sj@kernel.org?part=3D11

