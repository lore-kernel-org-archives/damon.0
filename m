Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794635885;
	b=2jrzjQVmtzRUyxtVq8OeNDvv5GbXoue8knNHhz34rULAYqZyC19OUvDf/UmoW4D2pKzj
	 OXe9P4xB6SnYEb8NnyUgtd275apNges/mglLRr28Q7Wpdmi6PBF9hc0zmCHSYGX+XP0rJ
	 S5IHVAbCHgSGny1kTuK+5aLBSze1Ar1TLBJabr2YeS19N/sJ2+ejwX1GwbPAy1cBkjUYw
	 2aSymYJPc0jUrrlqRYBE2S++O/mcEd+uWRiW60HIX3i7toxd1qKizuseKnJJWgxblliPc
	 iWmBRN2Ci6/5ZbBIM/b5vktG1nl9sUBXKAU49V8R8WcaU4n3YIY4fHUT2nRJLw8/KIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794635885;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lgn1rU3lql5RrMoBIYz8dKUrfNIXJTC7dGUum+6AKAE=;
	b=v/NJfrs6K6G0sF3Lx6ZI5vurqXvClj+vuaeQKj9hnJc7tcKwaQpFrs/5uMzmVWC0e7Nm
	 gRx2y8O4dP7YFknzhCnJIZiUA9eu1JYFQFBf6nM+aiEIaZyAgUbrBSgcghjnScrujwtEG
	 EUslohnCFpdazvXNXkJiYjY8HYD1yDOLYHcz9dVjoG6AXlSw0vV2uD3xhHKBITW07KjPa
	 r566wBInmuRDA/0ObJ2n1Kpgq48fiMz7hhURrQ/Kl0wgnrWcf8tXFQtLoJmqEBLNmeEM6
	 C6HdkaEhlf9yMVPAX5TSeAnmGqxCIGvcQTMUNWCA/nCDTHasb3NobG7BHDojHU0DBrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bXOGPKox;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AD8606A323
	for <damon@lists.linux.dev>; Sat, 14 Nov 2026 05:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bXOGPKox
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36A11F000C4;
	Sat, 14 Nov 2026 05:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794635885;
	bh=lgn1rU3lql5RrMoBIYz8dKUrfNIXJTC7dGUum+6AKAE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bXOGPKoxs1nUOdIjye3f8I3K/Jv5mwWy5eIRAe29MBhusQ9xSb36HVyg1sFCy3hWK
	 WxoPJ6B4C8VbHdp1AzX2DxpMEKK2oXqZbiqNPJ1Dlx4Pnb4N2GgSET4urwbPVNhzZH
	 WZNkNgdpi3x+/kkga16NMRv0rHMHNBCfsF1kBK5Tpn67iP55hTZ46tSb7Ne5gAqkNv
	 CMVE9eFU3k0ya2D+uR0p+mIFsZlLRqSoRyMP9hSWLBGBXrHZa2H8KFAwOP9XxghWQW
	 GPzQUzFlqIQFpl14mHRl2B5pdohOa24NhIs5HgtWiPzGhKg5mQPyJegLmhvxpGenJ7
	 eZq8f6+RO91Iw==
Message-ID: <sashiko-outbox-214195@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Docs/mm/damon/design: replace "same to" with "same as"
Reply-To: sashiko-reviews@lists.linux.dev
To: "Enze Li" <lienze@kylinos.cn>
Cc: damon@lists.linux.dev
In-Reply-To: <20261114055436.5546-1-lienze@kylinos.cn>
References: <20261114055436.5546-1-lienze@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 05:58:04 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> "same to" is not idiomatic; it should be "the same as" or "same as".
> This doc has six such usages.  Fix all of them at once for consistency.
>=20
> Signed-off-by: Enze Li <lienze@kylinos.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114055436.5546=
-1-lienze@kylinos.cn?part=3D1

