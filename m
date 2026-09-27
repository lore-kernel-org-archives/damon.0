Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973BA286D5D
	for <damon@lists.linux.dev>; Sun, 27 Sep 2026 07:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790494202; cv=none; b=ksgvTsTCtEfiesDZptuxu67j0MJYtlSvAYW4No1Pqp/OQQ2llN4TRGLv6E1NpIbeg2tydkzqs23mS0SlXdgEdUsiQCm86E9N+qvT3mIlzrjqBUhG2eqDKcvlIzrm23hXcIeDIahjr3i1CKCnLEaRXlfFdJZ/55ipNb3JTGtyJZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790494202; c=relaxed/simple;
	bh=K5ZeFcdHukUPOzOsLFwBHUk7PVp3pE2tIraCxTagsao=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gl03tHu16NESMXJjaXmMvVtBwAJVc1FBit1gW9B8LqkvtNM1m8eDoUE4FbJJkudZrnHUA8HrEh7SQkN5Z778Mb/9TyWOJLhSQThCitxGjH0MkehAboEBgH9wZ4ASy/SYFT7FpYiC580PwSfI0xJp93brsOhbEziGidUORMSlR0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuS37YBb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuS37YBb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C84491F000FF;
	Sun, 27 Sep 2026 07:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790494201;
	bh=dUXnrHfNisgsvVuf4PEO4RHdExAizdewOFjGmcZw3+w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TuS37YBbfRSgAeOMhzDGTP3ML7LmkZDjFc9tDktKk/UZ/vKSQlSFYT7adTEZDGTlu
	 H5LiqEI2iTWusGN3LLn4SIl3jCQ03sZZwE0YMDD6exPJVJdzWZ0Pats/UPXZJcpJ+M
	 JWyDYj7HcNPBNW87gHKKTHxBLLhtx3fwzfTNbihiJUib5n9LdSMlRXvdBlEEV1lB7i
	 PcWpvpyQxWsWnhw8kqG82eGiKOg+Kqas/63ygtgojFNmzjZDvwsSaOlJ1NwV8mZWxt
	 NbWjIUulYW9OGwoPPlNQDhBw43572kW05Gps+359cl4rd7xFPZM+JI4VlmwJyJwj8k
	 dgXfbn8pppPCg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/4] rust: add bindings for linux/damon.h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Enze Li" <lienze@kylinos.cn>
Cc: damon@lists.linux.dev, gary@garyguo.net, ojeda@kernel.org
In-Reply-To: <20260927072812.2393456-2-lienze@kylinos.cn>
References: <20260927072812.2393456-1-lienze@kylinos.cn>
 <20260927072812.2393456-2-lienze@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 07:29:59 +0000
Message-Id: <20260927073000.C84491F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Include linux/damon.h in bindings_helper.h so that DAMON APIs become
> available to Rust code.  This is in preparation for the DAMON abstractions
> added in the next patch.
>=20
> Signed-off-by: Enze Li <lienze@kylinos.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927072812.2393=
456-1-lienze@kylinos.cn?part=3D1

