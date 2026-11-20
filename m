Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795199540;
	b=Jmvmqs0j2Tp3tq1Wz+CMKzmz4HjMroaQSd0q0JAsh9F4gQMLld1fzQx0kRSTzXzXIIXG
	 x25r9WmkIZ4vuJb18aNUT7/3w37CIIoOPOGmd3OQQGqc/HofTVB9qcGCpTwdBzptzUGoU
	 eswHWSCfXFpRxUFvcpg02o5dP+bBBLwwR6Yhv1woa803CB+XrkW4gpiUZJ6gQrepg5mzu
	 qsKw1p6ecEEhWscbYqXX7EPcxP9fx1hwn9UQgPz0qbxiA9c7xVnmV8UitvzvuDya4e3+g
	 gaWHSvfBZiPLS99Yk0xgg2zxHVQnnnW7GW8JCoyrodZFas2D5hdnI1CuB+PlNyn74sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795199540;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IwMNSEzGsP3PKNHxri+6TBae8F/K/tDvXYmRU2CYj1M=;
	b=p9k0yoR0mQu7Gbmo88q8QlKnrVRKjdHbxyKVMVWjZABgv1iVnxqvx+g/TqqCiA2XRa8i
	 iABIlgcfTdq9MXHIVmAK+Js6UGXP9Lwn3GZr9JDiOTMt9vl3U0e5Nxo245excXCeq3C/L
	 QCLFVl1jKUGzaEnUgLs76mlLwk1VNAMziQytRmrohWTzQSUwxTOE320rtyltn9yOL7TO6
	 wnGRu+DOVk0TjFapOaFTDvuKBLBoYKwB3mOeSd8VAFIfGy1+HfEUezhXSD16hvVJcAQOe
	 0WzNY+8iwPFddfEDQWECrcPVvlF28SpUxmevLuz3gF5MmFx8z9aMPSOf2Zhf+BKvBSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=asybrZGM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7030A60A2614
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 18:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=asybrZGM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C5B1F01565;
	Fri, 20 Nov 2026 18:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795199540;
	bh=IwMNSEzGsP3PKNHxri+6TBae8F/K/tDvXYmRU2CYj1M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=asybrZGMup9pKzDgWDfxbFrsTjVso5Eev4K2w27vVSMZ1ER71f5S6aY/uR55lCDZu
	 NevcYq4H+SfDfrcgFXxtRZV6LyVxmd5LtmgNz1gnx3ZbwSsQpfc/5IZb1OrALXWh8k
	 zEdpEeo2BwfR6CNfMqaLp70mEBRuhvjCBnax42N0z0hZxQ6FxwgEADUOSN/+GVqBLC
	 QaxBSvrfc6FfT+3Ik6ckUhFvA2UadtSWXSllYmfObb/09J3Roru3oJitWHP9Y51u38
	 QbwS8Zw8Sn1DWKrKMqD9z5zOjmzLBzSL38X2wa11EF3DnNpon6DtV6C3u6S1ZKoXEC
	 cf1QfbSUP/32A==
Message-ID: <sashiko-outbox-225839@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 41/60] mm/page_alloc: relax a private request whose node
 becomes ineligible
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20261120-private_nodes_v6-v1-41-74f5f9a115c2@gourry.net>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-41-74f5f9a115c2@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:32:19 +0000
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
> A private request allocates only from its node's private zonelist. If
> the cpuset revokes the node, or memory hotplug removes it, the request
> has nowhere left to allocate, and a faulting task retries forever.
>=20
> An ordinary bind policy does not hit this. A cpuset change rebinds it,
> and check_retry_cpuset() drops a nodemask that no longer intersects the
> cpuset. A private binding is never rebound, and dropping its nodemask
> does not help, since the private zonelist still holds only its node.
>=20
> Add relax_private_alloc() as the last of the slowpath retry checks.
> When no node in a private request's zonelist is in its nodemask and
> allowed by the cpuset, it drops ALLOC_ZONELIST_PRIVATE and the nodemask
> and switches to the common zonelist of the preferred node, which
> alloc_context now records. It runs after check_retry_cpuset() and
> check_retry_zonelist(), so a concurrent update retries with the original
> constraints instead.
>=20
> A node counts in any zone type, so a GFP zone restriction or an
> exhausted node never relaxes a request. A __GFP_THISNODE private request
> is never relaxed. check_retry_cpuset() leaves a private request's
> nodemask alone.
>=20
> The alloc_context comment now lists nodemask and alloc_flags among the
> fields the slowpath may change.
>=20
> Without private nodes, the slowpath retry checks are unchanged.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-private_no=
des_v6-v1-0-74f5f9a115c2@gourry.net?part=3D41

