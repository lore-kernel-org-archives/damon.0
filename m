Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BAA3D7A0C
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 07:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788937830; cv=none; b=SyYxySYbvOGrfp+Xrvkoj/oePkwqjt+3mFak3vM8duyWlL59EFFgV30jfbkG9xGVX3wpP120YsJ7oMWVx6UA05S9D+4fGfJd0SDfOuprRVCduukb9YoFAgx8/hwMamBRuPsKBU8XVrog04AXo1rWR30LBQLrVqAAL48vjo8lL90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788937830; c=relaxed/simple;
	bh=imXNQcRB7ZkiZo1Gl2AxeZrUoyjAIXTQic3Sf5LclE0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E9JI87NaqHn0C6+3KWI90YLov2uqgUes5IlXlXcTzNtyLb/YC2Z5Y1SbixprjCuK/OURUDqTVYuvj+mk2sH1kpVzFr9PYYvb/cNG8+8cwOsJTCP+uNKPpy+n5j+w2mF1wTh6/XMtOsQ1wEARpW1PUgP/wuMVZdTzvcyT7+PP5Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6h/3dX8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6h/3dX8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA8F1F00A3A;
	Wed,  9 Sep 2026 07:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788937828;
	bh=imXNQcRB7ZkiZo1Gl2AxeZrUoyjAIXTQic3Sf5LclE0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H6h/3dX8wOdRLBsXn8oKdIqBz+kQz6OpyHUIWhf/j4LhuKlI1/Pwr/tLReHIz8noa
	 5rTYH4JG5igswZ2XnI94MSmLkWF0z9E1wROsW2bIAAlNHZA6eI5WYhbuPQt5lcFMSW
	 QbnRj2L1TsSRAy6jgZb0Eiu5gw1y6dG8cSoLt0kR1XTlj3KXHZy/7wg3bWamgYnyQv
	 ZSqIinJpbbd0XWidLB561JbsVEDKGHdpcBvKQw1ox1ulL1GsiqOPRypNz0MJmKwJ08
	 zazmY6vS7+Hz0nRLIYKLjOkf2zjSvPCHcF9/EQLr3ki7gLZ9ZdThuoiwYObPCFkW9B
	 eN1GV4JcD0NPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] mm/damon/tests/core-kunit: improve
 nr_samples_per_aggr test isolation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kunwu Chan" <kunwu.chan@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260909070711.2448346-1-kunwu.chan@gmail.com>
References: <20260909070711.2448346-1-kunwu.chan@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 07:10:27 +0000
Message-Id: <20260909071027.CEA8F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Test the zero sample interval case with a non-zero aggregation
> interval, and keep the zero/zero case to cover the zero-result
> fallback.
>=20
> Also make the overflow case use an explicit sample interval so that
> it does not depend on the zero sample interval fallback.
>=20
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909070711.2448=
346-1-kunwu.chan@gmail.com?part=3D1

