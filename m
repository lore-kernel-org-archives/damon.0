Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794827552;
	b=JiON0zLqvkFdOKSkiBQRGFOcQnMHLRWjqvI+PNa4lhieTCjXBUzPC3ZHgCBj+GfiS2K5
	 QRH0aSoG7687biKa7bXu1GB79/Dnx3xGLxicQaX5kAqcvS+JRhnQNg8IvJgsK8O86p41s
	 XfVuZ7YjyXirFYuwQsvOKMJ2TQD+XzkOS+TgSabGsFTJNMJHSy9vO2MBdoIxOV3SiTly9
	 b8nYL0FdvX6uHQCxCLe+4MmYEfBXUaI62fJ7w2aRFuamauqXjbSQCV3DjKqHqiszZ5jSb
	 fw+X/L3BqM1ICaopUvN4rqlk1aS2zzEDVAAxoboU8U5iV3VVMnkAoqfYw9JlF1NSW+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794827552;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0Dg8DmwHSnRGGXbtTqSy4Qvd9qn7Q3BttvbNC3OfrFU=;
	b=Mb12ZIiO1piGjCrVhAOwzlj0mH5Vaqen6iR1enlLD6JDqqWVQxWdUr9RsX612YyAQtWa
	 fYdyPGv+fHxc7qQuj/T5uaEKrqE9MAgJhO1DF6XcZwJV2m+4+JKip7tf46v6Y3Fu/SiNX
	 ogGZ2ghAR4bh4HzgpTQnsk5CNggadXUKmHVQAezQxIserEbkMFffNu/yvQQ0uslzXcstj
	 LntEdHyC3a0JTjlIwF4OAJyTMmzXUd7ZUQG6LSYy6IqbzPE0oPF4xKdHxANBaKn8lsr6u
	 di1xB5OQNEiz2pa53KCWvwszD+k+YEmnhXTfES+KSd1EjzfMG8kayNvtIX2OaWrgQjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ala8p99a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647B3606A88C
	for <damon@lists.linux.dev>; Mon, 16 Nov 2026 11:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ala8p99a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1611F000C4;
	Mon, 16 Nov 2026 11:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794827552;
	bh=0Dg8DmwHSnRGGXbtTqSy4Qvd9qn7Q3BttvbNC3OfrFU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ala8p99aYFgL8HwcOCBG/fPH0ufBVbtEGNaInXotLGeBs8nAQaRHoTK2SgFQp20bk
	 6IIu3huWdFaMUcvdyhimUgHIU+G2lkvgwXxFLFxw8pg8HNYy9dliukK2zkzDbutY1a
	 oAnNqm13UxPRc7qCbUZPm+evDuv88Cg9lKlF8wlIA8MhJMYWlLbGdIsisXxuMj1vDB
	 NnLyjhj0/5iRtcClKBwpw1D5oLqBL/nVIvRfrvLifrbvsVbVa/92n6Fnvl8w+XAtX1
	 GTYsRWvRbyQzjOwm9OeEWAlmA+FwXRpKovpuNahpeosgDjsOsGQsBbqXCN7s6OZWE8
	 4KoDOduNXnQEA==
Message-ID: <sashiko-outbox-216857@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] mm/damon/tests/core-kunit: test
 DAMOS_FILTER_TYPE_AGE_MS in damos_test_commit_filter()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jason Angelov" <jasonangelov@ucla.edu>
Cc: damon@lists.linux.dev
In-Reply-To: <20261116-test-age-ms-filter-v2-1-3b265d59ec98@ucla.edu>
References: <20261116-test-age-ms-filter-v2-0-3b265d59ec98@ucla.edu>
 <20261116-test-age-ms-filter-v2-1-3b265d59ec98@ucla.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:12:31 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Add kunit tests that commit DAMOS core filter type
> DAMOS_FILTER_TYPE_AGE_MS.
>=20
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: Jason Angelov <jasonangelov@ucla.edu>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-test-age-m=
s-filter-v2-0-3b265d59ec98@ucla.edu?part=3D1

