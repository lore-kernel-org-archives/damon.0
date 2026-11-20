Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795199381;
	b=2S/irMsM2AZvgyYA514jR9bjf8r98Bl6oz1VB3CRXocZ4/KWfmYk/pqsuM7OMgPB9cRC
	 7i2RjLOpOg1cBqOBxZ1lpvnGES8EpUBxArITfmZer0QWr+BD3fRr0Sy39FdwDFxYEFdY0
	 II6PRiuvABoP1NE485wt5TpPPrLMSHA405aOC7xbvF5uQT0bw3lRhQNz+RPP7yEDqf+UR
	 rCCveKLNe6cwihB8U44OxMFyS4f8By2ZG5NS5M3KVJgodCdLGd6zVUsRUB+XHVh4Hx6Tx
	 axBQpcNeIJZ3J8FxneM1mOT9FZlq8ln9hyfftrmM8k5Q/dAQxub44W4/VN+YdIJufVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795199381;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tz3aJ0ewpwOfqDuqzD6kqsiZuumYWa1eAu91RhJ1/kw=;
	b=Idrj+xDrrwyxqLECsC85+r2o++W3ZX8ee20Om29Q3nhj7R/hPwkYH2PPKAhvL6iCPCqv
	 zWONVOoQTXSicRjhPm4lqwwEOjOoEKHkpYXyH5gRjA+96s+rQyNzUkx54HcZ2VSN/oYHc
	 8PritwA5C1l+RpmlkzsABzxELZNaME+NNSouQgSNnytVC7Ff8iL0cRbswvSYHzl/pVHHy
	 9vs7g8syWkO8Ak9LBuR6uCSUIhombHSmIJyYHt5z235NHM58vsNSUZvCIhSnny6nQmptP
	 m6Y+IAZDHeoM0RXlSPTseuDuVPcFFqyqlUVX/xyS29fSykLo6hp8jZ+C4G5Xybv5pdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XKiXZ58a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939EA60A2604
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 18:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XKiXZ58a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A801F000D2;
	Fri, 20 Nov 2026 18:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795199381;
	bh=tz3aJ0ewpwOfqDuqzD6kqsiZuumYWa1eAu91RhJ1/kw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XKiXZ58a2WwvfA1DTNPtlK4zEDByZy1ryMIilTxGIPzJ75rQBQuyZx2j6itY/PZ7B
	 Aahnby0yNmTQztNcbqL0Y58oNkGagai5YVPu7hOq19K7MbZvSa2XcJwlrv1n9u/9lw
	 xjbg6jLfeC69L7pdF5euAk5e6ZLvjaqOcy7uqrtkMuNntGQ9xMDmt9OHwPtghw5I5+
	 tB0ddz+szYffq4FeQA1aP6+56zXDbVON+FwkpuAXbdl13H5Egf7H4SRQA/FrytHdVm
	 Ib9Y3e7W1wGFDhDdysUDxQ7GNtnTbDbXZIciwWWV/vXaCMLMqaHAWsJk4ql3DWNIqS
	 YiYYStdYW5mwA==
Message-ID: <sashiko-outbox-225830@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 48/60] mm/madvise: restrict reclaim advice to
 reclaim-capable memory
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20261120-private_nodes_v6-v1-48-74f5f9a115c2@gourry.net>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-48-74f5f9a115c2@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:29:40 +0000
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
> MADV_COLD, MADV_PAGEOUT and MADV_FREE reclaim or age folios directly,
> bypassing the node filter reclaim uses, so they act only on common
> memory.
>=20
> Add folio_allows_reclaim(), which requires the folio's node to permit
> reclaim, and use it instead for those advices, including their
> huge-page paths.
>=20
> No behavior change to common nodes.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-private_no=
des_v6-v1-0-74f5f9a115c2@gourry.net?part=3D48

