Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB2947253C;
	Wed,  2 Sep 2026 11:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788347187; cv=none; b=o9gZtC8hXPTzwuz7wtmPKIsH9rkPKQZsI2JaAd606cCVJlnYeID+tcFyd2oPnSfc3vZzoeSI4/n5gW1k9taSIX29Y256HFJ0GsJCPNjN7F1+MTpygNy/8Tgn/NYUChGO9wWPjDq7dAQPA01dkCp9WkuN4SJ1LSrlJVc9/pfG/7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788347187; c=relaxed/simple;
	bh=LY9Mr0mI9HtHYU5XaLg8LtcDpo50xhaKBAniNwW8JKc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rIoCStM9hYOFY8BYsB8V5TZcXEhZCy57/Zplp5jjQjqUzHMQ+2CAsbK4eJCjg2NWHCBNr3s+Ue92Fnaf+auj8l4N0ryMu1NINY1xoDx6+CRr4OWasMR0pH+xic9T8M6YdWOkyHbPeBcI0R31Wbu8yb4dQGsennY9EDdJm6f74CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOUWbf2F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOUWbf2F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D7F1F000E9;
	Wed,  2 Sep 2026 11:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788347185;
	bh=LY9Mr0mI9HtHYU5XaLg8LtcDpo50xhaKBAniNwW8JKc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hOUWbf2FlGgJkgURL447pqlZzF3hS1C7jY9OxyAeDpBLQF7Z8z9JpNFXkyP5oCl/4
	 6kWf7bhE6vT063X/0P6BuVLl30ayAExeUwp1Vo5U8dIi8wtsPmbWsPQKeMr21ofBw+
	 E1bfxzt0ly97dmxd+o8heh39DSO6clN6ThvO/0mVTDdsPVTgY8tzGBQya82qp33uC8
	 4vNdpbuqWR7B6TnQxTfqqweZYh0BSuGaLYNb2j1TX1f2zxhSgFoKG6kTvlV46Dmn6V
	 HqU4Lvl0f03gzCmtP7Pnbg9In9Hlk1mxls9yOpLxK6x0yrph8FqcwfKBso6fBF+D5g
	 IeTLYp1WETyTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 03/11] mm/migrate: factor out folio splitting on
 allocation failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shivank Garg" <shivankg@amd.com>
Cc: kvm@vger.kernel.org, "Jeff Layton" <jlayton@kernel.org>, "Chuck Lever" <cel@kernel.org>, damon@lists.linux.dev, dsterba@suse.cz, linux-cxl@vger.kernel.org, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20260902-migrate-refactor-shivank-v1-3-9dcca87669c4@amd.com>
References: <20260902-migrate-refactor-shivank-v1-0-9dcca87669c4@amd.com>
 <20260902-migrate-refactor-shivank-v1-3-9dcca87669c4@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 11:06:24 +0000
Message-Id: <20260902110625.25D7F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> If destination folio allocation fails, migrate_folios_unmap() may split
> a large folio and retry migration with smaller folios. Factor this logic
> out into migrate_folio_split_on_alloc_fail() to simplify the allocation
> failure path.
>=20
> No functional change intended.
>=20
> Signed-off-by: Shivank Garg <shivankg@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902-migrate-re=
factor-shivank-v1-0-9dcca87669c4@amd.com?part=3D3

