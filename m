Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703374A4983
	for <damon@lists.linux.dev>; Fri, 18 Sep 2026 14:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789743381; cv=none; b=pVEYPCPHhVLKxArhnyTBmrkPQao8AdU5zFyPoteXxaaOsx/psziB1HlN+xtPQe6e+EAtr2eHeG6fNBLxBnHHuUr1Ods4wR+jLUh23IMiQWN2kUJECTkzeT9pl6FpzgAdPA60KjwHVHLgcDiFTnqS/wvv495f/cRI5xjW4BlRO/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789743381; c=relaxed/simple;
	bh=9egok18heuhvlc8br53QsHxYHIn1oucFXkQwmvu6X5g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JfjBOC6cBwixm1C5tPem55+6PFOyMmqnkKuX3zHNmbBaQpDV6yJ122VjEjAvffdnFjStIEGpVMz+wi04GducUkzlK89JiGfrWGBGEr9o/qO7jmU9MFQhgsUupmL+H29XeEeSzBOEfNhR/q/ShnkEOtLplyfC5LZ8fkFNGmi0Bic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZjkl0zP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZjkl0zP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E7D1F000FF;
	Fri, 18 Sep 2026 14:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789743379;
	bh=bjOvsrov+7+bZNXcHbWf0hRfZKI2Oca57rHc8s7wx90=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TZjkl0zP/yP1Q5keJqw40ImFk+PxNJrnJLDxLusCORBVoXIeXZL50UxBEKfvmUxnn
	 Z8JW/3CWhqegGWKJWwh+zLX0BwZHPhMrGHR8yTzAOfUA9caumkPGXeZKCVHB0QDfOG
	 1mzxvQz6ukeCRhJFY+TW7e57m10o3btnuJCzCJ5k+/alPF+63I6fqJCWgmddwd7nxH
	 +FMVKzJzyAQPY8UavW5ItbK9WjVJqMt/ZWC4DOI+n3a+9FkMLG4RH+2WRuOtXXOnva
	 n594R8McRKSmSx9ybm6ugW8l0Cth7JJuk2kI5Epjs65h0/jHFL5nyJYjV6MymssFBL
	 gkdkvJt+Fvszw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/7] mm/damon: add complement argument to
 damos_new_quota_goal()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260918142827.85303-3-sj@kernel.org>
References: <20260918142827.85303-1-sj@kernel.org>
 <20260918142827.85303-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 14:56:18 +0000
Message-Id: <20260918145618.E3E7D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damos_quota_goal->complement needs to be manually set by each API
> callers.  It is easy to make mistakes.  Extend the quota goal
> constructor, damos_new_quota_goal() to receive and set the complement
> flag value. Also update all callers to use the new signature.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918142827.8530=
3-1-sj@kernel.org?part=3D2

