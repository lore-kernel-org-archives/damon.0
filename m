Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F6B3A380C;
	Thu,  3 Sep 2026 10:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788431792; cv=none; b=KtM8scHYziNCryM4NOW6IBG1FnugLqy7trl6n1k4/lmrAbG+awLoPyT6KDoFbsdiB4SOFmhIKkvDYwRX/OoIrW28VMPRI6SRX+CvzeNJIICPGDgRD/ZB5D8Ak0X2TKudOY/9cf162wMKRs75iDL8sFUzD86QnyRVPg9WoT3k+S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788431792; c=relaxed/simple;
	bh=NfQ24nQZWZ14j6eFgM/qVA3xLymDzWfm1JX/WXutZmg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C2da2ithqZt7bAhUbZTH9kxEqdDEG76dLu63T56ioiZuy2R7x6YBHzVyrtZtS7/n9ShvfYUMj4wlZ2OprBpM9VAhydmR0BuboQsSu9rRVK3ODdnmzceJHTmDGBi2w1lvXnUYykJguETnOeXEK9jD/0xUzzS4W6dkHySrye3OWEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1olKmzE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1olKmzE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94BD31F00AC4;
	Thu,  3 Sep 2026 10:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788431784;
	bh=NfQ24nQZWZ14j6eFgM/qVA3xLymDzWfm1JX/WXutZmg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l1olKmzEcgtEwn24nX22pg7qT52eV+wrTv5KeppFLTaUVnXmmLXMyw3ya8QU3N41T
	 gjNE7WTYc21aNmYBkuteY+LN1PKTGM6PYnsD1CDReKiPJLLDPoDxhAqCu8HAYCbkV6
	 QuuOXWDdHVaKHfDzFrvlGHBBuNmwU61CA2nRvXVrDCkROZjTNkU/IDNKn5CDrz9Jic
	 bY1nDxziZyugqGrhDsiEauLkMV9iER1Y/oqyBfrLxkNkCgdh7EDCpSje4jcIbijIki
	 zdaP6QGNDT4A6verkJTDyVbwkv7CexGQlbNAu6bY1JTd53pvelGrxuEsYTa22oSQ8S
	 HR5phjOav6P5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/8] mm/kasan: use hw_pte_t for the early shadow PTE
 table
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muhammad Usama Anjum" <usama.anjum@arm.com>
Cc: linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, damon@lists.linux.dev, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260903103002.1091859-7-usama.anjum@arm.com>
References: <20260903103002.1091859-1-usama.anjum@arm.com>
 <20260903103002.1091859-7-usama.anjum@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 10:36:23 +0000
Message-Id: <20260903103623.94BD31F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> kasan_early_shadow_pte is a complete PTE table rather than a software
> PTE value. Declare and define its elements as hw_pte_t so the object uses
> the PTE table storage type.
>=20
> Read the first element through ptep_get(), which returns the software PTE
> value expected by note_page_pte(), instead of accessing hw_pte_t storage
> directly. This also uses the accessor selected by the architecture.
>=20
> No architecture selects ARCH_HAS_HW_PTE_T at this point, so the storage
> representation remains unchanged.
>=20
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903103002.1091=
859-1-usama.anjum@arm.com?part=3D6

