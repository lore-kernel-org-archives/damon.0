Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D81036F8EF
	for <damon@lists.linux.dev>; Thu, 17 Sep 2026 04:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789618092; cv=none; b=jLYgaTKXFgq/GOG2jrsdQSaoONFQ8aAuQbYKGHCdjumsJSZU72A3gfPDssLh1/Z4VO7oX5EbCHcfFCpPAL0qyV4rZRDYngwiKaqIGZ5Q0KCJ2hkhWXLFtURgaJcxHEof4N6iGNLihgOfVxjiklPbWWAJCEY/D1xfeQmDVEVhdfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789618092; c=relaxed/simple;
	bh=2+EIleYzIEil63CG1NVa5E/7kUF3WaL/zt58bgddYTk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FfDYdTSpWOI0KsyIwZTk6SfT+1biEEnnlHTMIKNqsXFjOS90fEbxbULvp8KIdFmEmgOkjWm15n7CzH6cagbe+lQW35rTbc9hPtep+fNCPTgachCsn0YFAIDpoQBbx7qtjOjyi3XsaK+71m4Jr2acEWcUB2xRJiyf+yKSfJG+6Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4/kEc+M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4/kEc+M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D908F1F000FF;
	Thu, 17 Sep 2026 04:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789618091;
	bh=2+EIleYzIEil63CG1NVa5E/7kUF3WaL/zt58bgddYTk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S4/kEc+ME4pZBs4d13pJWxneUimlmX8ZAyPu80E1uY2w3vf8s7y/M5/SD9ncTWIRz
	 rk8fb/68mR0bskIHxk40Hj7uL9UsLd5tROODxl6S4XcgJ7iexLN1RDYZm3c4zIeV/w
	 FZCHqggONZpcsuVyWJyID+9f6jVScRtIYcsoKqv2xfKPz2b+yH4rhMeo3vAByDsWvz
	 FW3JsQSmc7uJ7LJcbfA9HTWNXzVWXKWPsdyPjz5Vra5Ak5X2K8WqzG6rdNq293S1PF
	 hinPcVrFyDzcgclAjFdZ5q1vihxH+Pkvi0hVOGSF/u1X358e+mpBEZVi4bso5qTFG/
	 GJSbrG8gzzFGw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 06/10] mm/damon/paddr: remove pa parameter from
 damon_pa_filter_pass()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260917040537.107341-7-sj@kernel.org>
References: <20260917040537.107341-1-sj@kernel.org>
 <20260917040537.107341-7-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 04:08:10 +0000
Message-Id: <20260917040810.D908F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damon_pa_filter_pass() receives the 'pa' parameter, but doesn't use it.
> Remove the parameter from the function signature.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917040537.1073=
41-1-sj@kernel.org?part=3D6

