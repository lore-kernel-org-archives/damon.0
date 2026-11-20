Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795199649;
	b=CMT7mdzrFUfKHWanPYsVKM1E4f3KdscJ37s8rkmFeRhtpje3RFumiOlOu9qC730kmkYp
	 tjgWdbOaxaH+HHNR5Tuu8K9mr4GZcOi70674qGhRLi0gWSoi6h4G91CBp5ElJDPYmN6Vf
	 g6V4hb6Br9uFFmYr8njvK4Lbrlus57eaqkwITee8olRZoAlCYRkPYGgtMlFVpSBea5Gxu
	 v04q5dVv2FpElE0mUSYy0LXXkRKbEkG5SKWM5uGMOk/FOJtro89saz5y3nXGgo0K+FLJA
	 2dYoN+KmUQMPvktgv+5P2nwE2qaNGQ16elKzxzHbE5CFUHkHi4rE7fgw4Lel42rRY0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795199649;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hMc8ZsnHwbR6zPsdomY/0+RjXTomfVOJV+z0atJpffw=;
	b=5l/hzo0RbKchafw8ytHEIlxRvAad673H1gA5oMNQ7fpvpzl7rOPxCGPR+Ap2HfpkUj8E
	 jxfQTJNYEwynAjcN/68xnNvEDxyFopYCe1Y7x0so1083uWyJS43lYJ5JHDoujrNMhi3+C
	 RzKQv1/SyQ/16RhIw4z69DVauVdPh7JYnsUzuJ11fGAEKVl5GxRwqwK3V4HOju5l09Tgv
	 tzPk+W9Xsp614SI8YIbGr0YyiIkEfHV5aIKgL6OxSQ6iPRmtlz52RVfNlmFVj3aeOYhVL
	 Ajt232fhefwkHru4WH0O13Z1CoykQ2XnXeLLCO3i7C9JsMOA4o9YGE27Ti1mT8qkdvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iu9KRAz3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF34760A2605
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 18:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iu9KRAz3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189C81F000C0;
	Fri, 20 Nov 2026 18:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795199649;
	bh=hMc8ZsnHwbR6zPsdomY/0+RjXTomfVOJV+z0atJpffw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Iu9KRAz370YSKx0fe5hBb2abBIo5vJX5PAkUaKptIEEqi5DW6mkTkx7Or8LNnpKln
	 5myd89Z2tUdjqjjL0EAuA0rBNZIyKUkcPqxik6xBeKsAUCCk0rBmmjUkrWWFaVDXdK
	 Q3HcvFJ+x+c0LBgYi+1HmJgeWIxGTvYHc/EHGbSJhlRdslMamrmzxXvyEL+t6u55lq
	 ZVNrMxN4TtDNqaGpYmVAWMDyH099bTfwDy5EJ/L45bP8k82wZKjFo/hvdI8RY7jnKv
	 5SBBltmkWMeoa8R5DcYXWw1FfFU2m+eaR/z958NWecseHeO0m4nruorIeFLinglkJm
	 GOqdJ1pXVdyxQ==
Message-ID: <sashiko-outbox-225844@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 55/60] mm/memory_hotplug: online and offline private
 memory nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20261120-private_nodes_v6-v1-55-74f5f9a115c2@gourry.net>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-55-74f5f9a115c2@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:34:08 +0000
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
> Allow a driver to hotplug memory onto a private node at runtime.
>=20
> Pass a feature mask through driver-managed hotplug, and reject masks
> that node_memory_features_valid() refuses.
>=20
> Memory joins a node only with the same mask. The node's features hold
> while any System RAM block remains (including offline blocks), and are
> reset after the last one is removed, even when ZONE_DEVICE memory keeps
> the node alive.
>=20
> dax/kmem and the other hotplug callers pass NODE_MEMORY_FEAT_ALL, which
> registers the node as N_MEMORY_COMMON.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-private_no=
des_v6-v1-0-74f5f9a115c2@gourry.net?part=3D55

