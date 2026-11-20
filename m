Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795198813;
	b=lZTNAKKiYUwFgxv9Vqa1nHxfG9Nc/NU/uOhk9IdDmxefKwV7m7ZqtN6U3dJNG4C8nWHb
	 Hj7NQTkAxKoJ45tig2hZnTlvmHIUBZgq0iCv1VokUZFgNQHW3gHwzSQLE3cTJA3ZvzWFJ
	 p05xglEYwjXswVstvkhRpDoP7U8vDdUEgvbEpgUhZA8kl7vEeg8EYCqdgmR6P4mR3OxRW
	 Otd3sTEN0HrYiLH6gY20sbDpRUgBi6LVDyzO7EKJhHMtSKk4wo/60M7yfwXHSgMgKo/tm
	 2V1BSEgrqFfX0LS2phLSADHNxgteaaOZHtDx5Lq3FoHXzpLQ0b0E8X8F5tQQWiR64xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198813;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hn5IPGXE0yhxE3RXnfm8+8icf2aOb9DsZzFZZRFTabE=;
	b=3gLS4cx8uqeWXffrvjy7bFpihxDpAKXv34dCYAb+VDaA0E3NNijUOCdjFLwOmZfspax1
	 ykS8a+vyv7LrduW9vAWmVKRjmeee3biJcbcIx5bh5MG6FEEPIgQd8jtOVHKjbGPvgCfkx
	 xmDY8HYdBnOQCPBEyxdrMUe8KbJ/47P5gz3/LQmaYbxKUpfYnb9vBUpQ+3Xl1QjLlxRvF
	 +L1cVEoPBlRpv1Ti1FDAaVSaP2q99RW+EwfglC0Qzi2/IKqMuOVLNTiSiQXyKnD/Ixq6H
	 cUcepYFFj+82ixokFnBKv9notbNjzN4Da/eLInPMdxLA037ejATHhDT+CD92eL6h+rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HHrGA5oy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD39606A886
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 18:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HHrGA5oy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 607761F000D8;
	Fri, 20 Nov 2026 18:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795198812;
	bh=hn5IPGXE0yhxE3RXnfm8+8icf2aOb9DsZzFZZRFTabE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HHrGA5oyB/kAl25d5Z9kMLA7yY+QipJTRC/pdpw6LWfZvyzlBVPDbA1TQG9V2rV1n
	 ENSbz8+JwsJHNFoR9IP46xRWnyepQE80R6vYdZsuIhKII0sCqagYSj7i/JbBx9hCZM
	 LPwmx4hmMNrss7Iuj7DKDy2waEcCCX7MGn81uaI356U2dbgrykl1CHrMm12SCOILuy
	 MGnqYBj5yNXeNV4SR8JFjAIJe0qwWhCFtBKg8JloL0PsTyOMmcT/dPhfMjHlj4WuJz
	 +umaf8V8zTG78WLqMX0/dKIwoG2N0w93uZHMXzk6O7mbzxmUEw2xK8KkRIGl4GXy7X
	 MPfA2B0CeDNqg==
Message-ID: <sashiko-outbox-225800@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/60] fork: check cached stack locality only on common
 memory nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20261120-private_nodes_v6-v1-11-74f5f9a115c2@gourry.net>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-11-74f5f9a115c2@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:20:12 +0000
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
> try_release_thread_stack_to_cache() caches a freed stack only if all of
> its pages are on the local node, unless the local node has no memory.
>=20
> A CPU on a node outside N_MEMORY_COMMON gets its stacks from other
> nodes, as a CPU on a memoryless node does, so the locality check would
> keep it from ever caching a stack.
>=20
> Skip the check when the local node has no common memory.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-private_no=
des_v6-v1-0-74f5f9a115c2@gourry.net?part=3D11

