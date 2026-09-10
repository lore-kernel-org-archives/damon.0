Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ED449C4B0
	for <damon@lists.linux.dev>; Thu, 10 Sep 2026 14:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050491; cv=none; b=ZRnY3UMUEgk4YAeAZK6UD7Bw1hhsVAseAqoat1vPMbJ+p6MqDQV++zAbN9CypX/Mcfdk3n+sXPisxXrLE7LGJHZlrmDD78jlJaqEbWo5Twp+KELxHfLFsyx6dl9y4C2vjzA5tpFuhezkv1WC7iiUOXOKBEKAG80VamYowwgq9lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050491; c=relaxed/simple;
	bh=4BzvpeFFoYiZaMyrOjQlp19Ei/sh1ELWOJ5eoGq+HLk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FDZWXKAUqpFel9jOK4KG6o6d61aonAyNcPgGcGYwU//cTgWmZH72KVizuclMD94vLQ9sCW7uclHC+p2mFaAQDRWbKuof/y30CEgB2B1r4cIuScrPaCT0AiCIDfYoa0XkHabG5oxR4Iq1HJnY6GaRlssZEfXBAV6Kqg86I6LoE2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFl2GkV0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFl2GkV0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330681F000FF;
	Thu, 10 Sep 2026 14:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789050489;
	bh=u2az/Y+ELKumG1ITZE9bPk4kQ9wUrFLNyfOL4Hx/dtc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TFl2GkV0Ts0FIqzUac2ASh4y0Wfuqkw+v26MJMOYQIwgaGT8uY2snreIyUYmmEMdu
	 coJjxBtOdNUvoLCShteFkVAQak/rUvJn1ve1XC2SNYDaZsV73+bIQyBkSGjsRRyKDE
	 WeyDsmXQQrAcOdlkcMMxBXzbwoOgEhGAsXQijlhSOKnR2I1ExL4j6V9yQY5NmvjETK
	 gsdHHj5Gi00G3xVOSru8SB25bDvmn16Ci2N79ZkGVqVOJB+KYXIN9+ARGLGbSxGk4W
	 SWRGWOg2UI1GIhJG+Ee5hAQdSXxgBRz/ujo7wMaaozqIAgEwYi492VeBAOZcnLwAEh
	 KYQbF5LPigwhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] mm/damon/api: introduce
 DAMON_FILTER_TYPE_PGIDLE_SET
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260910142234.171562-2-sj@kernel.org>
References: <20260910142234.171562-1-sj@kernel.org>
 <20260910142234.171562-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 14:28:08 +0000
Message-Id: <20260910142809.330681F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> DAMON_FILTER_TYPE_PGIDLE_UNSET matches only memory that was able to
> confirm if it is marked as idle.  If the memory cannot be marked as
> idle, it simply doesn't match.  Hence, finding memory that was marked as
> idle with only DAMON_FILTER_TYPE_PGIDLE_UNSET is impossible.  Introduce
> a new filter for the purpose, DAMON_FILTER_TYPE_PGIDLE_SET.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910142234.1715=
62-1-sj@kernel.org?part=3D1

