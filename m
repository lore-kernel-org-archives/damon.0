Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F3F423E9B
	for <damon@lists.linux.dev>; Wed, 12 Aug 2026 10:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786531332; cv=none; b=DCjWD9oTckd7NUjntMPXGQr+DHnGqV9cweR8aj2fe4WEZJl2YZRg62EfG23QqFHhfnDsLxklUjEw1rSuTYtjbG0+CV2FvaGv8A/40THjW8N2EYNbMeu7tC7ULySxfjVlyekqkQW0bIk2AxJoNrDt3M+7kFOAgVbr/lQI5/qVTlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786531332; c=relaxed/simple;
	bh=asPmKskpbxOXAPWmO7wXEQ6xqDNqsrkgjYsEMWwcEQA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ckmh9EwhRMJk7v1WPrY2yvH33+M2kxfL3LyLuR/Po6V71Tq2g/W/WTjAAf3+VKIjI8jgFpp+fDbSQXoE4wka6Y3yElyR43Y1ne1z68ptGaoqiJHNyYJAe6uJAmhTxJaJ+uFwEKs2upiOnEO6gurEiYevtgDgF1WyKcOYgDZ/UYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/sH5oFk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/sH5oFk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 098D91F000E9;
	Wed, 12 Aug 2026 10:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786531331;
	bh=asPmKskpbxOXAPWmO7wXEQ6xqDNqsrkgjYsEMWwcEQA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N/sH5oFkGrNFIhs8hPDqhGQChZq1jOJPuY1riIycj+UV1kvwL3AhWQ7cTUYEIJCdc
	 s85pNlbvTCTvNn9Mcw4tQhEsGpkyXEApXxzB/3np5deTSd4nF4Sw5P4bxv5gTH/WSs
	 r6T4PM4wlXk9q75FvifUk+1sFMBRQUfb2qPzkJcCz/V1nEiz/wZWs0Xrm8z1Ohvfzt
	 3RF2Jy1Hclv7jRJwIPDMIiyvXrKlae7Q8xEG1ZjdAtsco9QOjyF+ihbxTt03JzxVpe
	 HdMIZHC4KydhnLpybjeQEeZetGflB39njtphirzKI28aS/HFuY21+DCN9i0zrlgt6I
	 KzPK3IX0p/F1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] docs/mm/damon/design: fix typo of
 max_nr_snapshots
Reply-To: sashiko-reviews@lists.linux.dev
To: "Liew Rui Yan" <aethernet65535@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260812104002.15225-4-aethernet65535@gmail.com>
References: <20260812104002.15225-1-aethernet65535@gmail.com>
 <20260812104002.15225-4-aethernet65535@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 10:42:10 +0000
Message-Id: <20260812104211.098D91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Fixes a typo (nr_snapshots -> max_nr_snapshots) and corrects a grammar
> error.
>=20
> Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812104002.1522=
5-1-aethernet65535@gmail.com?part=3D3

