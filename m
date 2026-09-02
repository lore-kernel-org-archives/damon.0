Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA7E30F92D
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 05:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788328496; cv=none; b=GB7ARpPisgmMekcGTTlYf3OYaB2MKKpnXdLxEXO5Y7Pl9fmN+MzDueR9d8yU+SrxCFTGo/0w35PhHY+e2KfhXs5S8Q2wPdlrzz4uRS2N4q0Znq3aIiU6eo+g3vJg8bnygR6l3myqG6mKbJFKNcrPLe80iVl2U3PHcbG5V6qeI8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788328496; c=relaxed/simple;
	bh=TXURMYnNq67POJWKdTDJVLDkBea+pWrf1FGhgfq0Szk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X8vlRoQjKKubChh9pX8x23COsSw2/gnuSJVGRUppdxetswM2GyHLIzk9EDtOuX5NIq2W8r4By0ASnxQGMjK7wmUg8XRKvFp+dISCv+a5uT9QTcMi1b+zcwMOj6nMYFKGAVXkzv7GzPMvdoEbS7qM03NginkUvrsDzmClgqUob2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apvWyoPr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apvWyoPr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A801F00A3A;
	Wed,  2 Sep 2026 05:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788328495;
	bh=u3xgEtJNxWU0wMdhlCvR3IU+I6tiH4AAIXcXaSXXKSU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=apvWyoPrRMP7YGmV/Anm0uHPRkUUwTVFSYgKdj1KYST1iF+zBeq98w98hQorqMVqA
	 MUlRLYYTnkdjnx06NOUJfBHxDwdvL905y0fJR9drQrJgVF1r+1xxMijrlvh2LsIhjA
	 3/EHpgZXgJE5m4IvPcNA+Fbwm4oeaD4CJ0YsCbmGhIWwmMSFsYDwRetXfjg4fWkH9X
	 H5Pg2Xo3qIDxl+BF+gXWZGEs34q7OCk+k1TBEcJp+zFuqiHMlOGR664WVf8AY11HBF
	 HQXvvfQlp6GXRCgDBysQd8BRDmq5xC4SxCQYUtUW4L//Ru9qXxSdKYn9iH2t3uZw+s
	 /7mp6wXJcdnew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/12] Docs/mm/damon/maintainer-profile: update AI
 review for Sashiko replies
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260902054747.99370-12-sj@kernel.org>
References: <20260902054747.99370-1-sj@kernel.org>
 <20260902054747.99370-12-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 05:54:54 +0000
Message-Id: <20260902055454.C9A801F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> In the past, sharing Sashiko review results was tedious.  Also it was
> suggested to minimize the recipients on the sharing mails.  Hence the AI
> review section of DAMON maintainer profile document was updated to give
> guidance about available tools for making the sharing easier, and how
> the recipients list should be managed.
>=20
> Now DAMON is onboarded [1] to Sashiko's automatic review replies
> feature.  Sashiko directly sends its reviews as replies to the patch
> mail thread. It also reduces the recipients list to deliver the
> reporting to only the author and the mailing list.
>=20
> Remove the old guidance that is no more necessary but only confusing.
>=20
> [1] https://github.com/sashiko-dev/sashiko/commit/b554c7b6e733
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902054747.9937=
0-1-sj@kernel.org?part=3D11

