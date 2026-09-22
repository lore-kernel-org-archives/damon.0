Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E21C35A395
	for <damon@lists.linux.dev>; Tue, 22 Sep 2026 03:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790048336; cv=none; b=ZCC8Ys8LKbDpuV22aat4RklRMHVtx9UetacULFEa4FbvY46fdBCQiUTNLXw9gQbgFwNUKlRU+c1eClI1vNg1n2KatOeCbs/avTu6Bp3W1FpeaOgVXvL6xMJ4Rap7qNCJDP42e5DGEa/GzkVz5ZDh3nAO00LMmWDf0RzJcgDeFWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790048336; c=relaxed/simple;
	bh=5zIxPy7Dif6d9+U0QDP9H12X2Cypw5w/DGK0+Z0XIW4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eC6gsrcdEUXEsnkWXs+QxrJai/dIBpoq8THOKFcmtsRwm3/Qvr/Cvv/N15SqS9dmb8yVLB/wDScSKBKo5F+pYZnqtcIdRBKkaFm0HfThicZX76APa//3CrSSpXOBqZEJXquFetMf11pFzIKaYzpVfYYIzGXhUc29RWca9TyOeh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPYwDxRA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPYwDxRA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C22E01F000FF;
	Tue, 22 Sep 2026 03:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790048335;
	bh=5zIxPy7Dif6d9+U0QDP9H12X2Cypw5w/DGK0+Z0XIW4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cPYwDxRAGuUpF0/ICm738+06sygGUBreueOejhzITsByzgCn8uQsWUJ/TC5w4ukqs
	 tQEAefMhdwC5J1Ite1OTlK2g9lGBjLCMAOIzuZ07NQwhVwVSDfK+iS7SsDpRRbyAD5
	 kz0qD6/s78/84uZBIIPhJZmhWMJDL1SXV2S+S/gkNtq1eG5vEvs2C1ahPqoWAHmpdR
	 MGtDiYV9QU83o/ULS1291Xupyiebqcq+2jJ0gifXIAM+cFaNYJcx+b3jPayZjzLmti
	 LxLkynSyfgfW46heUxFtiSlUkux6sJI0DwOnV7k2xmMkTH64HpKMi57bipwMiShEee
	 Gn/HcD2h30qHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon: fix typos in comments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhijian Han" <hanzhijian1991@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260922033618.2862687-1-hanzhijian1991@gmail.com>
References: <20260922033618.2862687-1-hanzhijian1991@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 03:38:54 +0000
Message-Id: <20260922033854.C22E01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Fix spelling errors found by codespell in mm/damon/core.c:
>=20
> - "widnow" -> "window"
> - "makrs" -> "marks"
>=20
> No functional changes.
>=20
> Signed-off-by: Zhijian Han <hanzhijian1991@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922033618.2862=
687-1-hanzhijian1991@gmail.com?part=3D1

