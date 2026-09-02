Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780DD30AAD8
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 05:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788328362; cv=none; b=CPzHjVLhnW5KUUWY+K3k9e8SHPOxnXgwoSDuPYIQw0ff72xaA6aULS6/w6rPolgXROS5yRjkifAJFLlE3wwTXEc8jw6K5Whx5qRz1tKiWLx3g29H+slW8B2oSVFp2InceAWCx1C5UmAV0YKkmyPKA5vVGSaf+2qkr4WEmd+2PRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788328362; c=relaxed/simple;
	bh=RIVTKKuVPIpIj6TwDbJ+VP7elOa/fr/Dhzn9qgvO3Kc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IGst02VlDVPb4T45rjtQdppN7tUXmBpx+6jxqzvZv+7itOfNEBECpqwcvyal4/5e0C7YXcuDidL514LexVnoUIgP4eLyQkIoFZdlkYNI54akuNkSjP/XtSdXP3SDBksL7M3IJI1UMinoqrdGY62tcYWbLZc25dM6fsXRkiJZfh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZOCpk9g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZOCpk9g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF49C1F000E9;
	Wed,  2 Sep 2026 05:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788328361;
	bh=/fzIil3xWAjaMz430E6+RV954F6+/OPbIhOQ9nmt1d8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eZOCpk9gsYV42oAFz1rIeJdQyr2JSbhnrdXfFzGalgmH910xZCKKasRCuNTWFRU+G
	 lC+awzAC18cDMcHQcpIatifed+WdexGWa5hQcbsbmKfkbPFS/rPB0WYN5hcfphRg/v
	 uZ7N0KpR1e7aODq514wWXomlMDT+Xw6o5eLViBrzrkfZRiTuPU3IaymMzbOZ9s2Yfg
	 eZYN5dA+jBvJt4q4HSGOxZfr2QPsLxAwCp0LzPB2RvQgXsbkQUJ+3PnzqwmUEab26A
	 74AP/+9dBgzPSQ9f6CEi70wARgeY7sp7P4Cw8e3+6pmkMTULe8rOgD+BKThewkjFP+
	 lJCry7MJ3OyvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/12] mm/damon/tests/core-kunit: test <=0 size
 damon_set_regions() inputs
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260902054747.99370-8-sj@kernel.org>
References: <20260902054747.99370-1-sj@kernel.org>
 <20260902054747.99370-8-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 05:52:40 +0000
Message-Id: <20260902055240.EF49C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Commit 1292c0ecb1ca ("mm/damon/core: validate ranges in
> damon_set_regions()") disallowed passing zero or negative size input
> ranges to damon_set_regions().  Add kunit test cases for those inputs.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902054747.9937=
0-1-sj@kernel.org?part=3D7

