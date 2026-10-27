Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793109914;
	b=NLBCNzv0vq7C7DXZnTM8qmNgZpRxLP6zR54QHeMNQ/pkEel0mT2RtDRJh2AAXaA1lcxv
	 AlGiam+AF7tagQn1+GUxV2+1XXCqT7jCC3fITuBydf1K5JEP2vxTSnI0iCMQvv6/laLJr
	 MezLXkoaoUiM4U8kXlDkqK6YWBODIQDB3g9hgx7Qw5pVpeNFn50PG4yN2uPo+iDWfoDZM
	 TiVatnW0ZjmhEt6ZBcqnIKGZIXRxWpbps1z82TKa6s2Vb3UG2VxNZ8+9o8/zwA1+FRUUw
	 fXFbOO5O0ItY0sg7nBPG5uqmzlHY2uN50M9RUHFBdk9EGku2b2J74fr/Mza5/V8y0pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793109914;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4KhxvdvDQCeedsWKLn5TkwxzZrsB6FbsYmXemrM3uP4=;
	b=15Im9ATKwgn5fhcYjMeMz4Ru6ThQIjNeamytVregicxpMzj3kpXBHtPZgISMQFSh04zx
	 2Y3+7SjmriOo239jhm46o7tvauC+Iae9urT3HFV9KNGYZLbOKNK1/ODDQuNCwnMpVFkTb
	 6SaB0SoFE3bs/OlBhnmiHM+QTL+x+kfOPLB2+Z21iv/Xy5SyO9RsQztf5jJ/83MnPnjXr
	 lqqXowuxMrKRmLdOCwiOlFNuo5/qMBgllfYeLgxP3qGoM31vak0vcyrDomLC6P+gSx5Wz
	 iRm3e0iRFV1WPZ43x7+CijkODzA7Ygu2xgSomzAdtLCjmH+i7HHXvCCiyMhNNaHesJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kqulH87C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A7F606A31A
	for <damon@lists.linux.dev>; Tue, 27 Oct 2026 14:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kqulH87C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BB6D1F01825;
	Tue, 27 Oct 2026 14:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793109914;
	bh=4KhxvdvDQCeedsWKLn5TkwxzZrsB6FbsYmXemrM3uP4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kqulH87CYTfP1oN2RE0+A4lYmk5PZVtv6UbZrHy7S3PcyoPrHE8cia9Bdq4ODrjd8
	 cosWbLLm7RShdxv4Ap81KLBLbHgpCGUjTFC75prgvH+7ZHWLPG+IIOd7iTVjRPkS6U
	 e7pwIUDJfdN+F0yWxW/xFwLR3mVD662bI061k/LH5hx8cFIF/+yAneCN5iruSDyDZ8
	 eg/3Abxq46VDYmnaR+G4QQxbb0P90QjZE4ywZ6/vox/SeIjD28FbcFONqHWCD/4ugj
	 YqiqZkuVs1ItaEZmbBUpw2muHk4Q7vPAGz7XronxjUFXMUmoYokMtzipBl0zT5xA7C
	 UYs0eIRDUqa4g==
Message-ID: <sashiko-outbox-186693@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/3] mm/damon/ops-common: avoid overflow in weighted
 hotness score
Reply-To: sashiko-reviews@lists.linux.dev
To: "DaeMyung Kang" <charsyam@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261027135932.2301646-2-charsyam@gmail.com>
References: <20261027135932.2301646-1-charsyam@gmail.com>
 <20261027135932.2301646-2-charsyam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 14:05:13 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> damon_hot_score() combines the frequency and age subscores using the
> user supplied DAMOS quota weights.  The weights are unsigned int, and
> both the weighted sum and the total weight are calculated in unsigned
> int.  This is independent of the architecture word size.
>=20
> A frequency weight of 50,000,000 makes the weighted sum wrap, so a
> region that is accessed in every sample gets a score of 13 instead of
> 99.  If the two weights add up to exactly 2^32, the total wraps to zero
> and the averaging division is skipped.
>=20
> Accumulate both values in u64 and divide the weighted sum by the full
> total weight.  Add a KUnit case covering a large weight, weights summing
> above UINT_MAX, and zero weights.
>=20
> The issue was discovered [1] by Sashiko.
>=20
> [1] https://lore.kernel.org/20260623141527.044D11F000E9@smtp.kernel.org
>=20
> Fixes: 198f0f4c58b9 ("mm/damon/vaddr,paddr: support pageout prioritizatio=
n")
> Signed-off-by: DaeMyung Kang <charsyam@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027135932.2301=
646-1-charsyam@gmail.com?part=3D1

