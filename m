Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795199116;
	b=dt260AHdGas32lRYKNP5ymDeSY8e1QLyFYaoFhw8Uu/Wnfg+vF6juq2KLcY4c2VOQvY6
	 24u+nXmW5qXKVXur7OlPgsM/7wjpP6muYww1ixoF1BS7AUH1eo8e96ES52EKxIOHXwgTz
	 BfmfRxSPYZlK8DsX7jPcPH93PcHLaYXoWWmPWyBJsuE/0duYOF6ZfwrtyNeFVswc6/eHU
	 p0s7hjvo7Wz5pCrFRHxT2v6aps/gT8MY8Xp1/iOYqfe7nJK5uxcuLTbVayB+kbDzhpWq+
	 F0ispBPxxGv/N4ZJeUQ+ud9sWsI9sFTCLkgDSmZPzte0jNHm6tzdhYQSQXlFVYuZWRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795199116;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TEbM/dE0tXpIdRb6fOF7Zsvi/2MitVUGh/ZM3IaZGMw=;
	b=k7uQ8Op6QegrB06AyyOKnS0aYa/UiHEdTRlGhzNS2zlfJDKqH3cKzPg0m/Yi944zUqqN
	 74JA+TRNyVdLKBq9KExzzyh2tY6vA3PusXWMvDwjzYxxH9ywSBLZko3ddG1dTZxYxwBMr
	 dlj4XYdqXmWw4znOcH6ZBurSeEPGsOoT5zMYEWd05c0LuGzMQAvme4ydgIUMsA3WqFCEz
	 6xb1pLza/eThNtxEIYzLjxAYvMq1HHbqXSlOYVB9gtGwMH2FZ9Zm1H23wAwnV5+4KgneL
	 BNyb+bdCjMYddWQUIj1r9j+loXclkoql1VDYH2uWpiYP994jnw55ULG+krTKUyiTm8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UGNxMS0O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C979606A33B
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 18:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UGNxMS0O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70FA21F000C0;
	Fri, 20 Nov 2026 18:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795199115;
	bh=TEbM/dE0tXpIdRb6fOF7Zsvi/2MitVUGh/ZM3IaZGMw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UGNxMS0OlaeHjkutVLOcRPX/lIUgbwPe/xdo5X8hkDNki31WAGf35nWRQ4e/Y3t4x
	 B1L4mMprGCBn/pV2TmeDqd97xtcQneFBKY49+ywdDr+QCAuDxSjtj3U+DpNftpJGAN
	 uapX6EEs6l7+zzPHCWs2+F+B8Lw/PbYkvZauni88Z8O+vC/pbYJ8ChL3nwrKSZkeXW
	 hBhWv9k6WpWVRqxI6ArJ24Og66ExFeTCG/iI0nYWYzkZtJf14iyAUkF4nczJusIOrL
	 5vI+dF2tnKm3+5WW53qy3DnHDKAwUe8PGQ3duM0r1AFtBm+aeuSpkitapEjKCaU5hv
	 ow1KAMvUdf4qQ==
Message-ID: <sashiko-outbox-225822@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 46/60] mm: add N_MEMORY_RECLAIM node state
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20261120-private_nodes_v6-v1-46-74f5f9a115c2@gourry.net>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-46-74f5f9a115c2@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:25:14 +0000
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
> Add N_MEMORY_RECLAIM as an internal state for the nodes page reclaim
> may operate on, and NODE_MEMORY_FEAT_RECLAIM for memory providers to
> select it.
>=20
> Reclaim frees order-0 pages and leaves high-order requests to
> compaction, so a private node that permits reclaim must permit
> compaction too.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-private_no=
des_v6-v1-0-74f5f9a115c2@gourry.net?part=3D46

