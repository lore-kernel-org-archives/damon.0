Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795199464;
	b=LL+nb1jxlGFMlv2w5HSFYN2aIAv29G7AC+NFtXTB1In0+lM7oWLX6IjiGT8IzvHCSnaV
	 0vOVlq4tSRM97448bOqVF9kAy/JV2jGZCrEHam5wX77H9A+QB8kiv8zgbz6KR1tfgCjym
	 vYViTdjTytuIPZC/BQE2XU+bkUOnrC9XYmoeyOsZRD3EVJnAlqH2nxug99tKYWed5YKGp
	 BjLitKkgrgQoujAWK3lkxewKU7gqcmsIvKyg42boJbXJ1M0xHwB7CdgO85725jTjPSY/E
	 2W/wrLsk6LhNKuDfXAcYxCaR36L4GENqWeXuCWb0ADW6nGmt1E9mD89HFJZly8IPpMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795199464;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HMcPFCijt7qsaJWb5uMyLEMimeITr61Km6BOi3RBSQQ=;
	b=tc6fDiOe23d+0HwgmAS+5oK0hZGIsE/D1ixUVL/Bx/Hvdkj35RG00Uj0maYzUbv/ifdH
	 WJwGuBFQsGBn67TqE3pjy6kncJUkQf/kOrg7XYZadIsEu1olPfIfRq/57MyfL1uBNGXGa
	 ZGzU3jVkEy7lQcsy4+S7FElLEKVIhMqbb9idfT49sK/FeUpruKdHIolD7YpvKAeqWOdnq
	 0ClcMExJygeeQH4iMQukgJQz77yU6pLuVw7HqiqAtA9maG+liUh+3Mj3gy9/70L+QIRlh
	 IYFE+szomlPtB0f7gZAKpNR0OFIyrZ1BVbGRvNa6HHygHXVFLOmnUxZ+V3LlXHa5Bng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CS6Fj6kf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD0E606A320
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 18:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CS6Fj6kf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B861F000CF;
	Fri, 20 Nov 2026 18:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795199463;
	bh=HMcPFCijt7qsaJWb5uMyLEMimeITr61Km6BOi3RBSQQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CS6Fj6kfZZWE4Eg+R4MgUpdyWjUIbX1JberHIy8NHNGXESUT7wBL0MbF6apGgsz5R
	 skCDnnFpfq7pIzCPZy8PNMm56KDZvDFUnI16+ln2e+SZR6PXn7UcwMnil1MTTbgS0c
	 FQI2T10jHiQBFYwKcDLw3nvEoh1/KTc1gJ6f/lrD/ScOHYmcceP2prwNv+Nk/rwBgV
	 228ghYmSMeYj1aUaqJdCjlb4Pfgi11WGQB1jGbx32UQok0Nh9jnJ95n/T0TsOAB+Ak
	 9zotmWyQXtFQv8AFftxUIcr3X6tPYxJm42yjZCA3up/MJCkcIIDcIx+MWZF2lAMA/4
	 Da8HlF/2rmCxw==
Message-ID: <sashiko-outbox-225832@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 60/60] Documentation/mm: describe private memory nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20261120-private_nodes_v6-v1-60-74f5f9a115c2@gourry.net>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-60-74f5f9a115c2@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:31:03 +0000
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
> Add Documentation/mm/numa_private_nodes.rst for administrators,
> covering:
>   - creating a private node with dax kmem private mode.
>   - binding memory to it with MPOL_F_PRIVATE_NODES, and explicit
>     migration.
>   - controlling access with cpusets.
>   - what happens when the node becomes unavailable or full.
>   - shared memory placement.
>   - which memory management services apply, and how memory counters
>     account private memory.
>=20
> In both cgroup guides, document that cpuset memory migration never
> targets a private node and moves pages off one only when the cpuset no
> longer allows it. Document how a private-only cpuset.mems gains the
> parent's common memory nodes in v2, and is rejected in v1.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-private_no=
des_v6-v1-0-74f5f9a115c2@gourry.net?part=3D60

