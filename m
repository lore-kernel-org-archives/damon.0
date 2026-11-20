Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795199477;
	b=Pv26hKgFfss6kC8x5J5pOoCKvoWYlNBtG9xjhZw+0u67n5/J/11HVv9h3FMIytBDrTC3
	 /95C8t2+FigW0eTPVCaUqnWpxnHpnKae5aVs8nFO3WKu3HdHudDqDqayTmPiGb9wUJcwD
	 3lT2WKGgvtHxudimXDpsD6+AzfCmHYsFMVEwNotqQbmGUIYuTfbxCedUmeSXhflBh+ni2
	 oNYbzFRZd4X4s7zXcOGpZ0bvfKnAuM+GqwTL41FzciE1K+zwyDqILOB0n/kK41TbNv11m
	 CRb3gJyCIJjhoecM7OY4gthrfBlIBcmL0IzLFJL+jtPsoBfrxPR5OQEzKYYLUkuWxOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795199477;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zsr07vs5zGi7D9PTJJLtTDwXfnQX/JzFGBNGRzrAGUQ=;
	b=4lEpIfT0rUZ/AFkkrz08kuPXIQ5J9kznbFDIYEAhu2zdtTNVE2XRxVVsA0is0KAiNZ8N
	 dtg8PMsilP6W/4uOzxnXiuO6xdRcSui7bTsIjdPOubLSl1qR0joME0WWHDjQ94mrdN0YV
	 0yCTW0K357bum9U0kOM5ik+PDxqOhFj+bT3IkcY7aJiC94jEPYz3ImSzCLNYit90TXoOQ
	 sUiqBGrOeEBACVzL0V48w2GCOd2lhkaUY5R+uKYE0FpB88PnO/PL/1V7kNYSomFSDraEZ
	 xxvqm5cRC1/OfYtmGwM/lYD37ojJEWYuxwnX/ki4BbuU9Yvo5PzNUNmZBSPJAy/RnHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k2LICxXg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583C9606A32C
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 18:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k2LICxXg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71111F000C0;
	Fri, 20 Nov 2026 18:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795199476;
	bh=zsr07vs5zGi7D9PTJJLtTDwXfnQX/JzFGBNGRzrAGUQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k2LICxXgn0AX2nuImy3aCX2vnh2AR4/h0N99cEKhFc8ev8Ro9ojJkVlFTg0ac/qrm
	 uqkqhmXsSz04pa+GfcuTopZ4DhJ6CtR3v1aMiDqd6EqLOSUPvSiE3XpE6ENdQyLj+W
	 P9Zg1+RBYWegD0L0JUxVDQDFxgT8AwYSMnfihUBN+/15U6cqYc0N8dgbY5SaP19m6i
	 XFiVxR9uA6Odva/WpJMaL8LpP1538jp9SLvDBhP8jnYgDJw6iWEkvxUZoAXiovxFVO
	 PXNbMdc55OXPh+6QCiR1i09PKmZd4TUtImT/7jFRS/+SARHvhY/j5HoyH5Qa9Hsris
	 x2DEEp5ukAQUg==
Message-ID: <sashiko-outbox-225835@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 56/60] dax/kmem: add a private memory mode
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20261120-private_nodes_v6-v1-56-74f5f9a115c2@gourry.net>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-56-74f5f9a115c2@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:31:16 +0000
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
> Add a `private` boolean sysfs attribute, defaulting to false and
> changeable only while memory is unplugged.
>=20
> When true, dax/kmem onlines the node as private memory with
> NODE_MEMORY_FEAT_MEMPOLICY, NODE_MEMORY_FEAT_RECLAIM and
> NODE_MEMORY_FEAT_COMPACTION.
>=20
> Userspace targets private capacity via single-node MPOL_F_PRIVATE_NODES
> bindings on anonymous and shmem-backed mappings. Reclaim and compaction
> manage the memory, and the system does not otherwise use it.
>=20
> The attribute is hidden without CONFIG_NUMA or CONFIG_MEMORY_HOTREMOVE,
> since selecting private mode requires unplugging the memory first, and
> the default behavior of dax/kmem probe creates the memory blocks (an
> unfortunately backward compatibility wart).
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-private_no=
des_v6-v1-0-74f5f9a115c2@gourry.net?part=3D56

