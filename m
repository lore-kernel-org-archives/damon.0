Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9E641441B
	for <damon@lists.linux.dev>; Tue, 13 Oct 2026 03:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791861995; cv=none; b=iajegkr1iPgmes3++MJXo5BXSkx+4bziJeqh5tvsjte7etE8xFkLxqHDBZaoSe394OT0BQOhicxktlQxwHpxWtuHfgMe+rbRIuq9DHQrWSS4OHwSHfpZs0CWusGAIY9dVDCj+BXO9Ot7l8ssGeBvRAtPVDO377AL50zNhRvvCs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791861995; c=relaxed/simple;
	bh=xRqHXRWy0wT5sO5hNhnUFechofQOXVJZ6pLGdNXUvo8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jgyKf2InPeMsVpUfZga2k2pw8O20kOFEmzXbQb1QR+yc+uF+KHfX3eNWIJWxVSBGw0C3Q6AL15QggmqaYHsNCr33d8wzcU8QZr0bw6WPbhLzfjG10nN5rF0VBPdbUkoOZtuFevAI9c7eYT1wqv+5dTlwHax68By0YMhd0hPfiYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=s-joshi.in; spf=pass smtp.mailfrom=s-joshi.in; dkim=pass (2048-bit key) header.d=s-joshi.in header.i=@s-joshi.in header.b=ts/HmB10; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sM+lC7VF; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=s-joshi.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=s-joshi.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=s-joshi.in header.i=@s-joshi.in header.b="ts/HmB10";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sM+lC7VF"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 86980EC0123
	for <damon@lists.linux.dev>; Wed,  7 Oct 2026 11:49:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 07 Oct 2026 11:49:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=s-joshi.in; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1791388160; x=1792252160; bh=EiTz+HuScl259OHLsG+bi
	k5/yWrC5KLt65qfVg2oAYE=; b=ts/HmB10EZBAD+KkRRtqOx7nu01FDPfCQNBQ8
	+iXUQKAqQ5K+XQLO84W0SPoFOPcsaADC3kPrBsBZLVb4dsP1kyjfiqB5ek9ig7hb
	bQlwCkzwrSyx138SDQZIsoAUzjumX/vx9/a93oKiZHqbDeUNbyS4WIjsylb3p513
	gqz+ddZ7UVnF69OjDCuejMmG+09FiowreueqnXjqEOwPRzS1zS4XlLCzz+JI97lB
	Lp9JidRGEfC7DYE2XWZtaW7X9LVNYFKk40gBFYCs43Kp3BLVf5Uw7fD4UErJC++a
	0FNO27cQNvyTD1R4yiNsb6ZpT7ZMMCYWzNcKYTvFOPdV02wzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791388160; x=1792252160; bh=EiTz+HuScl259OHLsG+bik5/yWrC5KLt65q
	fVg2oAYE=; b=sM+lC7VFEOo4IvpMIjrXIXaEDWpVB5XNkHJMjULeJYHkGi8jDx4
	OtpmxjdBg2nHyFDZm87G80C/bzDjlWA8psLluSMeQNKIzA6sr0zp3vFQ4crMopo0
	ymTMrKEXoPYf34BnIcN7GTpjG3UzQGVnJID1TaXR5ueZSvha/UJTl5K9E+ldtNSG
	Z2epzFRuP9lwFWvlD0NPsvzAsCPDJrndLvSQFZGMe5BkXdUNfKazvi32Ay8YHP6U
	9S463+7dZ7FyTNPxymfBnlj999gBu+M8vbMvSgnkjHNg6oWPgaTIRpVfmbLCLqdk
	sQT+ouKHL6AIzORzAy5tItx3RauqeKBYHsw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=s-joshi.in a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791388160; d=s-joshi.in;
	mf=PHN1aGFhc0BzLWpvc2hpLmluPg==;
	rt=PGRhbW9uQGxpc3RzLmxpbnV4LmRldj4=;
	s=fm1:rsa-sha256:RplN1yVeYLzQEPn9rDoICgwj4/TYYwaWimhM/C2PjMWiP4Q
	QjtSOPr0AS7p9VyqzOL5kI26wjC4zsWhQJOAqMuCSxwCYsYE9ZJhuSJHPsTQ2KBQ
	w7RwdtMaJkLd9RtxJTax229ZhGoPbVhZzNPPxkPRExN12r5eHNL69Mb3Glr/vTZy
	0Cgpg6zCIPcqk+dagbmNTmEpbS9mfOFuJdN7fs2h34c76LOCfyiORdIasOPayOAr
	IK/Z7vdjcxYk8PwiDAi+Iuny6R6uQy+PbUTKUvMEnFTt3Wlu2XNAy2WscT3f5tMK
	VDiRx7HW0dojvGZ9mRORwSkQZbBvfPX4hm+OtJQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:oVV34Oz0tZFdkamMwKRLCQvXLTY7P21irI3X3GKRZBM=:xRqHXRWy0wT5sO5hNhnUFechofQOXVJZ6pLGdNXUvo8=;
