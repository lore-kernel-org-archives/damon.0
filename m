Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350E2353EE0
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 04:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788237392; cv=none; b=JSp7a4i7O+MGCLOoC+5rgrNW/YYNYg/FRLxaNE9sMd/pXOy+UsZAmuTPcEUjtE/OFOkZJahM+5S0uzCSJpjKpEZcQO9d6l/sioEtknhdRsM38uHUbJhv75L6BRjxtPk4OWh0VcfSeeIZ//OOS/HxAXIsND/dD8h/6LsDQBrSD8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788237392; c=relaxed/simple;
	bh=KGeogS4IZ3Mgq6U8eoH6nKj0Lajv0btm/dwC6Uy0+4g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kAkcADDgRaVtt/G/RMK5mOfYkEgrcEgsVHvK88yhzcxZX+m5wckgXwAOSGP0KwgIr50Bhdy0zpilyG7rJzu9G9xpHF5pfyNfArn+nTon7+VAWEqI8bYBaplAAbv2TBByr61w4MgFLI/1CmkSM2FNblUJcDAxHTQD2zqkVok835M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/c5PCnY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/c5PCnY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 976C01F000E9;
	Tue,  1 Sep 2026 04:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788237390;
	bh=KGeogS4IZ3Mgq6U8eoH6nKj0Lajv0btm/dwC6Uy0+4g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l/c5PCnY+FU3Ag7TVLl9+gG87thyFn9g1eXg9P8QNPWQ833ujJLzjbXN6B2g5NpwV
	 zrJ3VjlPUDul9TsSuqGdEMorn2DSZpt+DONjpSt3pUfiXuyAQlNWr0QvQV7AkXSjAR
	 ayp6B6KsSq4/Q1IkPicb89MfIZIv3eZPmce78coUUB/rVFvKJapP3d3KGjKwlIi7Mn
	 5Eb5vqGeeLAE7zAeL95VT9CSYuQZACp9iLzca/dqulP4WJ61B+Qy5TrCHgAMzjFcAQ
	 k2+TYYR/19U7reYg5EUrA7idPE8LwaB/nrN3hQmVitgk2/uRu2Mlz4cyt1BVI6tc6K
	 NNd85XERrLPWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 17/17] Docs/ABI/damon: document probe prep sysfs files
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260901043417.2165-18-sj@kernel.org>
References: <20260901043417.2165-1-sj@kernel.org>
 <20260901043417.2165-18-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 04:36:30 +0000
Message-Id: <20260901043630.976C01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Update DAMON ABI document for the newly added DAMON probe prep sysfs
> files.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901043417.2165=
-1-sj@kernel.org?part=3D17

