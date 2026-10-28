Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203040;
	b=yCk8wd4LDrhZ2Cq5tsKaSjdwg2j0PkHVhvyw8FzajOzjPIik81y/A81lgfnP7HZ8SFdB
	 pTsaRCmOKDuRIxcG59cOUpIBIQ4gGR3ApOTcWwi+NdBt6X0UmWfBA5bIltu9lT7yCKOoT
	 j+Joze41gawYwdyUJXdD96/M7Mxjusr59HkWljZ7CADWpT+VRHgA7tM8GALDIaiYsSnSt
	 973mFpXJFRT04t5iYibfl67cfJUgM6gVSjjx2uBPUUyDrke6oQt2x8ogpOCltAbFeNB6+
	 RvxrqSUOt8LXLL0vvWlwTy4WSfN3HeSs3oHcx1IAOhZphPp8ktE11nj4HtagIE/wgsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203040;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nZ2Zn4p2yHay7T05kfjvZMygKmfkQPxVMNiCmR9S0qw=;
	b=hZxxEPPb9b9798MaRlzstr25UfxGxJVhFe5R9noAjGR18f3UAXMjIZvXLNTEt7IaG1og
	 g8auDQ8mPAa2OsqV9trZ6EHXF9/Kx8GvKnpLkxoqephPO4GFXRptmn58PaGatv+SLOSf3
	 1Su8MxCYwvPe9tveiIFxq9rT2ePd8d/9BEQjYWLT+WA+3enDWLq2xUMVGbaXHE6S7ovK2
	 VPkTJ1lAUBHcFA+PJL5V+mP6JyeJyeupX10PhL0G6/w8NRWdKyHItwiGdJ8KegTI++md8
	 /qDBVyn0bqsOeUKWmAquiv+7XQ3GZGWvP/yW6mX3JcIKHE1k3i3mB8hecNbZ4qFf2ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XxvN7kOb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF86606A31E
	for <damon@lists.linux.dev>; Wed, 28 Oct 2026 15:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XxvN7kOb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A0E41F01825;
	Wed, 28 Oct 2026 15:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793203039;
	bh=nZ2Zn4p2yHay7T05kfjvZMygKmfkQPxVMNiCmR9S0qw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XxvN7kObbdXdJlgoan5qHs3TabDUxHGRV09WWC4qI1krFAfCIHYsymJGGKC/N8NF2
	 LFxNYcVaKxCoRrvwc9UEj1iZXyojWrrsNvan/mqLLa/VjlkcVQ44I6TfbDbRyJnRM3
	 QTHH1SdjEK4kyIE4XaT7gGeY0U9JZjFg2DQQJUjkWpR9r1ehmNTpkhgTHc6cMczv2O
	 kO4JRNaPVVx1ek5BrFoHBFoLsQqnW6KiQYNVHsbGWOShDgkXmlmI0ZCbPIlrxsxglk
	 i+n2HZzhjmgsGQXTvTCJA1jkZb5VAPVtUan8V13nk9efAGTN+QH2Bdxq6eSX3dH8/4
	 CuWPDMNeQ+6ZA==
Message-ID: <sashiko-outbox-188104@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon: skip folios already on the migration target
 node
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aveline Noir" <jm5905938@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <179320218513.2.7432933245840036676.damon-same-node-skip@gmail.com>
References: <179320218513.2.7432933245840036676.damon-same-node-skip@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 15:57:18 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> While measuring DAMOS migration overhead, I found that the target_nid
> path isolates folios already on the target node, then puts them back on
> the LRU without migrating them.
>=20
> Skip them before isolation in vaddr and paddr, as the vaddr explicit
> destinations path already does.
>=20
> Signed-off-by: Aveline Noir <jm5905938@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179320218513.2.7432=
933245840036676.damon-same-node-skip@gmail.com?part=3D1

