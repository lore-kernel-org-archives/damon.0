Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3697F384CD6
	for <damon@lists.linux.dev>; Tue,  8 Sep 2026 06:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788849556; cv=none; b=lnAjULNY+6xanbubs1yMGZLICzigrStllnJ2flAKFrsZ17ksC9aUo8Th0f9W4bots8ptLX4GkfWNKKA5eS2YWK+gVi7PSij7emDxlEPWnTNxkIMuVghIclXXBfgaJQWwdXpvojQP7BV7M6bLkB5W3dy0Ca7830Hq9jHS/Isp8UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788849556; c=relaxed/simple;
	bh=YfIsaXqpI3nJTdV2wXJTDW5p8SilPkCUUzpmLesdZKg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=desdJqdImAZdM3mhlCYK+lwX3UXKsnsyNe5eGB+z0PI//b7blwj8+Lq/DE/KsZGR35oXNu/HFB3587JPoMn01wsq5FdwEIcDvl/n2vMimUZERFkr6OVs2rtCh1f+0ITZKdbHFnyblyHHJWNNPSnoplhZvo12/CgH2cKiI9qFEfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0jKymOb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0jKymOb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9322C1F00A3D;
	Tue,  8 Sep 2026 06:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788849554;
	bh=YfIsaXqpI3nJTdV2wXJTDW5p8SilPkCUUzpmLesdZKg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m0jKymObrqLR7OGzK7LA4K4sWyOypzWLehJM9/WCIpMLtM+z85lccb9MZsJ8xO2kU
	 eOiihkYGwH1PsBONzN8ekEbjGzbZsfLQ9Y7FLspGRTVd2F4OwQFLbjI8eIvakvVDgs
	 ShUnQtNenGGZcDzYcLKWnBxkgLHEbFNGEehOOtzrJDlJkNYyozlrnXRPfEqL5mEzmY
	 WwBqKKWRI0qU/ZRKTxW8ywj4RpDeTft9Rdln4lEI0FZjQ2/gaFdbtB9ACg6SxKZ8h+
	 xmXcMy17kpbgkAEN8P+L6gTnsrX1hK+QX05KqHq6WtUVsibTxut+Mo9dTltJI9pQT3
	 bzYXcd5VPhChw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon/tests/core-kunit: improve nr_samples_per_aggr
 test isolation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kunwu Chan" <kunwu.chan@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260908063635.2208922-1-kunwu.chan@gmail.com>
References: <20260908063635.2208922-1-kunwu.chan@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 06:39:14 +0000
Message-Id: <20260908063914.9322C1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> The damon_nr_samples_per_aggr() test sets both intervals to zero,
> which exercises two different fallback paths at once.
>=20
> Use separate compound initializers for each case so that each case
> tests one fallback path independently. Also make the overflow case
> use an explicit non-zero sample interval so that it does not depend
> on the zero sample interval fallback.
>=20
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908063635.2208=
922-1-kunwu.chan@gmail.com?part=3D1

