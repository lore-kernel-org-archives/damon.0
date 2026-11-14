Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640777;
	b=MxYhF6F7TXfkIA75YOZxwC5UocWgKdzLW9iUWaidaSDHABP86Clb0nTEZB5G32ho1k10
	 OpUAXugWODj1NFjt9XCbMRAd3DKlcq3OmG0/CqZGBth/3+SlykuApSsnAc3QqsMJMaJUS
	 6FX83eY21N/ODr29qTECV77xKFZcBVgzTG8XTMaA/3YuqZZaDtIz68je/gWuaq0gFKl8M
	 BgMSELeDNfbx76zO++IsrrYvbZP3PBw8d2Lj63EyreVtSXNh2qJ6TShzlVpoQlhniEvvH
	 EIqNCw8ZH8AgUNjwTSU9sACAXJCW+MV1noA2zE/Ny9ogvUvloFpWvsxxtJL5/U+nKNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640777;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=g/tkwbNyOeHmVDX5uB5zyoGRQNcO7r7mwzqQHoXqwJ4=;
	b=2QD5cfERGr2GirYzzChZSiSjvAIgh0bWmlby0ubqE33Xdn44NspXBgmiZAE0WPL799FU
	 ziV19Xh6hKW/yFeFWhhDrhcYX4wyEPYW/VwRvUDlLm9G+7TWZ3CQT421STWCtEGZpc16u
	 zu2Sq0cvy0CVREUAT19PHmmrTMNhE9Hn+rAVu6ycWNqhsBPPkzqq7BavUrSpWOw0JTDCl
	 Zj+SCBJ7asbaQqZiOZw86Zt/chjXsJefh0WaIgwy7CelKkBfF4DAXt0Pjb4nNYw4Iu+2x
	 3A3ISOGL1pEN5PPdfPK3pGtlzB7NtaMxAjOYTboqr/7QwI5rxiRvLbnKq6lz6h/3qAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JoYpJyUl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A3B606A334;
	Sat, 14 Nov 2026 07:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JoYpJyUl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 936C91F000C4;
	Sat, 14 Nov 2026 07:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794640776;
	bh=g/tkwbNyOeHmVDX5uB5zyoGRQNcO7r7mwzqQHoXqwJ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JoYpJyUl/qnaWsfGxWozRxy3m68GZNJlQOGK65ZLzqiw1n4EfbvHBkXB0wooNoASx
	 Mk44EY9Ta1GhlL/RHzTy3oWK/B5XsIwC2HfhPSE7+kGtNXL3MWhiu9MOjPDLPspLgg
	 x8DsKa68Pl2GzC3Jvthl9+NcSKDzyCKzzlb29tFI3ZWIreNJMYdbu1WognkIlhmxz2
	 6q89yp3ftBaVjpPWsnQadpHlnkw/LdsZHO88Cnt9YUOictjp8KxfS84qMAsh3D9Jt3
	 23qmeV7d/wo2EYiIpT6eTl03AWcYU4AskD5maArCJv2h6+dYnouKIE6oqZa/muG2RR
	 PgffrXWIM5CYA==
Message-ID: <sashiko-outbox-214256@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/22] mm: add node-state-filtered zone and node
 iterators
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: linux-serial@vger.kernel.org, damon@lists.linux.dev
In-Reply-To: <20261114070959.3490008-2-gourry@gourry.net>
References: <20261114070959.3490008-1-gourry@gourry.net>
 <20261114070959.3490008-2-gourry@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 07:19:36 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Add node-state-filter helper functions/macros so MM walkers can select
> their node eligibility explicitly.
>=20
> Add nodemask intersection and nodemask/state iterators using the bitmap
> intersection helpers, without allocating a temporary nodemask.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114070959.3490=
008-1-gourry@gourry.net?part=3D1

