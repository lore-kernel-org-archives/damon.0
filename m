Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B236E45C71C;
	Wed,  2 Sep 2026 11:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788346934; cv=none; b=k+EL8CLizcXFnuCGpCs7rrZymFz9ueN82hyoBuJw1n7wuftIdJiOOl2LsBWcG0WM1cHraGvJ4P2U9mu9zoCx2inHVxOzBTOzlRM+Dw8OL8lAHruFq0kMpzJ05QxEioHC25N+Qmc4x3foGWxIpByEexzqEYHFT3BFda93BYTSPD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788346934; c=relaxed/simple;
	bh=MaFKfDwX5mAQb7IS2Am38EeqrRvCrP1g5t2jwfOqh78=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RR3Uq2yg9h7myQzaiCa7nEn9zw+NA8otHo5/3hOkiIDjx7CYtpAQ6uoIafFl6mfDsjgcSCfskGnlUQYLYo03QpC4NtbSiZNi5w6MtX93z/IPvFLy7N5thZPKr6PFgvxp0RrTl7lAJuc3FyoGEFiyWJqq3z8hItUERi2x+uIMe9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3q9rfEy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3q9rfEy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629D31F000E9;
	Wed,  2 Sep 2026 11:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788346931;
	bh=MaFKfDwX5mAQb7IS2Am38EeqrRvCrP1g5t2jwfOqh78=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h3q9rfEyquhBhlp7KXqPdwk2uMyCTMQ2O848UFUF3vw+tu+cbabBHfKey09b6nD4h
	 ceNBvxxoiCM9iIWK/fJ+F0bGmrkghDHaGw+1ynG2Ldwt0Hv8meZvrhemuohgxAkNlZ
	 uK43+K3BGIaguBOW1jMOtz4KC4j57YCeLn0wZ8ZExsDV2zL8lEDbGBIo1EfavR8GGN
	 hLVQUKYwJGQQyEDK0JNpIWWuT/FO4jdgF7awbMIm1H4mj1E9wcv8QrqRNB5yHIjeRp
	 i5JeqsixXhpaWppr9AIRPNvufumgX14UJL5Xt0/2LyM6D0vThfo495qZfkCP5XFUL4
	 KjtozCHxLUSVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 06/11] mm/migrate: rename migrate_pages_batch() to
 migrate_folios_batch()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shivank Garg" <shivankg@amd.com>
Cc: linux-cxl@vger.kernel.org, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>, damon@lists.linux.dev, "Chuck Lever" <cel@kernel.org>, kvm@vger.kernel.org, dsterba@suse.cz
In-Reply-To: <20260902-migrate-refactor-shivank-v1-6-9dcca87669c4@amd.com>
References: <20260902-migrate-refactor-shivank-v1-0-9dcca87669c4@amd.com>
 <20260902-migrate-refactor-shivank-v1-6-9dcca87669c4@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 11:02:10 +0000
Message-Id: <20260902110211.629D31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> migrate_pages_batch() operates on folios and calls the folio-based unmap,
> move and undo helpers. Now that movable_ops-based page migration has been
> separated out, rename it to migrate_folios_batch().
>=20
> No functional changes intended.
>=20
> Suggested-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Shivank Garg <shivankg@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902-migrate-re=
factor-shivank-v1-0-9dcca87669c4@amd.com?part=3D6

