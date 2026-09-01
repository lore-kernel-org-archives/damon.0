Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2200D318EC5
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 13:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788269907; cv=none; b=lUQXn/7ig7w1umCYyeAznOYZP20g7ebn04UBUlqVr+TWW+bXd9GMurt43FnGkeNhvMNkjnCQxEOqkCOaUurOiaEHlbOK+RfChmCaX1t60tZ1twpASrfqZcsnyqyJLyO0WxI/GkVatCeuZfP+GhDoWOElLzdEwLSBxgeWF6tjRuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788269907; c=relaxed/simple;
	bh=sBDBCwXRP0sxlEjbcPSNirEwg3xMc5/Kptqw1+f+DIg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FeYeWCSuycCTdwFxHVUiHp8mfTWUrnOgukfPH1d/J8f/DldZCFIjyNK1oIuJ0OLAQnRpe0nVebfsxXFecER3ruviwN8lUP5INayOuddYa6XfAkqXeDSOQXNrOe+qNPzitoc0LNNPalOTJx8hqeQQQUsOdf40gMIcLwPyaqjEhdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTtGF6Mo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTtGF6Mo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A85C1F00A3D;
	Tue,  1 Sep 2026 13:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788269905;
	bh=sBDBCwXRP0sxlEjbcPSNirEwg3xMc5/Kptqw1+f+DIg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CTtGF6MoyLr0/Ay5gAbt+IJo4PeipXyEel0mglCUtsB0nTiM68sudVbnkfcUc8meH
	 F06n1lSQEQssUahGyzJtlFpKcjiigySFQ2PAGIR1pDUuyQ9YpQpzjA/pm/AUbKhlJ5
	 bm4E0b8OYV1iwoQt6QRv/5HYE0WoLacCU6vMcv1IGCftKUhLfLoB0EbRrtCXqZZ9cU
	 o2/zC0gn++HyiAmbnBXPYSJueUxCg7E5kjfc7eonuCOsM0lR6MC9h2Bbf/vEjjEx8L
	 Hq8k+CmkN+oyHAiAABFrJvHhxwNx/gUwA/31udXtHHJowKDemvvHeNNqowWdjYuy3p
	 FvtEzp9fucJnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1.1 14/17] selftests/damon/sysfs.sh: test probe prep
 sysfs files
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260901132506.99243-15-sj@kernel.org>
References: <20260901132506.99243-1-sj@kernel.org>
 <20260901132506.99243-15-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 13:38:25 +0000
Message-Id: <20260901133825.9A85C1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Add basic file operations test for newly introduced DAMON probe prep
> sysfs directories and files.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901132506.9924=
3-1-sj@kernel.org?part=3D14

