Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D9D331ED1
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 03:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788925135; cv=none; b=AjWLW0XoEZmH0CXrOuQkj3NuL9sin6BCjT2RvcJHzufcQbEG84b7dTT37Fw9e3xeQl61INKSxXug9ekKAywER+idT4wYbXDz0uA2WutkYwJsbekRZ7wVuTw4CnN9dtszucNRucNKbspgDkFCULmnnc7c8wbbTDhPkeP1H+Afjls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788925135; c=relaxed/simple;
	bh=5vlGbAaBO7+E+r4QMUyrAIAy3Hu0pkUSEs8AEvpmVMM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VBQ91MtHL8M8zof7V+4Gsm8ULcLAKBdoZmDeMbT6dQBYt5OsbU5RqVAXKK6uODsLM52ZBPluy/8PTAP81GIFiqyNbc+4URIaPdv8OKEkYhsiVeqv2U4lSPji0gI7xewas328hGCD2E4zEfvaH6qL47wO0lMTuBe/P5aKrMTaGHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nudn9E9L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nudn9E9L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E4CF1F00A3A;
	Wed,  9 Sep 2026 03:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788925133;
	bh=zGuSORYyfTP4t28+qQE9TcwnwIPTdI3AiXdoqD3Z9ds=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nudn9E9LQS0+jVaUYb5ridseYUPoN6zn8mFGilTji3rez9Vh+LOMhH/IwoHoNgESm
	 SD1XsOYsTppJ3XfW+sM9m70IaKEbFGjUNkjBMpbrLLpN6AtNsIhzrAl3syW5Q1D0ij
	 ctwEFtToZEgNpxgJnE/QfnaMxd3GjzmBggG8L7hqVSod8hrndr6+YDEW58SwOLTTnf
	 AEKZUMetn89fwancCQC/+XRLp5MES3HLl2JDnzVzbWL2fPN+ndYTXcJGtd/E3i7sOj
	 g5VIYlkTE5+C6Nnjq66hhm7IDuYXzh/65Ep1BCGDD57bzFUHEhaNvbMd7emKUQhP0r
	 +FiBqmn7B7xhw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.18.y] mm/damon/sysfs: read addr_unit only once in
 damon_sysfs_apply_inputs()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260909032452.118744-1-sj@kernel.org>
References: <2026090850-untried-sanctity-a00c@gregkh>
 <20260909032452.118744-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 03:38:52 +0000
Message-Id: <20260909033853.6E4CF1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damon_sysfs_apply_inputs() reads addr_unit twice.  It could race with
> addr_unit_store().  As a result, the min_region_sz could wrongly be set
> up.  Read it once.
>=20
> The user impact is trivial.  Sane users ain't update the parameter in
> parallel.  Even if it happens, the DAMON core layer handles the wrong
> min_region_sz (!is_power_of_2()).  Even if somehow the race ended up
> making a min_region_sz that is different from the user's intention but
> still valid, only monitoring itself runs differently than expected.  No
> critical consequences like kernel panic or memory corruption happen.
>=20
> The issue was discovered [1] by Sashiko.
>=20
> Link: https://lore.kernel.org/20260715031002.108504-6-sj@kernel.org
> Link: https://lore.kernel.org/20260714142950.100711-1-sj@kernel.org [1]
> Fixes: 540a2aebc657 ("mm/damon/sysfs: implement addr_unit file under cont=
ext dir")
> Signed-off-by: SJ Park <sj@kernel.org>
> Cc: <stable@vger.kernel.org> # 6.18.x
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit ab4d9358e32316fa39b5f1f5360292135978c3d9)
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909032452.1187=
44-1-sj@kernel.org?part=3D1

