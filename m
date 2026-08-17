Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C395242124C
	for <damon@lists.linux.dev>; Mon, 17 Aug 2026 13:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786971751; cv=none; b=luoLY2kHHA2gIZR5bExqtdR7nVpD5BsDGx5cUAWqYWUZOLsI0+4zPFKFnhojswLGqUBYiYN3aJ0jgEy+PbwCAJV2ug8+e9Eq18lYEw9usHGGdhOYdwuGRZeUW7s1oTG/lNEikzX8faASaR+m91nwQ8AMxKenUvXRhgA79m8E/mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786971751; c=relaxed/simple;
	bh=ubBcDYi6ukw24fyEkamzAhB+sJiD05CyxKBLNtJpaq4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SV4tgH0n/S22WhqfxmdiVKKHERcvTXranx3/b+5Uj5XNtxDmhjwyhHyoc5jfdhUo3ZdmPupQflrgBJhP/dyvmpRUzlZfn0q8ZdGDKWFYTKItXxQVbFGvNPrD9aJWpCzj8Z7BgdHHucz2EeX0far39+uKxr036ubORwVYoTZtiPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrMw76rz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrMw76rz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 637F91F00A3A;
	Mon, 17 Aug 2026 13:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786971750;
	bh=LpJdfb6RCCxEEbtKqd14BZd6FCyfMnlLjAs2+qZjfik=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DrMw76rzP+G1dzl4KUUUCC/lTx/Qh8NKRbo3yrwcQCvZS5IPnYMNYJF8zefP4AjaG
	 /kKQ5u9qM3kUeyADxS5aExhhRc58m2dTVHwlbgrASN6nKBIGyhEW5xNfmUKmlevNyr
	 Uyg+l+JEVUkPBHTRJ1IpJIFUqYQMR23/PBJUKLeejdh2NYUpdOu3HXBVsQzPXQm68j
	 /fCMPbQ4t+SXEMoSr9REkSQvi96OqFVHTawJRGQY9j5OiA/E33DVoxcZh9WzNus/3A
	 i3U/+E+2whUmk1vU7NmoTkO88eIOAOFYPVOvCAHDsE8xnS2qW7REoWusPIh/Du7M/k
	 dTJOWBHFahvtw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon/core: introduce damon_set_target_pid()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Enze Li" <lienze@kylinos.cn>
Cc: damon@lists.linux.dev
In-Reply-To: <20260817125319.888994-1-lienze@kylinos.cn>
References: <20260817125319.888994-1-lienze@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 13:02:29 +0000
Message-Id: <20260817130230.637F91F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> The logic that finds the struct pid for a given pid number and assigns
> it to a damon_target is duplicated in multiple places.  Including
> damon_sysfs_add_target() of mm/damon/sysfs.c and the start functions
> of the two sample modules, samples/damon/wsse.c and
> samples/damon/prcl.c.  Add a function that does the work, and replace
> the duplicated code in the places with calls to the function.
>=20
> Signed-off-by: Enze Li <lienze@kylinos.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817125319.8889=
94-1-lienze@kylinos.cn?part=3D1

