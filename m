Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794275973;
	b=09JsE0N1vdtn5oDQa7ARjrivdh/Ppk0HYoetJU+tiY2BloCEHKCnEy2CUdwIvSAX8xQO
	 UYQRwu5jxdtoyPLeti790M4T+wWrB90+Ixd6zjWJb8Rjf6GCB9Xok20V/qmVt96PE7z1O
	 bcw9KQQXbizdoRhvkTPX3IccLnvGCG43r+lj2W3TFSDwiUgLR8TRkGa3PnbSBGOxP8MMx
	 T+NugygmQOv9Ndzt6dSHY/tk8Ay0smY6TQWdqJuoaJPrAksGecZlLz3IzPPj/uPzfIS41
	 Q7+5Gqdee7td9+LhzZOzVeaXxwtU3bt2iq3LMwX8tyAmBsa3c+Q8TaB/sAFYrsBK7ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794275973;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eN+mFO/lLitnjL+HyNhRD0bf4zU5yD/npENu/6c7Xo8=;
	b=xIv05CIltpwdDiON7SAlaj+AHMQB3x5PSq+yLhznh/Bdu+h9UEVlFTe1uQglx8+jMlgY
	 4BTL84nNpIZewohNE1/Z2tf+AYoaCA3nzQwx4e85A1HYvrIlqV1RwwnRWczsxjfHF/dBp
	 kmc/AoALwGuRMV65DJ6zeSomQvx/+5ZzvDIqHtTWIrq0zh8lnwiNR699Zk7pe/tYDZLD+
	 h9ni0Zc02bauq/bZ8ifmvUM0OMRYTmslzUGwy5FfgspXAkTXPu6gpipkAidhdAdZsZ7Hx
	 nbCywYytF5amrVAJnkG265ERQKKY+M4CavKwpZ4X5cAmjrucIpyhCjRoWKSz2cYyxLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c5mle5mG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD92A606A325
	for <damon@lists.linux.dev>; Tue, 10 Nov 2026 01:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c5mle5mG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B5D91F0089F;
	Tue, 10 Nov 2026 01:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794275972;
	bh=eN+mFO/lLitnjL+HyNhRD0bf4zU5yD/npENu/6c7Xo8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c5mle5mG4ivQrUecr3i77W/EP+mjJIfZkVMeLpdefeoELev4aymfgmNMG+N3WacNG
	 GKqvsl8RUG6WofQ/Q9QEZOKC7Y2XrTqUtvqWuZnioPXgWyDUo1wf78+R96N27H0nYk
	 w+OZ+4V1aB5zHA3zF9Av2v0iO6Zhs7F0OlgWP83Hd8vQNZgsVoJHbovnuc4Jt9nKXr
	 sKmX/KYh1nv5mfc5al3MeCU+SJLXXUwdP4ZhR050MbisF6XV4NMpVeoZtM09G2Ukmu
	 +FrlrFyoJ7WT3B/Qo3Z80mzLXgEJAZ9xq0NEJR7kUPLOHPTJZzpZhpruR7S4s2xg1b
	 Yrveb6CjUOwcg==
Message-ID: <sashiko-outbox-206011@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] mm: workingset: skip the root memcg flush in
 workingset_test_recent()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joanne Koong" <joannelkoong@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261110015321.611093-4-joannelkoong@gmail.com>
References: <20261110015321.611093-1-joannelkoong@gmail.com>
 <20261110015321.611093-4-joannelkoong@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 01:59:32 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> We can skip the rstat flush in workingset_test_recent() when the
> eviction memcg is the root memcg. lruvec_page_state() now reads the LRU
> sizes of the root memcg from the node counters, which are always up to
> date, and workingset_test_recent() only reads the eviction memcg's own
> lruvec. This avoids an expensive flush on the refault path, as flushing
> the root memcg flushes every memcg in the system.
>=20
> For reclaim however, we still need to keep the flush (for now) since
> global and root reclaim also read the rstat stats of the child memcgs
> they scan, which the flush is needed for in order to keep up to date.
>=20
> On an 80-CPU machine, a root flush took 69us on average with little
> cgroup activity and ~0.9ms with 128 memcgs actively allocating (wall
> time, including waiting for the rstat lock). Reading a node counter
> doesn't add any cost. It took the same amount of time as reading the
> rstat counter (~150ns, which includes bpftrace probe overhead).
>=20
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110015321.6110=
93-1-joannelkoong@gmail.com?part=3D3

