Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B942418FDDE
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 13:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788269544; cv=none; b=jC8aiX1voCut5ZjrpEX7LKLTMysTlRcjoC7jjZ/94qWu/sPGnurCEjCCkgOTu5Y9Y9BfFu7FIh1S4Ih2Xn6dJWvnyLhzNlDnkJw+U7PolRn5FigsPYCexLwON151q7+Dy5LGBgvAAhXz9TiTl5GXfmQaTGIVD0xiBlOPH3Zvt9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788269544; c=relaxed/simple;
	bh=1D4UZAfJzUk1BCOm0HT/bt7VfKNPIE7uQIl+j5yMkHI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HqUHr4+ZZHTfpg9jJcDYh0cCwz8Xlj13egHb6hKk8e5GCbQ0u77ENtrUqGrEL9NP56zpVke8qa+QKQHHQcXHO0I9JqX4eZ8hzhTWQJuxJDEuwTXJeN6SUpIBmjRZttatc8zdjSeYSztyCJnQxYy6hcRxSnZY6g6qAFfTl4yuRnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3dTdBuX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3dTdBuX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA2E91F000E9;
	Tue,  1 Sep 2026 13:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788269543;
	bh=lEps8ylrifnAUXZ/UTVACcUbb9Frz28YLKgJxGcq2Cg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f3dTdBuXHYlltr41doXqgmHMdDEsPbeqb4K9bUcNC48vvP1Gv2CdaICL+SUuhV4MQ
	 GlL/HEBGTVW5zNuUm9jDmf/+8psf47p8ljXAmODKnooPt0WYQGh8CkRy/VPu4g8ge1
	 9PKqf0j2Kx9ZH0MYjDwghLQbrWahk2TJUzJ2f5h6VBJzUlBqvQdvPkdwYQNtZIdGrH
	 Hmx/vWkXFFCWgFF4Pv9CyRQ+TBN8RpRzCJ5iUTlmiEKzzAmp0SKn4WRxJ38jfsqsvJ
	 sCX/PdId983H3kd6kI3Xbs3gEBytJIk5XiNPbuAH3PzGDkq9Q+JtqeyTtoadhUhRvQ
	 YQ2aHqpOK0Qpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1.1 08/17] mm/damon/paddr: support damon_prep
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260901132506.99243-9-sj@kernel.org>
References: <20260901132506.99243-1-sj@kernel.org>
 <20260901132506.99243-9-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 13:32:22 +0000
Message-Id: <20260901133222.EA2E91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Implement damon_operations->prep_probes() callback.  Support the only
> existing prep action, DAMON_PREP_SET_PGIDLE in a way similar to what it
> was doing for the access check preparation: unset page table accessed
> bits and set PG_Idle flag.  Reuse the function for the access check
> preparation.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901132506.9924=
3-1-sj@kernel.org?part=3D8

