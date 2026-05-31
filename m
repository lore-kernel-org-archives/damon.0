Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593421F12E0;
	Sun, 31 May 2026 17:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780247296; cv=none; b=mFJIgUyPrKYZGPtkdlHKgToKTNXl8/OdU+8lqDWo8h8xvu9QWArsaei6D0vTRKoag2YCViiVRmJFbZVoZb1DKbn0ZQ60TA8ECrySoilFYHv2fusbPc/qLfR/5CdIbvnaQEddrDSIgjKEJ+h980USKtBVTLx6RKIZi3vYmVPKd8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780247296; c=relaxed/simple;
	bh=5K076Fy7q4doSp5njfPcsB9AO/IeFgft+eS5BCwLEN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B5uTUcXG+lk4cTIKj7ZCrxW03S+o+s6LI/DLmISw3sTTbBl1dDsuox0KfYcdHHZ7Xi0lpTMMnFDO/QVz2ywzs+Lkef+x9MMz9Py/RHbInthZz0R6NP5L18VogL4A8fE8pGFFmalYHC6B7sZU8W2G04Q1PSl6zL1IGmg6RxWtKWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T67PVWQC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T67PVWQC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA85D1F00893;
	Sun, 31 May 2026 17:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780247295;
	bh=q0kft5uZTu7IpkVqR8CNYuSgsRuNK2ZGN1ogEISTcwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T67PVWQCsaBBMEvoIVNH5eCFp2G8RFJWaM1NeWF9umI9ALi1cKs6OHZbf/RpzCs51
	 iVZN1/DWiYRMSwp6nNzK7r6ay5bE8FTr7aVI0p252zfLFV8fJQLQf++S8RXta1FqUn
	 WzlH1M/CV9T5wlMGhH/H848kG1aqeZoH14BbC5Gx3mLfvNaFiuSuwetKOLd0OBgVWa
	 bZAehCUUlYhdApZ1F6iOeI/3S+AXsVSErx0eRo+15mIB63JKQNKr/XQZTU7xLM6zKV
	 IgMP9e9aBiwTi2Ae2qyLuDuBGxsMYUQtIKv4bKHDW/HxKDlb1Gns8epCEr4Qq78gG4
	 b1sAB8xU5s43w==
From: SeongJae Park <sj@kernel.org>
To: Kunwu Chan <kunwu.chan@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,
	shuah@kernel.org,
	damon@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: Re: [PATCH 0/5] selftests/damon: misc fixes for test bugs
Date: Sun, 31 May 2026 10:08:06 -0700
Message-ID: <20260531170807.99856-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260531085633.48626-1-kunwu.chan@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 31 May 2026 16:56:28 +0800 Kunwu Chan <kunwu.chan@linux.dev> wrote:

> From: Kunwu Chan <kunwu.chan@gmail.com>
> 
> This series fixes several bugs in the DAMON selftests.  Most are
> trivial but cause tests to silently pass when they shouldn't, or
> fail prematurely on slow machines.

Thank you for sharing these great changes, Kunwu and Lian!

> 
> Patch 1 fixes mutable default arguments in DamonCtx.__init__()
> that cause state to leak between test instances.
> 
> Patch 2 fixes a trailing comma in DamosFilter that turns
> memcg_path from a string into a tuple, silently breaking memcg
> filter setup.
> 
> Patch 3-4 fix bugs in damos_tried_regions.py: wrong operator
> precedence drops the "not met" prefix from failure output, and
> empty early aggregation cycles cause premature test failure.
> 
> Patch 5 fixes several wrong strings that produce dead elif
> branches, skipped file existence checks, and broken dict key
> lookups.

I left comments to each patch.  To summarize,

Patches 1, 3 and 5 look good except signer/author info mismatch.

For patches 2 and 4, I think we need more discussions.


Thanks,
SJ

[...]
