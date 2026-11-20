Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795198801;
	b=4QEnS5GrjtCWVH4LE6HY23eIwmpTTn+eqE6zO/gz6XMwxz/gJYs5eOB7q3p6ad8WxUJn
	 ZNmUHiHJKUQjkXwnE6j0t9muCeneJ/diIYMBkzSUHzNhu9XTEoWRqbZQ38aHP38miVB+T
	 gVd0giNhHbmU+y6KVn4Z6WZAszULW5zALwFvQVZEUgVNQrTlHmw+SlyNgA8/CLsZGls/K
	 40MJzGncEXXOz4sBQYSIuGQd12VTQwEeIdAQh2tiJZ1egG4qjACpwuQ2+2uCsF17CgqIp
	 MHBmNZAvAGxLe+xK9fI5YZzU73UP8dfJWYkg0Hh80/8nVI+lfyo0mATauKE5Q/20ASA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198801;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uqx3or1h1h4L9qX4ItYti3lGyG1BLDV+xnFoQdBmN2Q=;
	b=zhzDhw3yPjAbJR7S9bnzcj0dgOVb6GBy2dDcpfKvCSi+bmGJnqoVoaIAEELOlhP1/d8o
	 MP9jq2Wkw/crau8Oi7PSxX96tFh7ZjptA5avl1wl5U/j94afjOj2vdRdCIPsitBZ4MClc
	 zq18PFV2wxSL9iBnPN4+XWGeTh36cle8cT1xHFXWbjp9dAv+58rRc9JlRKMG78wYSJITC
	 imMkOzXOpJuXwJOYTyojP54K95tFNsCBiabEKYUoe98RAgQNhMClT6alfYoHg+jaAPn3i
	 w+ZH7v42gzDs8naUO7XriJcA87M4wYdvnTNEog6WGxv+42RvkXBEpzDLQL+0nmS0qvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aovFsUlm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414D3606A8A6
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 18:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aovFsUlm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95BF21F000CA;
	Fri, 20 Nov 2026 18:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795198800;
	bh=uqx3or1h1h4L9qX4ItYti3lGyG1BLDV+xnFoQdBmN2Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aovFsUlm5vcQb0gVuha9+JV4QJOe1th6shjTBPfxuUEB/usfxbpWV1zO519HJP6B+
	 yIBoyehulR11/s+RLsiInHErm83VUyDsqoqeZjeXF2Pshis7jjlQJcgdrGmMSONgGn
	 xVANelDzQ4FOoZToRfDsOGqSW66uh1hzCzTxBN7JE/27na3A2ixKIuhV0gaUHHMh8c
	 XeGpm0yb0OkjHrdIpjAcz3bsSTDP43nS0SR0uyWOs2vnkr2ClJSmOFBveVf0VloHbz
	 fZUtbiAS/LipVmHnPZXoNj6cG5Z4OF0MJSsJ230U37mwfAR2y/PepuVqKE9z7oOpMu
	 XXk8XN7TrUSRQ==
Message-ID: <sashiko-outbox-225798@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 19/60] mm: add folio_is_common_memory() and
 page_is_common_memory()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20261120-private_nodes_v6-v1-19-74f5f9a115c2@gourry.net>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-19-74f5f9a115c2@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:20:00 +0000
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
> N_MEMORY_COMMON decides where ordinary allocations and node-scoped
> services go, but MM services that walk folios reach them through page
> tables, physical addresses or LRU lists, whatever node they are on.
>=20
> Add folio_is_common_memory() and page_is_common_memory() for those
> services. ZONE_DEVICE folios are never common memory, so the helpers
> can replace the folio_is_zone_device() and page_is_zone_device() checks
> those services already make. Following commits convert them.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-private_no=
des_v6-v1-0-74f5f9a115c2@gourry.net?part=3D19

