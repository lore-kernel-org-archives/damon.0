Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716A9227EBC
	for <damon@lists.linux.dev>; Tue, 15 Sep 2026 02:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789438925; cv=none; b=m1Ug11UlxzWODkS76HaIeG4MqPaFJwpRs5HeQdIVeC14xWoM8/7jORWm4sKdLGza5N4fYXqgTuMUU6TV3UiZDfKFCWvhQtM5mQmFN0ENeR2UwVCv0DTgybaOL8uya9pm+XQWwsYTcLvagm4TG9mPQq5AfJN1DhivQ8nHgeZ7a8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789438925; c=relaxed/simple;
	bh=U3qddc+kwkiDRBFOIGLwvABOWOQRL6edzPyLVI7SQCM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qkswCO7JvOWNmEAF4Rc3muFc3LD3/sc58MEXz9/H6ibs6ywdo6herF776CUw3ALKTLYuMM0CcVt98/rkZabg8tONJKXRpCxLITNGV0+2fwXFnBLjdRlPuEzCZ3wTBfCjDZdLiPlOvH6yR5UTp4McSNhsdigrCLVnVxIGPqtgC8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kC9I2KCE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kC9I2KCE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF1E31F000FF;
	Tue, 15 Sep 2026 02:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789438924;
	bh=U3qddc+kwkiDRBFOIGLwvABOWOQRL6edzPyLVI7SQCM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kC9I2KCE4RJwVd7EYj1VCzPHav9DD+G/Zfpq/0F0f8ayqJEwMtfmpcHe4GV/SgRuq
	 MeIBxHTZLLmzGgxPOgZWqOJvmUwZX1LFsbl3j0jffosFatf59XMg5Sd3n5qYUSaKba
	 KDinNWUwM2sHxusSMYbRp7xKaCyYdbSmcUuB4foFHbRSgKgm3gs2x9iVXNrHnD7CRH
	 zAsatVCeMmZggHK3qBpXmUeBfcpPG7coTDCYrMKBw0+Wtn/jpEFHEd0x1lv9uIcEJk
	 yr6gxBCSWOaeti47QlRSMCxzrNWT1ExTZN8MPwflFT4WjvzByP8m5no5QmR0d0UWFi
	 hYQXD58i6empQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 3/8] mm/damon/ops-common: support hugepage_size
 damon filter matching
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260915020929.102953-4-sj@kernel.org>
References: <20260915020929.102953-1-sj@kernel.org>
 <20260915020929.102953-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 02:22:03 +0000
Message-Id: <20260915022203.EF1E31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Update ops-common data attribute filter matching logic to support
> hugepage_size filter type.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915020929.1029=
53-1-sj@kernel.org?part=3D3

