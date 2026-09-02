Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AC338C415
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 05:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788328761; cv=none; b=sTrBGalFr4x5N+iCigWuqTF2baVyGhz6uRu/YYfU1I9rD2/5d56oGxE1Zz13GS3t5HUtQcDL85lhkJpVxsnzO9r+BSgkuNwo3eb18Nkh8/UH7ViJIWCfCSKg+i18htZ/OaMR3tZBcY+/trFli18NcQsQEGKEoSAh0+msgSeQghQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788328761; c=relaxed/simple;
	bh=3XGR/5VTauMh5w4LDnFT2lYTM8DJ8jn7V0oVaU/jwag=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SNgwkr2TdqnAuyLMU3q5QMhyywVKr2Dvk6Dm+TqMRj8AeMzJR1RU6R4CcGqBd2ABMGwWNZTtn6DazrCgfMVwtKrEI6ccKHF2uRfHvZWN1ZaeP5IohhHmP2zVdazjKiHYX/wqmaxOj4hGMa35xXUGLzE4zDMJwnvEYr9VjBjMj/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GobxTzxk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GobxTzxk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB4B1F000E9;
	Wed,  2 Sep 2026 05:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788328759;
	bh=eLjDz1eX18I7aJEJu+zpAw8gY/oZZ7EL9/ud0J5uJSs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GobxTzxkO5hY0QZLtpfnlsmFibFM3kEBVgH8itKZxrL1efQagD3H4X6UXjrFB6VTr
	 T9vNWtLus2g83wLIo7ew8hy/c0pVwL67vKTb73GBUTySXZk6bUnCXk18KW5Q0IPk6l
	 XcNO1aE6QyxzAq5e8bb/ZCCDBn9xMfDVHTvuqWuRisVQ+fxps8d19Vd903KWYc0ClH
	 QFHd5o+Lk60MdBTOWcK9IBX10kbsahhJoWSM/vs6EBBEGKTaK7CcABD5txSor15cra
	 6exLz1dbIscFEDSGjeMQ2lBGINuFtKld2ai/5GVIV14EfzEZQkm+SMx4SJi45EzzL0
	 hoV+A10ro8fLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/12] mm/damon/sysfs: remove probes number validation
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260902054747.99370-6-sj@kernel.org>
References: <20260902054747.99370-1-sj@kernel.org>
 <20260902054747.99370-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 05:59:19 +0000
Message-Id: <20260902055919.9FB4B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> DAMON sysfs interface is disallowing >DAMON_MAX_PROBES nr_probes input,
> since DAMON_MAX_PROBES is the upper limit of probes per DAMON context.
> The core layer is validating the upper limit again, though.  It is
> preferred to let DAMON API callers such as sysfs interface to set
> parameters in flexible ways, and do parameters validation in the core
> layer.  Drop the duplicated validation in the sysfs interface.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902054747.9937=
0-1-sj@kernel.org?part=3D5

