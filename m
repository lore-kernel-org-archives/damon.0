Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795199483;
	b=fIRiMAaeV5GbCqN0HTj2raS4oYrLCoD86v2i7BJzvwj6K0y04zwuzmUgm5knlEiRteqa
	 gf8JSWm4BHRpltqZOCu8gZe+0xo58CAnEiO/gXU1PUQiZg6diOMrdsWnjYk6ywWBVZ+SC
	 JU+Jhzpfb9PbTeykaCzMZDYl0FSKPE2BooRD35++vjaqG35kivnl1abTzEr+e37jAaDVF
	 dSXa9S//tO9rFqhe/8x96md1AcrOn0558ZSNpf8/+VMdXChPbAJl3rp+33EMLi594nGx5
	 NkfjJ7xIyIjJads0Vx+8Y/lPaVGE8HtxAiAKygfguGX2nWxJ0+TMYlolKi2JFR9hEiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795199483;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cOhHOrUxw2LCm4PS3m/Lls07Hk6D+NogvV8VIIlKhFI=;
	b=TpF+rMeTDAKZHfdlWJKKhWmSnsA7O+nNqXL+H82jECKE0zhFEcCCgdnIHVw+6UCzDG0F
	 YWxg9hiBjlumDpqnggHsHhefOUvtS5MMPhIUTcDq+bTspIS3f9lgBp6LK2NjGcciYe48F
	 yyh48kTTLdcKNGN8d0w/d/HZYh2yjQ0HDgbLEjHoC/ysibs3RJw0GGHmpFjaIqf5Urqma
	 NGgv5sOVem4u9SaAqyKWMZJpLakxZgj7akqIbnPEjek7kjRNA1UvRmyevdirwzm8l7G5X
	 6kQoJtkhBnIPjqAcVIqqVoNEAQZFKdBB7fV+g7Hfjk5o0JBStNjLLo4974qy/LKW3iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TR2tTRrL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B278606A331
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 18:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TR2tTRrL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30D01F000D0;
	Fri, 20 Nov 2026 18:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795199482;
	bh=cOhHOrUxw2LCm4PS3m/Lls07Hk6D+NogvV8VIIlKhFI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TR2tTRrLw/QUbk28Z5UCpvfOQ1sLxmpbc/s+drR34G0phOM7meRgt6RcyvrorWcO3
	 /0ZzSO/yJGT3TxxiTXsMZSIULXn6LxpxIpussaTt0EPq7DkFgfj8a8TCEyIsA2UnEx
	 TDSIYiUc9ZO/SgnhU79yxhe2eActnJY3D3k3QLLSKYtJ9ztg2MnZpS8t92KumIAOQ0
	 CvQu06NsZXHc1qkCxYTMPsceXjRJhHGvA4PENp/DgP94GqY7iQHMyPjB1zVqxPYAfs
	 SWUobDDqwOZm03qEfhokYoCaRZVpOVtaeXJ9fRwEMw4cl9vHMpzKSslEA2/C/aOZB/
	 e409W+lNSrjew==
Message-ID: <sashiko-outbox-225836@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 32/60] cgroup/cpuset: keep spread page cache off private
 nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20261120-private_nodes_v6-v1-32-74f5f9a115c2@gourry.net>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-32-74f5f9a115c2@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:31:22 +0000
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
> With memory_spread_page set, cpuset_mem_spread_node() rotates the
> preferred node for page cache over the task's mems_allowed.
>=20
> mems_allowed can include private nodes. A private preferred node will
> fall back to the nearest common node, which takes an extra share.
>=20
> Rotate only over the allowed nodes outside N_MEMORY_PRIVATE. A task's
> mems_allowed always holds common memory, so the loop always terminates.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-private_no=
des_v6-v1-0-74f5f9a115c2@gourry.net?part=3D32

