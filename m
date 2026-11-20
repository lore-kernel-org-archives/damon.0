Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795199049;
	b=rgDK2sBT+2RcEeYrLEcLK/lY5f99QTul04WX3Q/cOdniqFhs0ys6QJlr2pZLocvdafg8
	 DZZrwI+rmCA5ttuqS1ulpM06/XrwAj2wv4Z9n1OJq8MEGqGfzdRapZW68aj33OQIXnl1b
	 zz0rrRg8sJEbE/iAxk3hsWUfBe6z/zKKPZZHdLHMyFF0Abc+6JcUX5o7NiyKvLTLqwNVK
	 FUlsw5DVmIiuEyN09R+6BnVRjCCMRTnDNltYq475U37PVhxYJT5o8D+wqOZZPIk4ked65
	 gY+n9DC0wsE5oh8QCb5EVzrIwVvgCP50+UdAh77pvbYGRMSB32L7xH/3L5/VCrA4nRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795199049;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=llF43v0SRvNM4rUOriSENiVFAisy3dZgcBRO0KDUJb8=;
	b=eqcY88zTKpdF7NiLGYnffsYo9keZ5avhGkbNfUbKKDsC/QDvgvtBaB/xn2ChHv0CwTuE
	 X9jrhHDgeWkvO38zFyjVTb08vdNZqMgiUfx3d7dsubc6sZOdHKjIDlGMTMDFSEP+EsJ/3
	 sfSUmqiK6tvKJWu2HDIkVsI90jmT7zmzHkRzcQZd3pdSDEkpBV5xPdMT7Syfa3+/br8bQ
	 7Ksh3UewRyc6jI69a9Li9zEWVUqkk+Rvl8WZVAJ01bDXoiAQ/+mbKhn/w4Kva/E9pm4h/
	 NEmI61SbOsWhZxMNpKyRldfXQq9Z2Wm04qeUEQVeMu5TQmmIbaKA9kzlFrNkA3Iqzsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z89bPUuL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52A8606A32A
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 18:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z89bPUuL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F8791F000C4;
	Fri, 20 Nov 2026 18:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795199049;
	bh=llF43v0SRvNM4rUOriSENiVFAisy3dZgcBRO0KDUJb8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z89bPUuLlX0K7vbBAk4g724vLrK2fG/xwkahNwzqr3dktGyzINltwrPv2sFvSShsm
	 EfWSAcBtOqMKIDldPO62T0RxdTKX4dSSD4wBxYTSslFQCi8Z+PvOuqZRLmoNaUcG7W
	 /V8DuOc05v3uDQxcYVuqt61tGKAYk5HSh5h74mGt+26myjBQNjPcnSTsQODsyLqmEM
	 MGLmbBpeKMB/ShyeyCFURWaSqToz0fZH4ilzf0fsBd1yxaz0UNFZlnkX7nYevwc4zx
	 qybUq1xciG+EilsdCF7/e09h9FwdL2EFErtwjSUVLuC53KzBUbrxCpHnwF+gKEPTzh
	 2GrsmiNh83cZg==
Message-ID: <sashiko-outbox-225816@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 38/60] mm/page_alloc: refuse contiguous allocation from
 private memory
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20261120-private_nodes_v6-v1-38-74f5f9a115c2@gourry.net>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-38-74f5f9a115c2@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:24:08 +0000
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
> Exact-PFN contiguous allocation bypasses the zonelists and can invoke
> compaction and reclaim.
>=20
> Reject a range on a private node with -EPERM before isolating any pages,
> and document the error.
>=20
> If a user of private ranges shows up, alloc_contig_range() can grow an
> ACR flag or an exported api for private allocations.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-private_no=
des_v6-v1-0-74f5f9a115c2@gourry.net?part=3D38

