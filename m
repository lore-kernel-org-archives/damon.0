Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795199062;
	b=WQWkqvz3P2PMlVIyxk+OWPCiRWcJkWiNeBoFEw0ennLhYO7K5+OHUK3x3trBJWT6V5QN
	 fT1FcjEVAh4GTfZFcF+I7hbLiLxIBtJT3uWTb5C7z9TlRfRx4l6amR5jCEvzHRu2qCvBO
	 vzSTSih4orFJfiYr6papb0GRiELMaLJPqt+xiJflLifEjHOL3ESOjpMsTHt+C/3zms6Om
	 9geccSbpMRnpxzmEW+IRtJExhrAvNgA2Pgf+9fZylS6yLat7/2K5RJ/0G14J2iJb80luO
	 dlxakKHHJeNKJ0ZD8iIFNjI1Mx0WhIllJw3Syq0EJVTyleXsQtULSGMd+sHh0W+HvRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795199062;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vY9ZTYlJ1BSkMcwFhSpWNkpnjK7JWXQDk0Xnpgo4fPk=;
	b=F7ypjjkPJxenO6e0tWSADT8iHER8CrOBE0FTEXt7M8K1JV8ujiTiZXo0c42VdsFKIvCH
	 dgy0SnM6ldgFVdbAX46O1Td7m5cRO2miyx4WU0x7Lj/J8LzO8NSTrRLzV2GMwCx/odEfJ
	 07N1KasbygAA7l7nwf0WuF9SplAiCN4FnwOLE8C3Sw9FwpNc4QaRAygj15JxCZZCSTvHq
	 lmAuhLDYtbSmJzRyTXGk4H9E8gqbJv2BJiAiPYUU9a6dzDJ+GggUvmX8AyHKnIloo9D/8
	 VHD8/TNYQzwC8i6OTmPzMcZUDYw/YAHnuW48AX053AwS9oU0U9hCtvser3SAaWny+Hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lj+Nu3hV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531D5606A320
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 18:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lj+Nu3hV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E811F000C0;
	Fri, 20 Nov 2026 18:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795199061;
	bh=vY9ZTYlJ1BSkMcwFhSpWNkpnjK7JWXQDk0Xnpgo4fPk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lj+Nu3hVg1LeY2v/9ETo7KE1xGOhsT2XBsWNARPcDjrqLhgAgsbAj5bkACnCqltoa
	 AfELcKpiTsMZp55L0yZ1zElgS2A53NoAH85uWm6YfRcaauz2qOmmrwnERcwiKlH4vC
	 eXzm265e59u+PeMRZM/InW1LrhpIQAl0KoT83XpdUXQB6Mf5rj3XBCXF3HTNNZWo84
	 BnO8ybj4t/eVPHr2pQ1lJoU6cMY+GmrzlGAbSvVsbzBNyCJGYUZh4W6giuBz95XJ12
	 w36w7NRPy9wSmHyYMbtdJjLNTDctbR0FdMo4XHtwZj2sVB8oSB1/hWOkikT9gShtHe
	 9K93Bd8wonMmA==
Message-ID: <sashiko-outbox-225819@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 28/60] mm: select memory features per node
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20261120-private_nodes_v6-v1-28-74f5f9a115c2@gourry.net>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-28-74f5f9a115c2@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:24:21 +0000
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
> Whether a node's memory is common or private is a property of the
> memory, so record it per node.
>=20
> Add a per-node memory feature mask (pgdat->memory_features) with a
> single bit for common memory. Node states are published from the node's
> features at boot and when memory is onlined. A node without the common
> bit joins N_MEMORY_PRIVATE.
>=20
> Ordinary System RAM carries every feature. Without NUMA, node 0 holds
> all memory, so a mask without common memory is invalid.
>=20
> Every node keeps the default mask, so all memory remains common.
>=20
> Suggested-by: Dan J Williams <djbw@kernel.org>
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-private_no=
des_v6-v1-0-74f5f9a115c2@gourry.net?part=3D28

