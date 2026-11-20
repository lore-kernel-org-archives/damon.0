Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795198967;
	b=zYsf/E4zKggyYSHsZlFU/eKcBeNdtBxz4IgewQPnEpzhjgyDpS66CQBALucCx2Qxeyeb
	 r9rEhLa8RjndNIsptZCSebh04bRMTrYQH/pSD4lbgts9yrHBDVt5/dgWIPsYaVK/Y7HHQ
	 xKStwS3MXaDvatvTrmwLQJqD2TvjyDuRyZ5mFQpl5iyZoscdsJY688ICNZimeA9NRsUHy
	 etjZsLpKb6Mt9eMwXdPIgi2n2fBwoQV8JWcPisKprn2/jeXgjAUnfW0r1ZUEzA8byScvP
	 WjY0ysAt9ywVxrG+zMBcLsZrR80PhanL7kG9PAhVAIeiHYnDa5XqR1B76HfUBgwjiOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198967;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5a6bJc8GkfRGLg8FVNGvZndU7Y9faJsrBRzTZLffP8M=;
	b=yxlbVZrBdnlqjKuE8d4GFNUMQVZrrkTCz6BRwlAWi5CiGFHxOypcO0LGEKSgnSCa/mCR
	 Cq07L4M0kxQoo8v0SwJrMPbEk9u+3trzGoNDQYC9cm8JIEOTbLQLOFDM/RVzmVp4fk++D
	 ZubNNPLQ+SoV6t1Dl/i8uHuqnfEuKpu3X4tbrPcvOebuTcnAHwFFcJ4LGylrm+WGBu9tL
	 +AesvZOhEiZCru3y7YSINsZRtect13kuYt2QE1pyjM3k5QYUf0tMCwgiCKNQVDx16P5j4
	 NzecIUxT5kP+Q7KCchwTuSpsNECgHaLxNvTTVwK81qbLeYN43ILi8L7iXgiWokLKsDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Rvf/xzDg";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC459606A336
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 18:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rvf/xzDg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FDCF1F000E1;
	Fri, 20 Nov 2026 18:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795198967;
	bh=5a6bJc8GkfRGLg8FVNGvZndU7Y9faJsrBRzTZLffP8M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rvf/xzDgf/mURah5hUdthIx6+EMAdKtDGpR1TNCdBZXrYX0+6Fp7mcjRcWxk4ijIh
	 /1pjJUFdBfFQDNsNRyxCD+qysChraSAOK4XqGx/3L2doF+HZ1mh4X8Vxi3a30gTFuC
	 NqJ8KL1DQosV6YUUL3BmRifUnHU4AAabJM1Q3lhx6iHkYV0Z0TLaJSRstDWWxH2MPq
	 DzpJC5O3WRMlkOmm0y5jxOdfT1WmhtlZoaCZbUxdIoGe+RamZJla7SfIiKaMBpMUkK
	 lvsyWJOo4HFcjT7pWOYVt+ySm+3LbF+1vpcEi/jGT4Op6cTQ8IsOHlPK83dKebjjkV
	 KGb+6kJWU57zQ==
Message-ID: <sashiko-outbox-225815@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/60] mm/mempolicy: keep interleave and tmpfs mount
 policies on common memory
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20261120-private_nodes_v6-v1-5-74f5f9a115c2@gourry.net>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-5-74f5f9a115c2@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:22:46 +0000
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
> Use N_MEMORY_COMMON for boot mempolicy calculations and their per-node
> sysfs entries (weighted interleave weights).
>=20
> Restrict the node set mpol_set_nodemask() applies to set_mempolicy()
> and mbind() masks to N_MEMORY_COMMON nodes.
>=20
> A tmpfs mpol=3D nodelist must name only N_MEMORY_COMMON nodes, and an
> interleave policy without a nodelist defaults to them.
>=20
> Later when an N_MEMORY node is omitted from the N_MEMORY_COMMON set,
> they will be stripped from mempolicy nodemasks as they're not eligible
> (similar to memoryless nodes today).
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-private_no=
des_v6-v1-0-74f5f9a115c2@gourry.net?part=3D5

