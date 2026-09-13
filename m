Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F46386568
	for <damon@lists.linux.dev>; Sun, 13 Sep 2026 17:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789319773; cv=none; b=Pf5fzE+8aDkyldT1NXqJuJs+44wAOc9BfGzYmixOZZBsSAJZvpqVe6AukqWeCvxH9zjOl9f07hjgvkZBFXfMNf4PuLlrsJsoG77ePfGE2NreGE7ZOr4ihjGiPupmEE4bDubCNfh2SKqBg9diEXplJtdZN2tyZcJGMPrTex1MrDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789319773; c=relaxed/simple;
	bh=QZ2MqGDMwWVensEVyul4+r5bz7N8CeH5nY3B6sRDo54=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fHrjHbFPQEVGvP8tZfcWLXNhybem8truNm9JG9sQpUkXIehJoJ7eWMSqzHZq+4OLtT78Abm1XrIZF5Wn3Tg+pWOJSec82W05pAb2yLXrWyQ/8FQBkpxTmX1vKjd8YAUvogKWu9/WK9c5t/s5ajZGZtRyhW/yXpqqjgigFtLh0+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6prmfBT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6prmfBT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B871F000FF;
	Sun, 13 Sep 2026 17:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789319771;
	bh=BgVL92Dr8amLb//pk0s6qxjriQEEe1D5TURSpTekeJQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i6prmfBTppYmfcXKj1l9LKjXoa0cvp3O6E2FN/f30lXstZ+Fusyf/leYt/2TBVyq4
	 wW/x6mWo0HTi7W1G55/SzAZF33YA1ubbYHQVHFJ5V8QlMG0rfQU9is/1xmKZSCdJda
	 quzospSUiZOASiHII6w3T76XfbXn8b9pOSfUHsf93Nr2PyB9OOCy/3qniNUe3M4nLS
	 wG2oY1M6/yYA0wgUJn3XiMuuOXkOYFchXIYi/B8Dfc410cfPZSYJNHPiJTH0nx5pow
	 3hINavZ9ddI5yMXGNncLJuzVm6FdnS1KLXbFC9mQl9GT2V5F1TMLsXx0LNqDp1+r7W
	 NZ4LCkM174VCg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 4/8] mm/damon/sysfs: add min,max files under probe
 filter directory
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260913171133.102366-5-sj@kernel.org>
References: <20260913171133.102366-1-sj@kernel.org>
 <20260913171133.102366-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 17:16:10 +0000
Message-Id: <20260913171610.E1B871F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> In future, DAMON sysfs interface will support data attribute probe
> filter types that have range arguments like the newly added
> hugepage_size type filter.  To prepare such supports, add two new DAMON
> sysfs files, min and max, under the probe filter directory.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913171133.1023=
66-1-sj@kernel.org?part=3D4

