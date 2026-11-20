Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795198840;
	b=dY3CBfLwqxSKAnupd5eqI1JllHsMJHQqq/K09Bxr7uP1GaRwaduNXXMixv0Y9Em6rjL4
	 O7J7vecScj6APaEBqcMFlR/E8I8BGg0IGu/th5q7Ljqb3vpQvbaaXHzdLMDoaA2TfiTrq
	 OsiI/zw35WOLeL4MpcM1zz74Q0qImyFdJ467xqY+a1VhIbHAaNJibyKRP+RBrUOtdLMLo
	 hYnvxrl9FQ5wJP6+5heG1SKYTPNBk/ygMhQYT/A7Cr/rU/r16ngJCcHZvQQa/34v25Bif
	 O7nvV/7e6XYeeVo/lYp3X9x0bOLujmC1FDvWZM7PTosDqnjXIHBvd9a3xt/7T9I3G5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198840;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=J5V0osgR2d1nCf2cmsmNtsRaQazu5z7sA1DP66w6SKY=;
	b=sfQFg+XP3sHynUZoIKDHB0vd2VmIbhH7afjevCBob7qMAmC9lgdfjdGAq/qGN3751SQh
	 cN346uyYeR7BNU4Y51eUjXZxHM9VDn6gTq8EpTRkfgPy7w/AAlGs+rAbL+cKkeqxhxNkA
	 WqkDJ4f/aCx7DThk2o0Y8R9p+lWGsaCs2xA4+bFq83Iu7SaFUUxSJyUtiEF+cACMdqpGG
	 EfVaXacY4ixmz5RSzegsfZoKUH8O9kpkUmI6cMrzyUIxExJp/G063s9WgCBtQxkq3gXyj
	 g0SihKobSTlJ9MYZc+iLG1szMRfUdd6HRgDGpYV5A/qDOUl6OpEVAXFPPmlSuU7ZlKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RFayNt6T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40678606A8AB
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 18:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RFayNt6T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A5E1F000CF;
	Fri, 20 Nov 2026 18:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795198839;
	bh=J5V0osgR2d1nCf2cmsmNtsRaQazu5z7sA1DP66w6SKY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RFayNt6T0kU+B1rUdKG0m4iZi1Acimjbzje0awGUK2XeVU6piHyhiSLzud7W6DIX+
	 8hS2bpUrgUmpdQrFVy2QAKmTL1tFq5BulWGybAvcLQKNr9iCx5hT2lRdphlC7OQ5jm
	 lN8xUnUT/wNrtXOsxR0p7eHss0R6LrCAbXn2V/QuYZnexlJxkoPXCbIVrqdNnbthJU
	 cq3g14JOYpYS/cmLAh6w6v0kocTc7Aa+IpIqMLxi3lJcMacnaG8of6KHJjHRLXUZe0
	 /MM/ntHzTiQHVgrYgfK1FwSijkRnZSVfoojz09Mzd1VvKsrDViCpEekcGIQwEjmbOt
	 2sH4WjvMHybPA==
Message-ID: <sashiko-outbox-225806@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/60] nodemask: add node-state iterators
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20261120-private_nodes_v6-v1-1-74f5f9a115c2@gourry.net>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-1-74f5f9a115c2@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:20:39 +0000
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
> Add first_node_state() and next_node_state(), so callers can walk any
> node state the way first_memory_node and next_memory_node walk N_MEMORY.
>=20
> Add for_each_node_mask_state(), which iterates a nodemask intersected
> with a node state using the bitmap intersection helpers, without a
> temporary nodemask.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-private_no=
des_v6-v1-0-74f5f9a115c2@gourry.net?part=3D1

