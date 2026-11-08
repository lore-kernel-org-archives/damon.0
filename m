Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794165687;
	b=BNEzjQ9Mz+5SlkkxVX8pdYlqSO4Q2LiarCvdnLUgBPglxHvDOqVR4o2kHTLGKIujKA48
	 HSa7/oqwV1j7qQ4FyoAg4k3rcSy8jAcwtHi+n93xLssZ3EMbVcs6JPtbfyTYVllWdvs7Q
	 GUf2LMYvqdYO+1n5otvDavo2vaiVTsa2xuctfjjB5EDx8bopP0Ul257eMHc5s2VvDWGuL
	 r8IZzeEjI+DblswPSe/ssHPt9xAaKaWfoUoyyAiFvV6VKvsIzoEnYwlU4Xbl4fIqtpG1q
	 SG5QPGhFmR/bFI6DDX+2xjNkrG4wdbVnutt0cYVoQegZjxHoYwNMvUqAkLNw8llBqSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794165687;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hja2Sa6W/zsOP3ycpEzZvzC44Z8dnjjaAH1I7LCeZmA=;
	b=v0srUmEns9BM1iKTsjtvFZwpYjOM8m5wgul3+dRzXvQ0gXZyFcwNYkNJvZqloV92cBm0
	 70tdoGHVvUegAyEEfwbyFGT1TKjrLtbHfjLMUds3/rRIInFGA/HEm+QmI/9WYKdl6K5we
	 pnjYPUER/i24CI7RR+nzwLePvwkRmVHj8FuanIKyPA4+a62Z9YmNhlnY/YfUXfl73YZDT
	 qeR+MfHlnzBoWyhV2ZHCGwby4ZEm0lAQSGZwQ05By0yUSbq1UjzpRLxqnsm+7G6LQFUNY
	 MqLTseNyLsz/gy83Fwoz4d6UQ7NIneYpzpP4i7cCA88dCZ/A8Lh8rT+vNJ/lTx6Gcig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K1Cdsy39;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD58606A31C
	for <damon@lists.linux.dev>; Sun,  8 Nov 2026 19:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K1Cdsy39
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD7A1F0089F;
	Sun,  8 Nov 2026 19:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794165687;
	bh=hja2Sa6W/zsOP3ycpEzZvzC44Z8dnjjaAH1I7LCeZmA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K1Cdsy397p+Al8MDqJyyqbnxhVpBRS5gMZaitC1qv+kdVxpbQhcncwdUoq8NEMvpg
	 GsA99TtoDNVUUJkNiaTu0iK6WqvZbLsfAFtfvB7NAQN8u5v+noiyDuKbzOV4cjhrIx
	 5gvreclSU5RRkThl//9p0ISdGZ4Ez8oxHBYF9GFYF5nCyI48v0EEVzoyLH/E/ljReF
	 /rgLBOsIWqdMKRC/Rmzh3twBLOzqY3fecrXBm48DjYhMOYuLDYbtuL77pkL5Vnkw5F
	 KNrkiQhDQSE3RoZMgRnqEsPfQb0suB2l4ungCHjyQpUPePOjod2bG6YrcsVbqsvvjf
	 mN46GeXjPV8Eg==
Message-ID: <sashiko-outbox-203940@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/4] mm/damon/ops-common: implement
 DAMON_FILTER_TYPE_ACTIVE operation
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261108191615.113362-3-sj@kernel.org>
References: <20261108191615.113362-1-sj@kernel.org>
 <20261108191615.113362-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 19:21:26 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Implement DAMON_FILTER_TYPE_ACTIVE operation.  Use folio_test_active()
> to show if the folio of the given memory is on an active LRU list.  The
> implementation is made on ops-common, so both vaddr and paddr gain the
> support of the filter type.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108191615.1133=
62-1-sj@kernel.org?part=3D2

