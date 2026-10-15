Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC34E2459CF
	for <damon@lists.linux.dev>; Thu, 15 Oct 2026 18:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792088881; cv=none; b=HCca5UD+uGJBK2nyu/aoG9vBGo1ZnSWTRJCyJbW7X0xqcPwDlb1xDXZJXDZ/2uegn2gIxfQ3PrsvLKiqRJqIZiVsUJLsArVQzVzfUlr8XvSq6Ys6GgH8H/wK4AXTaXOld2Kc+a1O5itNJv1DqmYiToN33xc4Tc/9HhX6jD/2itg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792088881; c=relaxed/simple;
	bh=ObpCI9QxRki/6fHq5qSmOE9NgVvJpswL8TfA6jvB2zw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Xr83ntHYYuFiNSF+nbtlnFP6Y05IWiVvwjAIz/1H0IKxJGHlgncL5OFLgTLy0vGvKjvG6KqbA/C7Mo7PSixUho6WAui0sV0fdjzR3gnFNJa4HkyH+PfRiR3UT3YsBkvjLn0snW5OSR3iRUAVq1gLEhIqPRTEaL0xS9Wezb2jnZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lgRw/GIS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lgRw/GIS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A3D1F000C5;
	Thu, 15 Oct 2026 18:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792088877;
	bh=Hw64zrgrkoXD4Is/hxoloexwS0iye0DRwMY1KEVd5iA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lgRw/GISJFKDoQlrpzdq1/8Q/J4uYDPt5KkAwSjt6E+jweQ1QcMuPYxKQFWHkQK2p
	 AtlThZ2u8Fh27cCpdpdyf8B5C4Zog0gmlA5aLrEqDYrGVBHBjtSq3mUYR+uy4CPiqx
	 e+k3Z1pAkRrVuKV12SF9KpQmXOuJ3YtDnbZn8wnv8T75riK8bH1WxCU/m3P+vwx6Fc
	 +NDMCP5e5GYCiMMN6FPrVjM0gsLcKOH5CwIlcumAz5BSYMDR+wTkz7l/t702iD7xLA
	 c9MSgrDJZqcdW6o7a+UiVpjKIDh8B/imC3cWGfSGL/umOLig+99Ab8vaaJO75CEC1m
	 accUr834zx9SQ==
Message-ID: <sashiko-outbox-173292@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 14/17] mm/mglru: reparent folios from all generations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kairui Song" <kasong@tencent.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261016-mglru-fg-v4-14-2106750c0bfa@tencent.com>
References: <20261016-mglru-fg-v4-0-2106750c0bfa@tencent.com>
 <20261016-mglru-fg-v4-14-2106750c0bfa@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 18:27:56 +0000
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: Kairui Song <kasong@tencent.com>
>=20
> A lockless promotion racing with aging can reuse a generation index,
> see folio_inc_lru_refs().  The retry repairs the folio flags, but
> sort_folio() may have already moved the folio to the list of a
> generation outside the [min_seq, max_seq] window.
>=20
> __lru_gen_reparent_memcg() only splices the lists inside the child's
> window, so such a folio would be left on a list of the dying memcg.
> Splice the lists and move the counters of all MAX_NR_GENS generations
> instead.  Those outside the window are empty in the common case.
>=20
> Assisted-by: LLM
> Signed-off-by: Kairui Song <kasong@tencent.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-mglru-fg-v=
4-0-2106750c0bfa@tencent.com?part=3D14

