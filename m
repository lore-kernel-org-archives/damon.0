Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0B73B058C
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 04:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788237673; cv=none; b=ZJiJmKGAjHzSwo75OaPABsSutXFSC+fjyoj1iDo+uIRYLWLuJSqtnA9fRdsb8HsojcZHJEnzpdp6avzsFi+OMuw2Z13fKvH092rBYegw/DuGRjA1IX4WNCBv+4M00M5qWevweTI/ZpHi3e+6T+sJszlPFjpPP10dKUVGXFWflEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788237673; c=relaxed/simple;
	bh=Y0KEYFIDAbUoD1JZU2wsgMe4/D1uzkwiodUeNFlfWUQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n0X9eu845bEZEM/FKVYg+G/N4SriqtUb0oIbt3g9fvOcHGD2ueMn+AM7lJE7Pld64uXmcpDsCUon9zNzA8qL9gGEGFbdBe9xRJH0zxjFXE1Ey3ZKPHQCuehfRYMy7/k1zUxWte+kyV8dsN/gNM6nj8XJlkCRS9sdgBzJJ6Fsrq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYaaTMTB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYaaTMTB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F121F000E9;
	Tue,  1 Sep 2026 04:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788237670;
	bh=vKJN6QmKv9z+AGR+Vzm2Ylv2WqZu5ExsQBkDrm8+3xA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QYaaTMTBt3oCSTKpoC7iHJjA36Yu0hPpG/toBrHhL5eVc91qwyNMnGad3vE5+laFT
	 0gJ3Ec44h2zoaSMrdembzbEPg3WgZg6b4u2z+WDLwDSiC6N17OQLgstqDDBLEyFGDc
	 rh9UqANvGR9cKP1bkOzFjPj7kKmaV1dsEBKJLzFtzh33u0HVVNfVISKICMy2EqCqqX
	 3Q/lw2BI8daJymiz3CGJmgobrv2RRx0JQWfJAzUuVv4sL+DdaZw6nB8Xlz9Nk27oe5
	 nSr5PGpqPe7k/zs0mkNErgJtlacutwOVokj6t8DhfmHXOLzFhenJyZn2/cErLPdLSU
	 WeQIdFkUDuhpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/17] mm/damon/paddr: support PGIDLE_UNSET probe filter
 type
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260901043417.2165-3-sj@kernel.org>
References: <20260901043417.2165-1-sj@kernel.org>
 <20260901043417.2165-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 04:41:10 +0000
Message-Id: <20260901044110.B1F121F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Implement support of DAMON_FILTER_TYPE_PGIDLE_UNSET in the physical
> address space DAMON operations set.  It reuses damon_folio_young(),
> which was being used for access monitoring.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901043417.2165=
-1-sj@kernel.org?part=3D2

