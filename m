Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794958535;
	b=pu/QN92st3JuYPoIeoaQVshE7fPiQb6xQDJdcY+qcPN+bBx57ZfDtsNf8W7Dyd/Bek9X
	 Y60LkU3O2eg3iRdSZkhtArCIF8AHgKWfYi2ySo6q4XvAmDXlq4NfQUuBmX71e4y7qTYYW
	 xh3KIzkL83PgQme/RI2Je0O6BMZf8Q93WK8yRWc06RgvU+eothlcnsFZ/WtLwj18nxbTw
	 KVImEExPox4w+WkGSA3CfDu55ypReuqE2THLAWA3BYr2+hb2Espb4uoNFOMgYP1le3XGz
	 UFTdXL/mMLVcD/5sTHkXkblhP4QZsuoYP3IIR7ySSAxOCEs8Zf/g03zQmcfOoZDgOjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794958535;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gHiDEv+RMw2gRkFiqzt2E08Fhg8g4n4FYP4wjUQJgrY=;
	b=HG7egOgQZ33jJmt0jKQh/cCeqVP6RlXW0JOM8+ZVWGyJfZ6ALVD/sTxn34ejXW+uZGxV
	 bTuYHlri3hnn7atAfhkPGWflVp9nsSSbLDwW5US+GFp+Y5Iu47DgkuG2ZdaviUuVcv2Cl
	 20hWHtKns7zmc/dhYnGauKXWK1PnuopmRK43fGxmvIJ2/YXKjc6DOdGxCPP3ZJlM7upuz
	 k0Fl5WJ9WoaUJXOh7w6WMKZ0bMQaJEC/NyaaCxAK80YtCaY9mucCUGu7xOSWWV5IVHRG8
	 HPNuM58sjfc5IaC2QV3wP7IJhCxl0XvC64V117eHIYtwtjtrIO5dZK93DgYQd+8YICw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="FQA3wh/V";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24D3606A31C
	for <damon@lists.linux.dev>; Tue, 17 Nov 2026 23:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FQA3wh/V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2511F000C4;
	Tue, 17 Nov 2026 23:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794958535;
	bh=gHiDEv+RMw2gRkFiqzt2E08Fhg8g4n4FYP4wjUQJgrY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FQA3wh/VUwurq8mkzb/ODvwEUbUn0LM6YiSAo++CRYGoyz8AzvFWzxC+CBEMZzVnv
	 cq38xB0YdrF/RYy5mnVKlYlTwrNjcB6btc753JsdCHbKSxfVPAYmyodFpr8kxgxcQD
	 fYJ8F6Cy77mwQZcsL4UuJgm5u0d3hK/8GRtbFwjdjrg4YCgQQk8XKpm4mxHh1WI2Pc
	 rqAtrpHxVWcnK4uBLmBkQU9y5WxAvhs5yM6Mg5XUa3+YzRixEOeJ6PpS6G4w3MY6e8
	 GwJABe5iILoCRQQ8bLGKgWiSodXYmXeeif0TTpcgGWLuNbm8KyYEEH9c3pFnHCWf3B
	 ZhlRcgGj+IQzA==
Message-ID: <sashiko-outbox-219801@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/6] mm/damon/core: introduce
 sz_ops_filter_passed_last stat
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mattathias Pinchover" <mattathias.pinchover@uber.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261117-damon-sz-ops-b4-v2-1-439888fa04ac@uber.com>
References: <20261117-damon-sz-ops-b4-v2-0-439888fa04ac@uber.com>
 <20261117-damon-sz-ops-b4-v2-1-439888fa04ac@uber.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 23:35:34 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> From: Mattathias Pinchover <mattathias.pinchover@uber.com>
>=20
> DAMOS stat sz_ops_filter_passed shows the total bytes that passed
> operations layer-handled DAMOS filters, accumulated from the beginning of
> the scheme's execution.  Users who want the amount for only the latest
> apply interval, e.g., the size of a workload's anonymous memory that is
> cold as of now, need to keep the previous values in user space and
> compute the difference with the help of nr_snapshots.  Because
> nr_snapshots is increased once per target per apply interval, the
> computation is complicated and error-prone, especially for contexts
> having multiple targets.
>=20
> Introduce a new DAMOS stat, sz_ops_filter_passed_last.  It is
> updated at the end of each apply interval of the scheme with the amount
> of sz_ops_filter_passed increase in the interval.
>=20
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Mattathias Pinchover <mattathias.pinchover@uber.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-damon-sz-o=
ps-b4-v2-0-439888fa04ac@uber.com?part=3D1