X-ME-Sender: <xms:AGrGaptX7i0dbchw5uiCS6H5jjpoIKubRJkKNGegv5nmFB2-kay3sQ>
    <xme:AGrGarz-AcJmL_aSKHhdw9uJdWN7LW8U5d8yQm24ouwdD3cZyXNesxzsV2HmMGoIn
    iJo0HK3r5J9qhsbKrIRD2jzAy8yiBgmMX7s_3Xq3Z8HcZY6vIU5ogkF>
X-ME-Received: <xmr:AGrGakAtfKnDhJUvH4CFBVf1UfZcdI4t-B9dkm95tVb8VgcPrif0UlcBRQ>
X-ME-Proxy-Cause: dmFkZTFDtuNAgEWw3iwOyCspoiF8PrY8fLATvghLsLPuIs1EaXXtyY9GaBQwxa+cvT3/64
    ZzU5crLqxDSa+VpXAg6ZA6X4jQSkEEuNvSoiilmFl3CBqGj9KrpuW8CLbonP4MWUX2yA3Y
    /zOymznOoqNhSC7D4cMsfoHpry2Qy8ywZbQZewwdHkIaxzw4E+wS2UzJiIPfibADXmhJaE
    PBXoN9z8/esl0+ItKkuxL+PsVQW41CKw0oQxty17YZ7Uj8lmt6HVAwwqJynqWEHygDIeGZ
    AyRy3Iv7QnrVwRvQQ+hm7Cb7cBBUw/xVVcZy0Gm1lFG+R/fasNHDjxXjjgX4jiHbNX+BDB
    FNxlP8JSKs0JEnI/QedM25V5h+Dd6rbBCYU8ZUMnpvMFbGXwBGSQSTKMbOUA5Dwm0jIAtu
    9zbjskuj+ZUg7DtVy58QZJQYdGTbpn2Qauqr6boeMQjnfAcGLZiXKSp1G3lFPO4i8OEqoo
    udOhN4NHYt7BptthDSpGfXA9D9uM7+7vGouIBMxUtZGgdmYnCWCe4WWNg5suPo1BxgP2lr
    3RCO0Pet7Q9LwtfaUPOUlYOWYYufmW25iR2/zhOfa1RtckPaESi+H5/QEmlv+rIoU9z67a
    wFerjwFvM+kZORzirbiXQtB3No5x2CZr4hW5+M6LOgrm0ljb4706tCI2tMww
X-ME-Proxy: <xmx:AGrGahfjtoDp3ZQ9-bGhc08-Vu6y2SeHAp7-SgOJuno46k31DwqksQ>
    <xmx:AGrGamnRIXfbSytF_YGv-z4FXE8Oitq4yNZJKyX2tSdNtdL6wKqw0g>
    <xmx:AGrGagGEJDXTcqK4euYSuFgtgKlL570nIq4kiijUrpzvTmZNP1g5eA>
    <xmx:AGrGam72VOmvzpPU0asl1z1lOTS8rNrkmRq5Lh6m6TKy8bvXqgUrTg>
    <xmx:AGrGavVEFi0crCK5Xx_UhKQ8WPge2Jzr8s2LsRtYMlz4PevTUte2QIP0>
Feedback-ID: ia9504abf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Oct 2026 11:49:19 -0400 (EDT)
From: Suhaas Joshi <suhaas@s-joshi.in>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	suhaas@s-joshi.in
Subject: [PATCH 0/2] mm/damon/core: Iterate over installed probes instead of DAMON_MAX_PROBES
Date: Wed,  7 Oct 2026 21:18:44 +0530
Message-ID: <20261007154851.45368-1-suhaas@s-joshi.in>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

There were two "todo: " items of the same nature in mm/damon/core.c. Both
of these suggested that we should iterate over only installed probes while
updating (last_)probe_hits[] during merging/splitting regions, instead of
iterating over the entire array, which may have empty/unused indices.

So this patch series does exactly that. It replaces the for-loop over
[0, DAMON_MAX_PROBES) with a damon_for_each_probe() over the probe list of
the context.

These patches are based off mm-new. They pass all KUnit tests related to
damon. I have boot tested (but nothing beyond) on qemu-x86_64. Please do
let me know if I should do any specific tests and link the logs here.

Regards
Suhaas Joshi

Suhaas Joshi (2):
  mm/damon/core: Use only installed probe in damon_merge_two_regions()
  mm/damon/core: Copy only installed probe in damon_split_region_at()

 mm/damon/core.c             | 56 ++++++++++++++++++-------------
 mm/damon/tests/core-kunit.h | 67 +++++++++++++++++++++++++++++++------
 2 files changed, 89 insertions(+), 34 deletions(-)

-- 
2.55.0

