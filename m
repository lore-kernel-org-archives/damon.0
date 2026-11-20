Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795199089;
	b=tIMw5oLbcaUlf9VjWARvajUaj3OUzZmxNicCq/+1XzABzOnQ/QD1dfcXeiPGAl3sXuiy
	 pp/67HL53BZiK5uGR0J3O0ryOpoU1xnC51AqYpGhHkPkdqydii1/VB4yNJRPpy1+ctBum
	 WhMtVXwfKHzshBz9+d6pcgSZVZ3H3ghFa4vX0GBd7Qc959etOETcQYy0K62LRVV3mHkR8
	 21vZFCJKZtmkFcsgV7WX9T3TKTumfVPvtRlMvbNTRTTNzThXyqvZFUAGib1813R3OLXci
	 eCRnJfjExkjXsfdlyG484f45s3UqY/sO+0lLBXrchsYiQ+OsfGE8ThSPXkYdeIJkP8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795199089;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RzF2SQSFFPIb5q6adrS5I4YRn7lmw1ohVVi2L1dxm0g=;
	b=1vIqrPA/5elSyHX4ZZtzYKO5zA0xookFiMeX54zPtvtUvUWbC1yEG1zCNa49AWdVj3XL
	 Ee629mtyRsIJzh6VIosJPCzrnsu2hRiFUxqAUfyU9/bFLVGLg9LPUyTMLJgShfQYhVBrL
	 w7BDiGPmxl9SX4VqJEkh1+IQxLTaOrv4RCzlTAwSZJ2z7XxWhiWJjST4QfD7MLgKUMnCi
	 wTRF/qOqR8zlWswwSYd1Tfg/5dyTKJgdxnGXvcJPyXnZ/wVSbS0GBEOxSAL8UgqZLPmG3
	 i+YKZ0NXenq+j7S4iceClsPlIYWsLglVOf/oV0cFda9Ue5KuaTS883RypkEdVBL5d2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DzPeUQ2+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800BF606A332
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 18:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DzPeUQ2+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F121F000C0;
	Fri, 20 Nov 2026 18:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795199088;
	bh=RzF2SQSFFPIb5q6adrS5I4YRn7lmw1ohVVi2L1dxm0g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DzPeUQ2+edoeA2I9Pvkvpji/nhfXQSQgfkgh6EE46Ij6gKJQrRzeZUXpEFFh0QVP0
	 sTJw7SHdeOTfGZ8p+QumZAg2a0l6L7y1kY8mw+SZvbkoE1q/VqWGvd2Enjisq1OQP5
	 UdZUK+xZzj4nGd2TolIQuMMQpCQzv+ca1LzR6V5Q9cV+xXMAIf+TJC3x4rpWvKb7YG
	 UeXnOqrgK0CpDUoDw+iwSD66ZkGPP+yjf2Ps/y/QWuAma8FCjeh5d8TGOfhLfbNLd5
	 8kQzbmYGvr0BULXnTUFJg78MsamGTQV8ejVDbvhhM9DRWQPOZb8rb4ODOgqe0E7Ebd
	 eTpXX8/71B8zQ==
Message-ID: <sashiko-outbox-225821@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 44/60] mm: add N_MEMORY_COMPACTION node state
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20261120-private_nodes_v6-v1-44-74f5f9a115c2@gourry.net>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-44-74f5f9a115c2@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:24:48 +0000
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
> Add N_MEMORY_COMPACTION for the nodes compaction may operate on, and
> NODE_MEMORY_FEAT_COMPACTION for memory providers to select it.
>=20
> Common memory carries every feature, so a mask with
> NODE_MEMORY_FEAT_COMMON must now include compaction.
>=20
> The state is internal and has no sysfs file. Internal states follow
> N_GENERIC_INITIATOR, so check sysfs coverage only for the states up to
> it.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-private_no=
des_v6-v1-0-74f5f9a115c2@gourry.net?part=3D44

