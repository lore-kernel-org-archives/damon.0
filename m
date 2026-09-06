Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E20734F24C
	for <damon@lists.linux.dev>; Sun,  6 Sep 2026 18:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788720956; cv=none; b=UL3DC2NWA+SrHqm/0ueF4P+SFxIrgPmQkhyDJOrxBoY0TG4q+0aImpFvyq4vb0RTtf4dR8Wees31Fr/kzr8yd6UScTa/rAbTtUjVaUbWTS4v8i3YaXOrC20Nrb8FE12MAt0dZfvgl9sUTwvjDXRyf56CQEIcz6aHYJiSXUJW+jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788720956; c=relaxed/simple;
	bh=xZc7QAzwe5hcPnbt8G86T9yvGXwNx+4Aj5oKqKDz1NQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cQ43lbO1ccjbkUqamBpOrhneDUKJD5q3io+k8e4KIMvNo9d49rYULmPpU5jf8rCgp1uL0vIftxpxuyEBzkRLWvICpNWrUQQ2uC+YKRVdt6DinbtXWOKa1uwb4GPS4g8aKXh7krKyVJGzOVTjw97HNtaXsOsW/96WGljX+Mptfgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AALudVNt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AALudVNt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 764ED1F00A3A;
	Sun,  6 Sep 2026 18:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788720954;
	bh=dWHhBE2SpW9ijMemHieVj1nDKKFawxZXF1w35VdUn58=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AALudVNtNLFAgsYpo6nwWHRxeS6MFZ2TlDEsvDYZzRSfgPEJFrwDSToI6azuvy1QO
	 y58geJDwfKIRV20Vz2mf/3E9umPNq0IH8lFX8Ft9O+3HEslYAOfnTH9qgjyhpqkIxa
	 ykZR2zW4Ric2eAKWs+eWLoL5LNh1jQAOH9v8xu6cTqghGfRAz5H0JDyFJJ655GujSY
	 oCpOxUUSzHJlsuLznYaZdSki35rJmXbSNC5HPEbfExEMvKzjFaXRaYDelSnir89+1R
	 wOzJabcDR/llKA34NqFRmpfoI0CsnfFNDFoxk3jGgVz8OahtUq5ZPpY5nGWUlguKDJ
	 m5AndsQMZMzLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] mm/damon/vaddr: support pgidle_unset probe filter
 type
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260906184417.96621-6-sj@kernel.org>
References: <20260906184417.96621-1-sj@kernel.org>
 <20260906184417.96621-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 18:55:54 +0000
Message-Id: <20260906185554.764ED1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> DAMON virtual address space operation set (vaddr) does not support
> pgidle_unset probe filter type.  Add the support.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906184417.9662=
1-1-sj@kernel.org?part=3D5

