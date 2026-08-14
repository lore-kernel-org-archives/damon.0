Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E683D1CB5
	for <damon@lists.linux.dev>; Fri, 14 Aug 2026 15:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786719654; cv=none; b=E3gJ/r07S/DStPPi3nmcucZ8gcAz0yN9PtQKTtOVIE2amMe689afyYWvDNpGUCHuu1NJ57j0wED+pYee3g0Gs2wyRGU9J53sVnj6Ab93nyBKdx8PuAIhDJm9FISe3y0gL2e5GRRAkOWRG0UnbHbuY16FPezlcTWVjXeIqNzq3Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786719654; c=relaxed/simple;
	bh=V0gYhT23fetOGcT1HjqFr2q4WCf1l+hBnMHW6JpiAao=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NubaL1WZ2wKPIt4WCWpNpEdDcEGiaFnKuYpOISvvOflFj1G/6a2QbS6P0w9nhqnIStC6Os5qnQQcW4L96k2TFYGhr+poXJWSJKkpy7+HJAF0dAsZa6b2qRpAnvz42Nl/pPfMdF98uWjjN+oCgcP/oVyKiY2bdaOj51iuv+u7ojE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPTeKpTu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPTeKpTu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A561F000E9;
	Fri, 14 Aug 2026 15:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786719649;
	bh=m1IuQ99Rl8MrDRmGCFK0aCQFmypbtvAkeZoUufmRgXM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cPTeKpTuPa6lgDog7Ude4Ps3XatDNADlK6EO1haAUfXHwvDK4HoyI3cMPTQpeAQKG
	 S/QQU7L1RUONwBfn9WliRU3pUBr6GPIWfjTPuJ1RZIRg3Tr2bYcTAJfS2LBzCVOvqh
	 joDlsAuM6MK8rtWysHHbxlw6Cx91tq7VD6UH6Ma1kfV8lIVCTorcFg3V+WiwPdSis8
	 V1LrBebyHA2hPeOgHOgb1ABJAbawit8TdRP0z8Bf9uH/Adow8YmlHRqyUwyfzTS90q
	 x5daEQZq5D8jWNemnwKt81eZAaK/hOe7SoFMttA1YkuOwr5iHnSulu7SWIIGvjNwe3
	 +9wrth9Lqyd7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon/stat: avoid iterating targets in
 damon_stat_sort_regions()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Enze Li" <lienze@kylinos.cn>
Cc: damon@lists.linux.dev
In-Reply-To: <20260814145409.553724-1-lienze@kylinos.cn>
References: <20260814145409.553724-1-lienze@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 15:00:48 +0000
Message-Id: <20260814150049.31A561F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damon/stat module creates only one target in damon_stat_build_ctx(), and
> the comment in damon_stat_sort_regions() already says so.  But the code
> still iterates adaptive_targets with damon_for_each_target(), which is
> needlessly verbose and adds an extra indentation level.
>=20
> Just use list_first_entry() to grab the single target, with a
> list_empty() check to be safe.
>=20
> Signed-off-by: Enze Li <lienze@kylinos.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814145409.5537=
24-1-lienze@kylinos.cn?part=3D1

