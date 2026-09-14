Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0614825B6
	for <damon@lists.linux.dev>; Mon, 14 Sep 2026 14:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789397494; cv=none; b=jN3OfYoW7uEK8W8v4itUMyBvv2ABSxl1QiSxlEcEgsI9z26mCO5iKXeoQQ2G4cJaXWUpU8CQE0eb82fkYIuH0YagZ5X4sQwzK/ikBZEo4wrEbL8bo/I50jZ+x/WxUvshqmC9Ve8/l649nacH7PkyyfaroUDQhapbxM3Rf0/Wvps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789397494; c=relaxed/simple;
	bh=3Q9xCCUL761S+Edvn6x0JpNaESrUVLi8qru3hyRQMg4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AY4X6WVF3RxteyGZTZtNG0+D7AghXGsQvT3Y7oBY4ixrC51X3mCzbN1g/AZooWekyVr3KP91DOIEj+eF1RwA4SDc9vNfXlbBtVTgshhnyRo7gRZCZrpp1OiMA1yeJba936631/ishKB3R1Hyl5Y1Ma/TJW2W4YZ9Xn+s0EKHlvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XEfbnPnM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEfbnPnM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38CC1F000FF;
	Mon, 14 Sep 2026 14:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789397491;
	bh=Ofl+0W8ylJbsj0WQRoqAAaYsnU81W9fkFf7UAIvw9VI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XEfbnPnMVJtTx/rVjD7trhO071GiurvRI5ppbAIzqknMI2G17imFrtk6grR8Iqo+K
	 e3axLXMjWu5ezWJLFMvLG12y8h7Yk6B5IjaYsDAzmxj0EhRyCbZpt7iJSqeEYd6QzH
	 OhOqF9S3aHjPb3levwmxVJJ5P4G2eqqtthhT5bdW4ADL26jAa7SrtVktPVTXT12QWy
	 pY0zG1zRDVNKlFEjaTuFRJVSHl1PLKqebMBjDMgd270QF6+knPmtHAvWOoJb6Pvg1y
	 rvM2ao3HAsCkYOYuqb81TyhGyOaRPTP11xpZOZjJBUkVsbnIlX1uU2otZnLHkI8HHg
	 qXoxPulKfOanA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 1/8] mm/damon/api: introduce
 DAMON_FILTER_TYPE_HUGEPAGE_SIZE
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260914144448.93732-2-sj@kernel.org>
References: <20260914144448.93732-1-sj@kernel.org>
 <20260914144448.93732-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 14:51:30 +0000
Message-Id: <20260914145130.E38CC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Introduce a new data attribute probe filter type, hugepage_size.  It
> will work for memory that is backed by a hugepage of a given size range.
> Add a new damon_filter_type enum DAMON_FILTER_TYPE_HUGEPAGE_SIZE to
> identify the type.  Add two new fields in the damon_filter struct for
> saving the size range.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914144448.9373=
2-1-sj@kernel.org?part=3D1

