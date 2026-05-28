Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E55340A5A
	for <damon@lists.linux.dev>; Thu, 28 May 2026 08:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779955886; cv=none; b=HWAoVl3w8DMrDLN12064+kFtg89CRMNvrN9Ure1gSKZlN3j+L+SFfgWAiFnLwu7PeC0iMcoYA9KsihpKjjvwcb7kY8OngW6vKUJRtjSMkGakK1zpPr4UmJomR0jhFtNE4PhaoYMhG6TTgw+j6VEFD/zMR7l8OXtdNjJGOEgyE+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779955886; c=relaxed/simple;
	bh=z3Zv2bw2dBbFiPI+twjo2ZoBJZ2IIZ+jEpLDKiRnPtY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nuTBbDOUQ2KwTfNFqUz6dAaGL4pCQpq497GkyxCr3lasWxNzl/aVrnyKNyTF7+iw6ryHlXO/Zg3WvSM3fiHtdbucqQsUWZduTGINhqgPxyEU2RWpFm2pr/LKssYvwRLvVC9Fnhh/6wWvRetLXKhPOGAkuEc4IAZPMExw3T87KzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Jp+ofhWh; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Jp+ofhWh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1779955855;
	bh=WCwaRPNdzdcd/gd4fVb3UjkXGvISPD9Y/AY9fBD0in4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Jp+ofhWh4EeO8HLt0OyKwamN/NdR5vcVVNcGwWz/N/qh9eFrTNTM2VCkvoIMR/xiV
	 DBhdG9MVaE2y5k+KkP+KIXxiIAHL2MZSxcRLt4FxwyToNv1r8hTJKXlR5hp8rMJkuj
	 ExpOAWNQ3YfxgxEnJaq+luWf1lF0kXrRAfhoBHS8=
X-QQ-mid: esmtpsz17t1779955844t268d210f
X-QQ-Originating-IP: Rx7N/RQOsqKeDzZO6mVRTy6pSf2TJ513olPxFOJZa0o=
Received: from PEN1097 ( [61.183.83.60])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 28 May 2026 16:10:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2854023755336146765
EX-QQ-RecipientCnt: 8
From: niecheng <niecheng1@uniontech.com>
To: sj@kernel.org
Cc: shuah@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@uniontech.com,
	niecheng1@uniontech.com
Subject: [PATCH 0/2] selftests/damon: fix and validate memcg filter memcg_path handling
Date: Thu, 28 May 2026 16:10:37 +0800
Message-ID: <9479D47690DD7F07+20260528081039.1192194-1-niecheng1@uniontech.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NkdVy0O1B8HBDN+4dS35Lw8unz6/WKI6wyblS+3v5211A+yErlmVXR6P
	jCtSnoqeoDZkI1n6nWV/bNrZZ7KdYKIrOGx+7NVMhnljnQtYbAaK8wlwVXyVRELuIr4NXsO
	IbKukelGwD7SDGwWnqtu5NZ3kYE2AHouaZ51q6mUujUXGJpgNAtqOcSRiQ39A9GZ2fuUIX+
	1M8z4sNaWVs6wW9NNmioInLuqsgGCYnuKYgKcaxeHJoVnKdHPEKt2i9K7Qj/xFEdXmSFFJP
	rujPM2vGS4uqkj2nWfPDPSDqW3KqF5N4AGLEtpWVczszQ3EpsERyylBDafjawgrNGjLsLEe
	NW5YbeaypV30E8i72Rf2sU4sf3ndOsD+XhjINZSjjApdVQa3z8yBIQo/+lg8CoB5vVcM+wC
	IVElmXmzNKNCWrs2DnLxlCAMavMT64cL3uN1XQvFX4e5JxXwby295angoyqLoLaKs6lUkqv
	74d4Ys62rEb7wE/BlnqjgwH7JJzWduUJiMzP0HjMkLbdLTaBP77KAZmJCma3TVNoWUfoBy0
	MU2Kn/lr3nkTtELuHzhJJT2lC4xT2codqGazlT8dlro2/ayNeS8WUu3htlZN/KcgZ7ycwfD
	f3eUX7BzKPeTj0Za5UfWqMCx2nl+Ayr2usSONYIs9PUcW7I+4qVe+KvEJ//u39vMqT6q9js
	/0sH6dm/bfLFdOeaz922jNzE68hQ953Tr/dkXEJc08evrGnSIGqVCmwy5gxjAKCszjFcLYa
	k/pP8dXmFAX0svt4q5Pir/USJRFGs5FHgxh4ZDUCIk8htUWXZBK0XQinJO5ywP5c2v5qgED
	bsf5C1NQCjLkZe1zh18LyBtYW5/SLxuPpgEmjrUB1hUleRtw9Nsi5fKBJ8m5D/ysVkbS4z5
	9c4uJ1YLY6zy7c1rm7F7FUFyZ0Zhz01/L9A13QZuHycv+jdbQzwZK/EBkOL0np32Yn2GrD4
	sNrk87xhQshfE0vJd7UdECK4+RWV58VgJ7LBGwcJrA195RZYIGkMISqcM6vu+TdARrCP4sr
	p405dJrU2fEb4qgWlvuj7DbmWev730z5h9eUwe/Ff8MFClTSNNDvjBb3UFm0UY4i5sig3Td
	pCc0RUyD2yM+LiQ3S8mV3f8f6c1vlvbRTXYU963Me8TATc8Znx4EBCyKqhvNf6vRsLFomu8
	ra/77uBwzsu5+bY=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

This series fixes memcg_path handling in DamosFilter and adds memcg
filter validation to the DAMON sysfs selftest.

The first patch fixes DamosFilter so memcg_path is stored as a string
for sysfs staging.  The second patch adds memcg filter validation by
checking the memcg_path sysfs readback.

niecheng (2):
  selftests/damon: fix DamosFilter memcg_path assignment
  selftests/damon: validate memcg filter sysfs readback

 tools/testing/selftests/damon/_damon_sysfs.py |  2 +-
 tools/testing/selftests/damon/sysfs.py        | 13 +++++++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

-- 
2.51.0
