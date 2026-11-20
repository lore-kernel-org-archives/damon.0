Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795200034;
	b=IqYuOCPVb2nvmsvLJFFjecRFOTjas+Fbf8YhYhJVyi9NOnUpbUKNbHvN2T+kaRhNWWS1
	 2uUuHVJygis3/mNZFsiIfuxBzV5Z9TnW52Z4aIwDlKmM3sw42c4ulxI6H5Dtfj0J4r99e
	 ryatd4IdDgp6NsaS5/69ZeFTMyIDSCaOXeo+nfxoT0e5Tmj7V51ftXU+Ncd2P7TyX3e5/
	 wozyV09CQNbtE4k9NUwuDcaodheMJNlWWQNDmXOSXIR4FZkpMk/2sQdUQ14JsdlszqOZ9
	 qjo2OlHp7A6nB9ltCxZE5KT/dnC/RJHC3fxm1S0f4iJ6+R3xaU5BPaG/E03rBtVuLcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795200034;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sCmjnspSS/8PAkgUM8UmdX3FI20mYTSUlBX1ozy/XpI=;
	b=YypqEgXvnhdHduBAII5PdlxNJMVDpiZnBo9VnMf6g4jgKILCEjoPqGHJebse6l/AaU7O
	 7Moi05HuEaizN8hHQ4UVrbs8oTOBEy1aoMHQcnro5WeIKcq7HSKiO5U7vv+KBexB1AIg4
	 vrRdmim5rwxLs5KWG4qHQoADYrYtwKbDxqGffNpzX/M4MpUkJ8n5As7gUN11wiyhTLDCX
	 CM6BqeIcwKE/3ixuoKRyG7gGach7/MltSE2NJtIo/rFfVigO8AjX5troJBBbHxsto1yb0
	 oxParsCuy81PFiFvgTmt1L1NyphX6//7h/me5wNbg7fFH6qr7WuQ1LZMPFD9Riu1WDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PhDVA0Mr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD7060A261E
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 18:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PhDVA0Mr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC7111F000C4;
	Fri, 20 Nov 2026 18:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795200034;
	bh=sCmjnspSS/8PAkgUM8UmdX3FI20mYTSUlBX1ozy/XpI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PhDVA0MrawhiH72ZJhJhVD6asNG2UHx5mlZUBiSTBLUEmLKAsqB0E58sbOlrVDrxX
	 qc37g98B5lwVtQsAaKcWjX2pHga85o451nBlaaUh4V0j6KM/qdNY8cmT5g6QJCVlnQ
	 gGQkp14S6fSR7xNKquLhCHJzILQrPqJOHQ2oB39LRRPF+M4Fw4HjQwnBEFSap09s1L
	 EqUlyAwOSnf2Z8j1vuTDKthNIDDXzPYXMDIwCbBVVjQTyG/JsQjop97JNsC36pXiBC
	 2B5OR4HLHqRU46tDn7uOTuy03RTuVc63hMA10mE3kDyDR8KhukqUXPaiCMSINizJsf
	 etZs6CVt8LjrQ==
Message-ID: <sashiko-outbox-225858@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 29/60] mm: keep private memory out of the system memory
 totals
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20261120-private_nodes_v6-v1-29-74f5f9a115c2@gourry.net>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-29-74f5f9a115c2@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:40:33 +0000
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
> totalram_pages() (MemTotal) counts every managed page, and MemFree
> counts every free page, including private memory.
>=20
> Many limits and defaults are sized from totalram_pages():
>   - the overcommit limit
>   - OOM capacity
>   - tmpfs
>   - zswap defaults
>   - others
>=20
> Private memory is not usable by ordinary allocations, so it should
> not inflate these counts.
>=20
> [ ... ]
> Switch them to nr_free_pages() as well.
>=20
> The vmstat counters and per-node meminfo still count private memory.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-private_no=
des_v6-v1-0-74f5f9a115c2@gourry.net?part=3D29

