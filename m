Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794165527;
	b=L+1qrbmQpztwTS4VZtl1H1Q8jZ8Sh/7beog+g0UmbgNhKl+QCPHqR/4I4NS1+VFDZkwQ
	 TB6iANRyfeLgw3mwLAf1Szqw3H8QboW1q6IOephNl8+xkKxu+EG7YnSFB+cL7MnZta6AL
	 8y059/aFDx3SAVAg7Fc8sznWxn5PckC2pMHTJ9TvcHLVMHSQcXHTxbaqBNOoJCcb7kyZf
	 lUNSYQ8Ow3y6WHNOD4/x68ei2syx5QNit7W6T6edIb4mh1PQ1zRlT7GECQCaXs4yaGAq5
	 fhfhPjSiHrQCxS6ExMeDPnqH2Qhc2M9SlAjjdLY7vvyXITYt5efDgv8EFjf2/E/fyFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794165527;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pTp0FtP0KDykKtMCyqDUBSFPpcdMtfp9mq6Oal10slI=;
	b=At72+oI58QalzF0vMFU2vUGGo9q6Log4A8QozTVBw0GpfK8nPT7UN2SxF4I9U9O+Igg/
	 CZz3xsyOPM1Wjt4AcpDaZJ7roZBGJ7kgdK1eeDIBIYA/1KZ7zphWtt1X96xg4ciVSx69y
	 SqXKsu2IyZQGPwOohoMCOzwJvGoUvuJjk9mqCfLj1FA3/ftJZi9y5Nijb6+ZKZqFqsLbJ
	 EdRJllnGvxjqObfkeysOy4Wy7VZFghYCLr5axuDqWnj5F7oNazPrKyw8fzNE2+UhdJdIS
	 jIrJ+SoixaYsngxTYFJza4N3MvCn12/3ZKTPr1hxeUlMCGVggrZwhcxI1JzFa46xf4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U5sHN8Sv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3870B606A320
	for <damon@lists.linux.dev>; Sun,  8 Nov 2026 19:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U5sHN8Sv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30F81F0089F;
	Sun,  8 Nov 2026 19:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794165527;
	bh=pTp0FtP0KDykKtMCyqDUBSFPpcdMtfp9mq6Oal10slI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U5sHN8SvpKeQLz2PUMFNmY604tMYEdyfcZ0aCGWCbxnr1z5CSvgIebmB5NbbaHVos
	 64QBw7daMsmdcV4WksHsisbrt/qbSbeCcWPLYrkvYJVee9sKjYUXzuvS/D/MoZKl9B
	 GCY6O3esJpium+CXDR5NVzYPZani/9mmx+xZyaj/wbKIg/cujcyuepJ6guGntENwDj
	 0WbwYp5b35oTEOlBrkEcuVLLQq6wN5irOtil/WzjzWAAcKwuOpKXMzuiZnrmT8mcXL
	 js/51mmQljXkfup1GfHsscN6T+1pjPU9UJnJXyQpok5JpgFdEg/JxOuwgr0gWd44b7
	 x/nLpHii5GBaA==
Message-ID: <sashiko-outbox-203932@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/4] mm/damon/api: define DAMON_FILTER_TYPE_ACTIVE
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261108191615.113362-2-sj@kernel.org>
References: <20261108191615.113362-1-sj@kernel.org>
 <20261108191615.113362-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 19:18:46 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Knowing which memory is on Active LRU lists is useful for understanding
> and optimally operating systems.  Extend the DAMON core layer to be
> ready for support of that.  For that, define a new damon_filter_type,
> DAMON_FILTER_TYPE_ACTIVE.  It has no additional arguments and therefore
> no additional change in the core layer is needed.  Testing if a given
> memory is on an LRU list for the type of filter should be implemented in
> the operation set layer.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108191615.1133=
62-1-sj@kernel.org?part=3D1

