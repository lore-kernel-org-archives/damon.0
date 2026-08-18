Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AD54B048C
	for <damon@lists.linux.dev>; Tue, 18 Aug 2026 07:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787036819; cv=none; b=BDoNQlLVW6FcBLZiWtioSLqwfV+0sczoJ6hdTVnCt6Io6lI9pAgkD7fVF0zrd+Nfp4UoQFDRd7/9vnnBTHiZmEwm/8N1KsXIZOs5L17vvO+jHnshSr/VRXUvqByahuIHugJotYV5bSEQUh0NLPuSXnzIMqYUQcjugrlwfSRs/w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787036819; c=relaxed/simple;
	bh=L5stYwIMTm9Kv6uRbLYYo2o3hwLQYwOundlEEBy1Sm0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sANesn0OZvYeBgXUrBSm0JjmtlYjzNgHOGR6pfGRPmmU+mZSADC+FeTxdTjODoQYxBpXk89ykfKbV714yAv9qHcevKS8zIhJhLmgXE/sAOcjyThTV2EPnQYwQ6843jgLTIWocra5qG+QJq2/UaeMmIqd9oiU3vrlYSb4ov5cWws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02B21F00A3A;
	Tue, 18 Aug 2026 07:06:57 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/7] docs/zh_CN: update DAMON design translation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Doehyun Baek" <doehyunbaek@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260818070358.455768-2-doehyunbaek@gmail.com>
References: <20260818070358.455768-1-doehyunbaek@gmail.com>
 <20260818070358.455768-2-doehyunbaek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 07:06:54 +0000
Message-Id: <20260818070657.C02B21F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Update the Chinese translation of .../mm/damon/design.rst.
>=20
> Update the translation through commit c24a7f497cb5
> ("Docs/mm/damon/design: update for DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP").
>=20
> Signed-off-by: Doehyun Baek <doehyunbaek@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818070358.4557=
68-1-doehyunbaek@gmail.com?part=3D1

